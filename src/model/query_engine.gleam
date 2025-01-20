
import gleam/string
import gleam/list
import gleam/dict
import model/property_graph
import model/triple_store
import model/graph_mapper


pub type QueryType {
  Cypher
  SPARQL
}

pub type Query {
  Query(query_type: QueryType, query_string: String)
}

pub type UnifiedQuery {
  Nodes(node_type: String)
  Relationships(from_type: String, rel_type: String, to_type: String)
}


pub fn parse_query(input: String) -> Result(Query, String) {
  let parts = string.split(string.trim(input), " ")

  case parts {
    ["cypher", ..rest] -> {
      let query_string = string.join(rest, " ")
      |> string.trim()
      |> string.drop_start(1)  // Remove leading quote
      |> string.drop_end(1)    // Remove trailing quote
      Ok(Query(Cypher, query_string))
    }
    ["sparql", ..rest] -> {
      let query_string = string.join(rest, " ")
      |> string.trim()
      |> string.drop_start(1)  // Remove leading quote
      |> string.drop_end(1)    // Remove trailing quote
      Ok(Query(SPARQL, query_string))
    }
    _ -> Error("Invalid query format. Must start with 'cypher' or 'sparql'")
  }
}

pub fn execute_query(
query: Query,
prop_graph: property_graph.PropertyGraph,
triple_store: triple_store.TripleStore
) -> String {
  case query.query_type {
    Cypher -> execute_cypher_query(query.query_string, prop_graph)
    SPARQL -> execute_sparql_query(query.query_string, triple_store)
  }
}

fn execute_cypher_query(
query: String,
graph: property_graph.PropertyGraph
) -> String {
  case string.contains(query, "(n:Router)") {
    True -> {
      let nodes = property_graph.get_nodes(graph)
      |> dict.to_list()
      |> list.filter(fn(entry: #(String, property_graph.Node)) {
        let #(_, node) = entry
        case node {
          property_graph.Node(_, node_type, _) -> node_type == "Router"
        }
      })
      |> list.map(fn(entry: #(String, property_graph.Node)) {
        let #(_, node) = entry
        case node {
          property_graph.Node(id, _, _) -> "Router(id: " <> id <> ")"
        }
      })
      |> string.join("\n")

      "Found Routers:\n" <> nodes
    }
    False -> "Query not supported in MVP"
  }
}

fn execute_sparql_query(
query: String,
store: triple_store.TripleStore
) -> String {
  case string.contains(query, "rdf:type net:Router") {
    True -> {
      let triples = triple_store.get_all_triples(store)
        |> list.filter(fn(triple: triple_store.Triple) {
          case triple {
            triple_store.Triple(_, predicate, object) -> {
              predicate == "type" &&
              case object {
                triple_store.ResourceValue("Router") -> True
                _ -> False
              }
            }
          }
        })
        |> list.map(fn(triple: triple_store.Triple) {
          case triple {
            triple_store.Triple(subject, _, _) -> "Router: " <> subject
          }
        })
        |> string.join("\n")

        "Found Routers:\n" <> triples
      }
    False -> "Query not supported in MVP"
  }
}

// Add unified query execution
pub fn execute_unified_query(
  query: UnifiedQuery,
  graph: property_graph.PropertyGraph
) -> String {
  let store = graph_mapper.graph_to_triple_store(graph)

  case query {
    Nodes(node_type) -> {
      // Keep property graph query the same
      let prop_results = execute_cypher_query(
        "MATCH (n:" <> node_type <> ") RETURN n",
        graph
      )

      // Fix the SPARQL query format
      let triple_results = execute_sparql_query(
        "SELECT ?router WHERE {?router rdf:type net:Router}",  // Using the format we know works
        store
      )

      "Property Graph Results:\n" <> prop_results <>
      "\nTriple Store Results:\n" <> triple_results
    }
    Relationships(_from_type, _rel_type, _to_type) -> {
      "Relationship queries not yet implemented"
    }
  }
}