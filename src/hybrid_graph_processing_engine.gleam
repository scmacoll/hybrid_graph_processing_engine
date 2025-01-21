// hybrid_graph_processing_engine.gleam
import gleam/io
import gleam/list
import gleam/dict
import gleam/set
import gleam/erlang/process
import model/query_engine
//import model/property_graph
import model/property_graph.{type Edge}
import model/graph_mapper
import model/supervision
import model/connected_components


pub fn main() {
  case supervision.start() {
  Ok(process) -> {
// Create our sample property graph with meaningful telecom network data
let prop_graph = property_graph.create_large_graph()
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


io.println("\n=== 3. Connected Components Analysis ===")

io.println("\nA. Initial Graph Components:")
let components = connected_components.find_components(prop_graph)
io.println(connected_components.format_components(components))

io.println("\nB. Removing a bridge edge (router_4 -- router_5):")
let edges = property_graph.get_edges(prop_graph)
let filtered_edges = list.filter(
edges,
fn(edge) {
case edge {
property_graph.Edge(from, to, _, _) -> {
case from, to {
"router_4", "router_5" -> False
"router_5", "router_4" -> False
_, _ -> True
}
}
}
}
)

// Create new graph with edge removed
let graph_without_bridge = property_graph.new()
|> fn(g) {
let nodes = property_graph.get_nodes(prop_graph)
dict.fold(
nodes,
g,
fn(graph, _key, node) { property_graph.add_node(graph, node) }
)
}
|> fn(g) {
list.fold(
filtered_edges,
g,
fn(graph, edge) {
case property_graph.add_edge(graph, edge) {
Ok(updated) -> updated
Error(_) -> graph
}
}
)
}

let components_after = connected_components.find_components(graph_without_bridge)
io.println(connected_components.format_components(components_after))

// In hybrid_graph_processing_engine.gleam

io.println("\nC. Restoring bridge edge to demonstrate recovery:")
let restored_graph = property_graph.new()
|> fn(g) {
let nodes = property_graph.get_nodes(prop_graph)
dict.fold(
nodes,
g,
fn(graph, _key, node) { property_graph.add_node(graph, node) }
)
}
|> fn(g) {
// Add back all original edges including the bridge
let original_edges = property_graph.get_edges(prop_graph)
list.fold(
original_edges,
g,
fn(graph, edge) {
case property_graph.add_edge(graph, edge) {
Ok(updated) -> updated
Error(_) -> graph
}
}
)
}

io.println("\nD. Final topology analysis after recovery:")
let components_final = connected_components.find_components(restored_graph)
io.println(connected_components.format_components(components_final))

// Verify topology is fully restored
io.println("\nE. Topology verification:")
let verification = case components_final {
[single_component] -> {
// We need to convert the set to a list to check its size
let size = set.size(single_component)
case size {
6 -> "✓ Network fully restored - all nodes in single component"
_ -> "! Warning: Network not fully restored (unexpected component size)"
}
}
_ -> "! Warning: Network not fully restored (multiple components remain)"
}
io.println(verification)

}
Error(err) -> io.println("Error: " <> err)
}
}
Error(_err) -> {
io.println("Failed to start supervision system")
}
}
}