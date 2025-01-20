import gleam/dict
import gleam/list
import model/property_graph
import model/triple_store

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

pub fn edge_to_triples(edge: property_graph.Edge) -> List(triple_store.Triple) {
  case edge {
  property_graph.Edge(from, to, label, properties) -> {
// Generate proper relationship identifier
let rel_id = "rel_" <> from  // In practice, use UUID

let relationship_triples = [
triple_store.Triple(
subject: rel_id,
predicate: "rdf:type",
object: triple_store.ResourceValue("Relationship")
),
triple_store.Triple(
subject: rel_id,
predicate: "hasSource",
object: triple_store.ResourceValue(from)
),
triple_store.Triple(
subject: rel_id,
predicate: "hasTarget",
object: triple_store.ResourceValue(to)
),
triple_store.Triple(
subject: rel_id,
predicate: "type",
object: triple_store.LiteralString(label)  // Store CONNECTS_TO as type
)
]

// Convert edge properties to triples
let property_triples = dict.to_list(properties)
|> list.map(fn(prop) {
  let #(key, value) = prop
  triple_store.Triple(
subject: rel_id,  // Changed from relationship_node_id to rel_id
predicate: key,
object: property_value_to_triple_value(value)
)
})

list.append(relationship_triples, property_triples)
}
}
}fn property_value_to_triple_value(
value: property_graph.PropertyValue
) -> triple_store.Value {
  case value {
    property_graph.StringValue(s) -> triple_store.LiteralString(s)
property_graph.NumberValue(n) -> triple_store.LiteralNumber(n)
}
}

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