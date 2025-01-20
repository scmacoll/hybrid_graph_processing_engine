import gleam/otp/actor
import gleam/erlang/process
import gleam/option.{None}
import model/query_engine
import model/property_graph
import model/triple_store

// Define the state type for our actors
pub type State {
  State(Nil)
}

// Define our process types
pub type ProcessType {
  QueryProcessor
  GraphTransformer
}

// Message types for our processes
pub type QueryMessage {
  ExecuteQuery(query_engine.Query, property_graph.PropertyGraph, triple_store.TripleStore)
  TransformGraph(property_graph.PropertyGraph)
}

// Start the application and supervise processes
pub fn start() -> Result(process.Subject(QueryMessage), actor.StartError) {
  let selector = process.new_selector()

  // Create actor spec with QueryMessage type
  let spec = actor.Spec(
init: fn() -> actor.InitResult(State, QueryMessage) {
  actor.Ready(State(Nil), selector)
},
loop: handle_message,
init_timeout: 5000
)

actor.start_spec(spec)
}

// Message handler that processes QueryMessages
fn handle_message(msg: QueryMessage, state: State) -> actor.Next(QueryMessage, State) {
  case msg {
  ExecuteQuery(query, prop_graph, triple_store) -> {
let _ = query_engine.execute_query(query, prop_graph, triple_store)
actor.Continue(state: state, selector: None)
}
TransformGraph(_) -> actor.Continue(state: state, selector: None)
}
}

// Send a message to the appropriate process
pub fn send_message(process_type: ProcessType, message: QueryMessage) -> Nil {
  case process_type {
    QueryProcessor -> send_to_query_processor(message)
    GraphTransformer -> send_to_graph_transformer(message)
  }
}

// Placeholder for sending to query processor
fn send_to_query_processor(_message: QueryMessage) -> Nil {
  Nil
}

// Placeholder for sending to graph transformer
fn send_to_graph_transformer(_message: QueryMessage) -> Nil {
  Nil
}