import gleam/string
import gleam/list
import gleam/float
import model/triple_store


pub fn to_json(store: triple_store.TripleStore) -> String {
  let triples = triple_store.get_all_triples(store)

  let triples_json = list.map(triples, triple_to_json)
  |> string.join(",\n")

  "{\n" <>
  "  \"triples\": [\n" <>
  triples_json <>
  "\n  ]\n" <>
  "}"
}

fn triple_to_json(triple: triple_store.Triple) -> String {
  let object_value = case triple.object {
    triple_store.LiteralString(s) -> "\"" <> s <> "\""
    triple_store.LiteralNumber(n) -> float.to_string(n)
    triple_store.ResourceValue(resource_id) -> "\"" <> resource_id <> "\""
  }
  "    {\n" <>
  "      \"subject\": \"" <> triple.subject <> "\",\n" <>
  "      \"predicate\": \"" <> triple.predicate <> "\",\n" <>
  "      \"object\": " <> object_value <> "\n" <>
  "    }"
}