import gleam/io
import gleam/list
import model/property_graph
import model/query_engine
import model/graph_mapper


pub fn main() {
  // Create our sample property graph
  let prop_graph = property_graph.create_graph()

  // Convert it to triple store using our mapper
  let triple_store = graph_mapper.graph_to_triple_store(prop_graph)

  io.println("Original Property Graph Queries:")
  let queries = [
  "cypher \"MATCH (n:Router) RETURN n\"",
  "sparql \"SELECT ?router WHERE {?router rdf:type net:Router}\"",
  ]

  list.map(queries, fn(query_string) {
    io.println("\nExecuting query: " <> query_string)

    case query_engine.parse_query(query_string) {
      Ok(query) -> {
        let result = query_engine.execute_query(query, prop_graph, triple_store)
        io.println("Result:\n" <> result)
      }
      Error(err) -> io.println("Error: " <> err)
    }
  })

  // Demonstrate unified query
  io.println("\nUnified Query Results:")
  let unified_result = query_engine.execute_unified_query(
    query_engine.Nodes("Router"),
    prop_graph
    )
  io.println(unified_result)
}