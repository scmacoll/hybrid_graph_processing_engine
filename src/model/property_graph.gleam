import gleam/dict


// Property value type
pub type PropertyValue {
  StringValue(String)
  NumberValue(Float)
}

// Properties are stored in a dictionary
pub type Properties =
dict.Dict(String, PropertyValue)

// Node structure
pub type Node {
  Node(
  id: String,
  node_type: String,
  properties: Properties,
  )
}

// Edge structure
pub type Edge {
  Edge(
  from: String,
  to: String,
  label: String,
  properties: Properties,
  )
}

// Main property graph structure
pub opaque type PropertyGraph {
  PropertyGraph(
  nodes: dict.Dict(String, Node),
  edges: List(Edge),
  )
}

// Constructor for new empty graph
pub fn new() -> PropertyGraph {
  PropertyGraph(nodes: dict.new(), edges: [])
}

// Add a node to the graph
pub fn add_node(graph: PropertyGraph, node: Node) -> PropertyGraph {
  let PropertyGraph(nodes, edges) = graph
  PropertyGraph(
  nodes: dict.insert(nodes, node.id, node),
  edges: edges,
  )
}

// Add an edge to the graph
pub fn add_edge(graph: PropertyGraph, edge: Edge) -> Result(PropertyGraph, String) {
  let PropertyGraph(nodes, edges) = graph

  case dict.has_key(nodes, edge.from), dict.has_key(nodes, edge.to) {
    True, True -> Ok(PropertyGraph(nodes, [edge, ..edges]))
    _, _ -> Error("Source or target node does not exist")
  }
}

// Helper to create a new node
pub fn create_node(
id: String,
node_type: String,
properties: List(#(String, PropertyValue))
) -> Node {
  Node(
  id: id,
  node_type: node_type,
  properties: dict.from_list(properties)
  )
}

// Helper to create a new edge
pub fn create_edge(
from: String,
to: String,
label: String,
properties: List(#(String, PropertyValue))
) -> Edge {
  Edge(
  from: from,
  to: to,
  label: label,
  properties: dict.from_list(properties)
  )
}

// Accessor functions for opaque PropertyGraph
pub fn get_nodes(graph: PropertyGraph) -> dict.Dict(String, Node) {
  let PropertyGraph(nodes, _) = graph
  nodes
}

pub fn get_edges(graph: PropertyGraph) -> List(Edge) {
  let PropertyGraph(_, edges) = graph
  edges
}

pub fn create_graph() -> PropertyGraph {
  let graph = new()

  let router1 = create_node(
  "router_1",
  "Router",
  [#("status", StringValue("active"))]
  )

  let router2 = create_node(
  "router_2",
  "Router",
  [#("status", StringValue("active"))]
  )

  let graph = graph
  |> add_node(router1)
  |> add_node(router2)

  let connection = create_edge(
  "router_1",
  "router_2",
  "CONNECTS_TO",
  [#("bandwidth", NumberValue(1000.0))]
  )

  case add_edge(graph, connection) {
    Ok(updated_graph) -> updated_graph
    Error(_) -> graph
  }
}