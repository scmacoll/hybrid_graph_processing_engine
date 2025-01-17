import model/property_graph
import gleam/io


//pub fn main() {
//  io.println("Hello, Gleam!")
//}


pub fn main() {
  // Create a new empty graph
  let graph = property_graph.new()

  // Create router nodes
  let router1 = property_graph.create_node(
    "router_1",
    "Router",
    [
      #("status", property_graph.StringValue("active")),
      #("ip", property_graph.StringValue("192.168.1.1")),
      #("load", property_graph.NumberValue(0.75)),
    ]
  )

  let router2 = property_graph.create_node(
    "router_2",
    "Router",
    [
      #("status", property_graph.StringValue("active")),
      #("ip", property_graph.StringValue("192.168.1.2")),
      #("load", property_graph.NumberValue(0.60)),
    ]
  )

  // Add nodes to graph
  let graph = graph
    |> property_graph.add_node(router1)
    |> property_graph.add_node(router2)

  // Create connection between routers
  let connection = property_graph.create_edge(
    "router_1",
    "router_2",
    "CONNECTS_TO",
    [
      #("bandwidth", property_graph.NumberValue(1000.0)),
      #("protocol", property_graph.StringValue("BGP")),
    ]
  )

  // Add edge to graph and handle the Result
  case property_graph.add_edge(graph, connection) {
    Ok(updated_graph) -> {
      io.println("Graph created successfully!")
      updated_graph
    }
    Error(error) -> {
    io.println("Error creating graph: " <> error)
    graph
    }
  }
}