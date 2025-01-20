// hybrid_graph_processing_engine.gleam
import gleam/io
import gleam/erlang/process
import model/query_engine
import model/property_graph
import model/graph_mapper
import model/supervision


pub fn main() {
  case supervision.start() {
  Ok(process) -> {
// Create our sample property graph with meaningful telecom network data
let prop_graph = property_graph.create_graph()
let triple_store = graph_mapper.graph_to_triple_store(prop_graph)

io.println("\n=== 1. Demonstrating Hybrid Graph Model ===")

io.println("\nA. Property Graph View (Cypher):")
case query_engine.parse_query("cypher \"MATCH (n:Router) RETURN n\"") {
Ok(query) -> {
let result = query_engine.execute_query(query, prop_graph, triple_store)
io.println(result)
}
Error(err) -> io.println("Error: " <> err)
}

io.println("\nB. Triple Store View with Reified Relationships (SPARQL):")
case query_engine.parse_query("sparql \"SELECT ?router WHERE {?router rdf:type net:Router}\"") {
Ok(query) -> {
let result = query_engine.execute_query(query, prop_graph, triple_store)
io.println(result)
}
Error(err) -> io.println("Error: " <> err)
}

io.println("\n=== 2. Fault Tolerance Demonstration ===")

io.println("\nA. Normal supervised query (showing both graph models):")
case query_engine.parse_query("cypher \"MATCH (n:Router) RETURN n\"") {
Ok(query) -> {
supervision.send_message(process, supervision.ExecuteQuery(query, prop_graph, triple_store))
process.sleep(100)
}
Error(err) -> io.println("Error: " <> err)
}

io.println("\nB. Error handling - simulated query failure:")
case query_engine.parse_query("cypher \"INVALID_QUERY\"") {
Ok(query) -> {
supervision.send_message(process, supervision.ExecuteQuery(query, prop_graph, triple_store))
process.sleep(100)
}
Error(err) -> io.println("Error: " <> err)
}

io.println("\nC. User-triggered error with reified relationship query:")
supervision.send_message(process, supervision.SimulateError("Relationship reification failed"))
process.sleep(100)

io.println("\nD. System recovery demonstration (querying both models again):")
case query_engine.parse_query("sparql \"SELECT ?router WHERE {?router rdf:type net:Router}\"") {
Ok(query) -> {
supervision.send_message(process, supervision.ExecuteQuery(query, prop_graph, triple_store))
process.sleep(100)
}
Error(err) -> io.println("Error: " <> err)
}
}
Error(_err) -> {
io.println("Failed to start supervision system")
}
}
}