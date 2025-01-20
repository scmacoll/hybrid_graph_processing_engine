import gleam/dict
import model/property_graph

// Define the core triple structure
pub type Triple {
  Triple(subject: String, predicate: String, object: Value)
}

// Value represents possible object types in our triples
pub type Value {
  // Reusing PropertyValue from property_graph
  LiteralValue(property_graph.PropertyValue)
  ResourceValue(String)
  // References another resource by ID
}

// The main triple store structure
pub opaque type TripleStore {
  TripleStore(
    // We'll index triples for efficient querying
    subject_index: dict.Dict(String, List(Triple)),
    predicate_index: dict.Dict(String, List(Triple)),
    object_index: dict.Dict(String, List(Triple)),
  )
}

// Constructor for new empty triple store
pub fn new() -> TripleStore {
  TripleStore(
    subject_index: dict.new(),
    predicate_index: dict.new(),
    object_index: dict.new(),
  )
}

// Add a triple to the store
pub fn add_triple(store: TripleStore, triple: Triple) -> TripleStore {
  let TripleStore(subject_index, predicate_index, object_index) = store

  // Update subject index
  let updated_subject_index =
    update_index(subject_index, triple.subject, triple)

  // Update predicate index
  let updated_predicate_index =
    update_index(predicate_index, triple.predicate, triple)

  // Update object index for resource values
  let updated_object_index = case triple.object {
    ResourceValue(resource_id) ->
      update_index(object_index, resource_id, triple)
    _ -> object_index
  }

  TripleStore(
    subject_index: updated_subject_index,
    predicate_index: updated_predicate_index,
    object_index: updated_object_index,
  )
}

// Helper function to update an index
fn update_index(
  index: dict.Dict(String, List(Triple)),
  key: String,
  triple: Triple,
) -> dict.Dict(String, List(Triple)) {
  case dict.get(index, key) {
    Ok(triples) -> dict.insert(index, key, [triple, ..triples])
    Error(_) -> dict.insert(index, key, [triple])
  }
}

// Query triples by subject
pub fn query_by_subject(store: TripleStore, subject: String) -> List(Triple) {
  let TripleStore(subject_index, _, _) = store
  case dict.get(subject_index, subject) {
    Ok(triples) -> triples
    Error(_) -> []
  }
}
