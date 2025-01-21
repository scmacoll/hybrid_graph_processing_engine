import gleam/dict
import gleam/list
import gleam/string
import gleam/set
import model/property_graph.{type PropertyGraph, type Edge}

pub type Component =
set.Set(String)

pub fn find_components(graph: PropertyGraph) -> List(Component) {
  let nodes = property_graph.get_nodes(graph)
  let edges = property_graph.get_edges(graph)

  let initial = #(set.new(), [])
  let result = dict.fold(
  nodes,
  initial,
  fn(acc, key, _value) {
    let #(visited, components) = acc

    case set.contains(visited, key) {
      True -> #(visited, components)
      False -> {
        let component = find_component(key, edges, visited)
        let new_visited = set.union(visited, component)
        #(new_visited, [component, ..components])
      }
    }
  }
  )

  let #(_, components) = result
  components
}

fn find_component(
start: String,
edges: List(Edge),
visited: set.Set(String)
) -> Component {
  find_component_helper([start], edges, visited, set.new())
}

fn find_component_helper(
to_visit: List(String),
edges: List(Edge),
visited: set.Set(String),
component: Component
) -> Component {
  case to_visit {
    [] -> component
    [current, ..rest] -> {
      case set.contains(visited, current) {
        True -> find_component_helper(rest, edges, visited, component)
        False -> {
          let updated_component = set.insert(component, current)
          let updated_visited = set.insert(visited, current)

          let neighbors = list.filter_map(
          edges,
          fn(edge) {
            case edge {
              property_graph.Edge(from, to, _, _) -> {
                case from == current, to == current {
                  True, False ->
                  case set.contains(updated_visited, to) {
                    True -> Error(Nil)
                    False -> Ok(to)
                  }
                  False, True ->
                  case set.contains(updated_visited, from) {
                    True -> Error(Nil)
                    False -> Ok(from)
                  }
                  _, _ -> Error(Nil)
                }
              }
            }
          }
          )

          find_component_helper(
          list.append(rest, neighbors),
          edges,
          updated_visited,
          updated_component
          )
        }
      }
    }
  }
}

pub fn format_components(components: List(Component)) -> String {
  let component_strings = list.map(
  components,
  fn(component) {
    "[" <> string.join(set.to_list(component), ", ") <> "]"
  }
  )

  "Connected Components: " <> string.join(component_strings, " ")
}