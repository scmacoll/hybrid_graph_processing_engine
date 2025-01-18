import model/property_graph
import graph_json
import gleam/io


pub fn main() {
  let graph = property_graph.new()

  let router1 = property_graph.create_node(
    "router_1",
    "Router",
    [#("status", property_graph.StringValue("active"))]
  )

  let router2 = property_graph.create_node(
    "router_2",
    "Router",
    [#("status", property_graph.StringValue("active"))]
  )

  let graph = graph
    |> property_graph.add_node(router1)
    |> property_graph.add_node(router2)

  let connection = property_graph.create_edge(
    "router_1",
    "router_2",
    "CONNECTS_TO",
    [#("bandwidth", property_graph.NumberValue(1000.0))]
  )

  case property_graph.add_edge(graph, connection) {
    Ok(updated_graph) -> {
      io.println("Graph created successfully!\n")
      io.println(graph_json.to_json(updated_graph))
//      io.debug(updated_graph)
      updated_graph
    }
    Error(error) -> {
      io.println("Error creating graph: " <> error)
      graph
    }
  }
}
