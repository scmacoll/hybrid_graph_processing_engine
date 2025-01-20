import model/triple_store
import model/property_graph
import model/graph_serialiser
import model/triple_serialiser
import gleam/io


pub fn main() {
  let graph = property_graph.create_graph()
  io.println("Property Graph created successfully!\n")
  io.println(graph_serialiser.to_json(graph))
  let triples = triple_store.create_graph()
  io.println("Triple store created successfully!\n")
  io.println(triple_serialiser.to_json(triples))
}

