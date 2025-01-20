import gleam/io
import gleam/list
import model/property_graph
import model/triple_store
import model/query_engine


pub fn main() {
  // Create our sample graphs
  let prop_graph = property_graph.create_graph()
  let triple_store = triple_store.create_graph()

  // Example queries
  let queries = [
  "cypher \"MATCH (n:Router) RETURN n\"",
  "sparql \"SELECT ?router WHERE {?router rdf:type net:Router}\"",
  ]

  // Execute each query
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
}