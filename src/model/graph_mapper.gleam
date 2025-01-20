import gleam/dict
import gleam/list
import model/property_graph
import model/triple_store

// Convert a property graph node to triples
pub fn node_to_triples(node: property_graph.Node) -> List(triple_store.Triple) {
  case node {
  property_graph.Node(id, node_type, properties) -> {
// Create type triple
  let type_triple = triple_store.Triple(
    subject: id,
    predicate: "type",
    object: triple_store.ResourceValue(node_type)
)

// Convert properties to triples
let property_triples = dict.to_list(properties)
  |> list.map(fn(prop) {
    let #(key, value) = prop
    triple_store.Triple(
      subject: id,
      predicate: key,
      object: property_value_to_triple_value(value)
      )
  })

[type_triple, ..property_triples]
}
}
}

// Convert a property graph edge to triples
pub fn edge_to_triples(edge: property_graph.Edge) -> List(triple_store.Triple) {
  case edge {
  property_graph.Edge(from, to, label, properties) -> {
// Create main relationship triple
let relation_triple = triple_store.Triple(
subject: from,
predicate: label,
object: triple_store.ResourceValue(to)
)

// Convert edge properties to triples using a reified approach
let edge_id = from <> "_" <> label <> "_" <> to
let property_triples = dict.to_list(properties)
|> list.map(fn(prop) {
  let #(key, value) = prop
  triple_store.Triple(
subject: edge_id,
predicate: key,
object: property_value_to_triple_value(value)
)
})

[relation_triple, ..property_triples]
}
}
}

// Helper to convert property values to triple values
fn property_value_to_triple_value(
value: property_graph.PropertyValue
) -> triple_store.Value {
  case value {
    property_graph.StringValue(s) -> triple_store.LiteralString(s)
property_graph.NumberValue(n) -> triple_store.LiteralNumber(n)
}
}

// Convert entire property graph to triple store
pub fn graph_to_triple_store(graph: property_graph.PropertyGraph) -> triple_store.TripleStore {
  let store = triple_store.new()

  // Convert nodes
  let store = property_graph.get_nodes(graph)
  |> dict.values()
  |> list.map(node_to_triples)
  |> list.flatten()
  |> list.fold(store, triple_store.add_triple)

  // Convert edges
  let store = property_graph.get_edges(graph)
  |> list.map(edge_to_triples)
  |> list.flatten()
  |> list.fold(store, triple_store.add_triple)

  store
}