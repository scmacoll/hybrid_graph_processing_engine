import gleam/otp/actor
import gleam/erlang/process
import gleam/option.{type Option, None, Some}
import gleam/io
import model/query_engine
import model/property_graph
import model/triple_store

pub type State {
  State(last_error: Option(String))
}

pub type Message {
  ExecuteQuery(
  query: query_engine.Query,
  prop_graph: property_graph.PropertyGraph,
  triple_store: triple_store.TripleStore,
  )
  SimulateError(String)  // Added for user-triggered errors
}

pub fn start() -> Result(process.Subject(Message), actor.StartError) {
  let init = fn() { actor.Ready(State(None), process.new_selector()) }

actor.start_spec(actor.Spec(
init: init,
loop: handle_message,
init_timeout: 5000,
))
}

pub fn send_message(process: process.Subject(Message), msg: Message) -> Nil {
  process.send(process, msg)
}

fn handle_message(msg: Message, _state: State) -> actor.Next(Message, State) {
  case msg {
  ExecuteQuery(query, prop_graph, triple_store) -> {
case try_execute_query(query, prop_graph, triple_store) {
Ok(result) -> {
io.println("Supervised query result:\n" <> result)
actor.Continue(State(None), None)
}
Error(error) -> {
io.println("Query execution failed: " <> error)
io.println("System recovered and ready for next query")
actor.Continue(State(Some(error)), None)
}
}
}
SimulateError(error_message) -> {
io.println("Simulated error: " <> error_message)
io.println("System recovered and ready for next query")
actor.Continue(State(Some(error_message)), None)
}
}
}

fn try_execute_query(
query: query_engine.Query,
prop_graph: property_graph.PropertyGraph,
triple_store: triple_store.TripleStore,
) -> Result(String, String) {
  // Handle both automatic and specific error cases
  case query.query_string {
    "INVALID_QUERY" -> Error("Simulated automatic query failure")
    _ -> {
      case query_engine.execute_query(query, prop_graph, triple_store) {
        "" -> Error("Query execution failed")
        result -> Ok(result)
      }
    }
  }
}