import gleam/string
import gleam/list
import gleam/float
import gleam/dict
import model/property_graph

pub fn to_json(graph: property_graph.PropertyGraph) -> String {
  let nodes = property_graph.get_nodes(graph)
  let edges = property_graph.get_edges(graph)

  let nodes_json = dict.to_list(nodes)
  |> list.map(fn(entry) {
    let #(_, node) = entry
    node_to_json(node)
  })
  |> string.join(", ")

  let edges_json = list.map(edges, edge_to_json)
  |> string.join(", ")

  "{\n" <>
  "  \"nodes\": [" <> nodes_json <> "],\n" <>
  "  \"edges\": [" <> edges_json <> "]\n" <>
  "}"
}

fn node_to_json(node: property_graph.Node) -> String {
  let #(id, node_type, properties) = case node {
    property_graph.Node(id, node_type, properties) -> #(id, node_type, properties)
  }

  let props_json = dict.to_list(properties)
  |> list.map(property_to_json)
  |> string.join(", ")

  "{\n" <>
  "    \"id\": \"" <> id <> "\",\n" <>
  "    \"type\": \"" <> node_type <> "\",\n" <>
  "    " <> props_json <> "\n" <>
  "  }"
}

fn edge_to_json(edge: property_graph.Edge) -> String {
  let #(from, to, label, properties) = case edge {
    property_graph.Edge(from, to, label, properties) -> #(from, to, label, properties)
  }

  let props_json = dict.to_list(properties)
  |> list.map(property_to_json)
  |> string.join(", ")

  "{\n" <>
  "    \"from\": \"" <> from <> "\",\n" <>
  "    \"to\": \"" <> to <> "\",\n" <>
  "    \"label\": \"" <> label <> "\",\n" <>
  "    " <> props_json <> "\n" <>
  "  }"
}

fn property_to_json(prop: #(String, property_graph.PropertyValue)) -> String {
  let #(key, value) = prop
  "\"" <> key <> "\": " <>
  case value {
    property_graph.StringValue(s) -> "\"" <> s <> "\""
    property_graph.NumberValue(n) -> float.to_string(n)
  }
}