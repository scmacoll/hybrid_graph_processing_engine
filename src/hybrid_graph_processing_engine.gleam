import model/property_graph
import model/graph_serialiser
import gleam/io

pub fn main() {
  let graph = property_graph.create_graph()
  io.println("Graph created successfully!\n")
  io.println(graph_serialiser.to_json(graph))
}

