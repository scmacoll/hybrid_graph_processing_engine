[

## Hello world

](https://tour.gleam.run/everything/#basics-hello-world)

Here is a tiny program that prints out the text "Hello, Joe!". We'll explain how it works shortly.

In a normal Gleam project this program would be run using the command `gleam run`on the command line, but here in this tour the program is compiled and run inside your web browser, allowing you to try Gleam without installing anything on your computer.

Try changing the text being printed to `Hello, Mike!` and see what happens.

```gleam
import gleam/io

pub fn main() {
  io.println("Hello, Joe!")
}
```

---

[

## Modules

](https://tour.gleam.run/everything/#basics-modules)

Gleam code is organized into units called _modules_. A module is a bunch of definitions (of types, functions, etc.) that seem to belong together. For example, the [`gleam/io`](https://hexdocs.pm/gleam_stdlib/gleam/io.html)module contains a variety of functions for printing, like [`println`](https://hexdocs.pm/gleam_stdlib/gleam/io.html#println).

All gleam code is in _some_ module or other, whose name comes from the name of the file it's in. For example, [`gleam/io`](https://hexdocs.pm/gleam_stdlib/gleam/io.html) is in a file called `io.gleam` in a directory called `gleam`.

For code in one module to access code in another module, we import it using the `import` keyword, and the name used to refer to it is the last part of the module name. For example, the [`gleam/io`](https://hexdocs.pm/gleam_stdlib/gleam/io.html) module is referred to as `io` once imported.

The `as` keyword can be used to refer to a module by a different name. See how the [`gleam/string`](https://hexdocs.pm/gleam_stdlib/gleam/string.html) module is referred to as `text` here.

```gleam
import gleam/io
import gleam/string as text

pub fn main() {
  // Use a function from the `gleam/io` module
  io.println("Hello, Mike!")

  // Use a function from the `gleam/string` module
  io.println(text.reverse("Hello, Joe!"))
}
```

---

[

## Unqualified imports

](https://tour.gleam.run/everything/#basics-unqualified-imports)

Normally functions from other modules are used in a _qualified_ fashion, meaning the name used to refer the module goes before function name with a dot between them. For example, [`io.println("Hello!")`](https://hexdocs.pm/gleam_stdlib/gleam/io.html#println).

It is also possible to specify a list of functions to import from a module in an _unqualified_ fashion, meaning the function name can be used without the module _qualifier_ (the name and the dot) before it.

Generally it is best to use qualified imports, as this makes it clear where the function is defined, making the code easier to read.

```gleam
// Import the module and one of its functions
import gleam/io.{println}

pub fn main() {
  // Use the function in a qualified fashion
  io.println("This is qualified")

  // Or an unqualified fashion
  println("This is unqualified")
}
```

---

[

## Type checking

](https://tour.gleam.run/everything/#basics-type-checking)

Gleam has a robust static type system that helps you as you write and edit code, catching mistakes and showing you where to make changes.

Uncomment the line [`io.println(4)`](https://hexdocs.pm/gleam_stdlib/gleam/io.html#println) and see how a compile time error is reported as the [`io.println`](https://hexdocs.pm/gleam_stdlib/gleam/io.html#println) function only works with strings, not ints.

To fix the code change the code to call the [`io.debug`](https://hexdocs.pm/gleam_stdlib/gleam/io.html#debug) function instead, as it will print a value of any type.

Gleam has no `null`, no implicit conversions, no exceptions, and always performs full type checking. If the code compiles you can be reasonably confident it does not have any inconsistencies that may cause bugs or crashes.

```gleam
import gleam/io

pub fn main() {
  io.println("My lucky number is:")
  // io.println(4)
  // 👆️ Uncomment this line
}
```

---

[

## Ints

](https://tour.gleam.run/everything/#basics-ints)

Gleam's `Int` type represents whole numbers.

There are arithmetic and comparison operators for ints, as well as the equality operator which works on all types.

When running on the Erlang virtual machine ints have no maximum and minimum size. When running on JavaScript runtimes ints are represented using JavaScript's 64 bit floating point numbers.

The [`gleam/int`](https://hexdocs.pm/gleam_stdlib/gleam/int.html) standard library module contains functions for working with ints.

```gleam
import gleam/int
import gleam/io

pub fn main() {
  // Int arithmetic
  io.debug(1 + 1)
  io.debug(5 - 1)
  io.debug(5 / 2)
  io.debug(3 * 3)
  io.debug(5 % 2)

  // Int comparisons
  io.debug(2 > 1)
  io.debug(2 < 1)
  io.debug(2 >= 1)
  io.debug(2 <= 1)

  // Equality works for any type
  io.debug(1 == 1)
  io.debug(2 == 1)

  // Standard library int functions
  io.debug(int.max(42, 77))
  io.debug(int.clamp(5, 10, 20))
}
```

---

[

## Floats

](https://tour.gleam.run/everything/#basics-floats)

Gleam's `Float` type represents numbers that are not integers.

Gleam's numerical operators are not overloaded, so there are dedicated operators for working with floats.

Floats are represented as 64 bit floating point numbers on both the Erlang and JavaScript runtimes. The floating point behaviour is native to their respective runtimes, so their exact behaviour will be slightly different on the two runtimes.

Under the JavaScript runtime, exceeding the maximum (or minimum) representable value for a floating point value will result in `Infinity` (or `-Infinity`). Should you try to divide two infinities you will get `NaN` as a result.

When running on the BEAM any overflow will raise an error. So there is no `NaN` or `Infinity` float value in the Erlang runtime.

Division by zero will not overflow, but is instead defined to be zero.

The [`gleam/float`](https://hexdocs.pm/gleam_stdlib/gleam/float.html) standard library module contains functions for working with floats.

```gleam
import gleam/float
import gleam/io

pub fn main() {
  // Float arithmetic
  io.debug(1.0 +. 1.5)
  io.debug(5.0 -. 1.5)
  io.debug(5.0 /. 2.5)
  io.debug(3.0 *. 3.5)

  // Float comparisons
  io.debug(2.2 >. 1.3)
  io.debug(2.2 <. 1.3)
  io.debug(2.2 >=. 1.3)
  io.debug(2.2 <=. 1.3)

  // Equality works for any type
  io.debug(1.1 == 1.1)
  io.debug(2.1 == 1.2)

  // Division by zero is not an error
  io.debug(3.14 /. 0.0)

  // Standard library float functions
  io.debug(float.max(2.0, 9.5))
  io.debug(float.ceiling(5.4))
}
```

---

[

## Number formats

](https://tour.gleam.run/everything/#basics-number-formats)

Underscores can be added to numbers for clarity. For example, `1000000` can be tricky to read quickly, while `1_000_000` can be easier.

Ints can be written in binary, octal, or hexadecimal formats using the `0b`, `0o`, and `0x`prefixes respectively.

Floats can be written in a scientific notation.

```gleam
import gleam/io

pub fn main() {
  // Underscores
  io.debug(1_000_000)
  io.debug(10_000.01)

  // Binary, octal, and hex Int literals
  io.debug(0b00001111)
  io.debug(0o17)
  io.debug(0xF)

  // Scientific notation Float literals
  io.debug(7.0e7)
  io.debug(3.0e-4)
}
```

---

[

## Equality

](https://tour.gleam.run/everything/#basics-equality)

Gleam has the `==` and `!=` operators for checking equality.

The operators can be used with values of any type, but both sides of the operator must be of the same type.

Equality is checked _structurally_, meaning that two values are equal if they have the same structure rather than if they are at the same memory location.

```gleam
import gleam/io

pub fn main() {
  io.debug(100 == 100)
  io.debug(1.5 != 0.1)
}
```

---

[

## Strings

](https://tour.gleam.run/everything/#basics-strings)

In Gleam strings are written as text surrounded by double quotes, and can span multiple lines and contain unicode characters.

The `<>` operator can be used to concatenate strings.

Several escape sequences are supported:

- `\"` - double quote
- `\\` - backslash
- `\f` - form feed
- `\n` - newline
- `\r` - carriage return
- `\t` - tab
- `\u{xxxxxx}` - unicode codepoint

The [`gleam/string`](https://hexdocs.pm/gleam_stdlib/gleam/string.html) standard library module contains functions for working with strings.

```gleam
import gleam/io
import gleam/string

pub fn main() {
  // String literals
  io.debug("👩‍💻 こんにちは Gleam 🏳️‍🌈")
  io.debug(
    "multi
    line
    string",
  )
  io.debug("\u{1F600}")

  // Double quote can be escaped
  io.println("\"X\" marks the spot")

  // String concatenation
  io.debug("One " <> "Two")

  // String functions
  io.debug(string.reverse("1 2 3 4 5"))
  io.debug(string.append("abc", "def"))
}
```

---

[

## Bools

](https://tour.gleam.run/everything/#basics-bools)

A `Bool` is either `True` or `False`.

The `||`, `&&`, and `!` operators can be used to manipulate bools.

The `||` and `&&` operators are short-circuiting, meaning that if the left hand side of the operator is `True` for `||` or `False` for `&&` then the right hand side of the operator will not be evaluated.

The [`gleam/bool`](https://hexdocs.pm/gleam_stdlib/gleam/bool.html) standard library module contains functions for working with bools.

```gleam
import gleam/bool
import gleam/io

pub fn main() {
  // Bool operators
  io.debug(True && False)
  io.debug(True && True)
  io.debug(False || False)
  io.debug(False || True)

  // Bool functions
  io.debug(bool.to_string(True))
}
```

---

[

## Assignments

](https://tour.gleam.run/everything/#basics-assignments)

A value can be assigned to a variable using `let`.

Variable names can be reused by later let bindings, but the values they reference are immutable, so the values themselves are not changed or mutated in any way.

In Gleam variable and function names are written in `snake_case`.

```gleam
import gleam/io

pub fn main() {
  let x = "Original"
  io.debug(x)

  // Assign `y` to the value of `x`
  let y = x
  io.debug(y)

  // Assign `x` to a new value
  let x = "New"
  io.debug(x)

  // The `y` still refers to the original value
  io.debug(y)
}
```

---

[

## Discard patterns

](https://tour.gleam.run/everything/#basics-discard-patterns)

If a variable is assigned but not used then Gleam will emit a warning.

If a variable is intended to not be used, then the name can be prefixed with an underscore, silencing the warning.

Try changing the variable name to `score` to see the warning.

```gleam
pub fn main() {
  // This variable is never used
  let _score = 1000
}
```

---

[

## Type annotations

](https://tour.gleam.run/everything/#basics-type-annotations)

Let assignments can be written with a type annotation after the name.

Type annotations may be useful for documentation purposes, but they do not change how Gleam type checks the code beyond ensuring that the annotation is correct.

Typically Gleam code will not have type annotations for assignments.

Try changing a type annotation to something incorrect to see the compile error.

```gleam
pub fn main() {
  let _name: String = "Gleam"

  let _is_cool: Bool = True

  let _version: Int = 1
}
```

---

[

## Type imports

](https://tour.gleam.run/everything/#basics-type-imports)

Other modules may also define types that we wish to refer to. In this case we need to import them.

Like functions, types can be referred to in a _qualified_ way by putting the imported module name and a dot before the type name. For example,[`bytes_builder.BytesBuilder`](https://hexdocs.pm/gleam_stdlib/gleam/bytes_builder.html#BytesBuilder)

Types can also be imported in an _unqualified_ way by listing them in the import statement with the word `type` before the type name.

Unlike functions, Gleam types are commonly imported in an unqualified way.

```gleam
import gleam/bytes_tree
import gleam/string_tree.{type StringTree}

pub fn main() {
  // Referring to a type in a qualified way
  let _bytes: bytes_tree.BytesTree = bytes_tree.new()

  // Refering to a type in an unqualified way
  let _text: StringTree = string_tree.new()
}
```

---

[

## Type aliases

](https://tour.gleam.run/everything/#basics-type-aliases)

A type alias can be used to refer to a type by a different name. Giving a type an alias doesn't make a new type, it is still the same type.

A type's name always starts with a capital letter, contrasting to variables and functions, which start with a lowercase letter.

When the `pub` keyword is used the type alias is public and can be referred to by other modules.

```gleam
import gleam/io

pub type UserId =
  Int

pub fn main() {
  let one: UserId = 1
  let two: Int = 2

  // UserId and Int are the same type
  io.debug(one == two)
}
```

---

[

## Blocks

](https://tour.gleam.run/everything/#basics-blocks)

Blocks are one or more expressions grouped together with curly braces. Each expression is evaluated in order and the value of the last expression is returned.

Any variables assigned within the block can only be used within the block.

Try uncommenting [`io.debug(degrees)`](https://hexdocs.pm/gleam_stdlib/gleam/io.html#debug) to see the compile error from trying to use a variable that is not in scope.

Blocks can also be used to change the order of evaluation of binary operators expressions. 

`*` binds more tightly than `+` so the expression `1 + 2 * 3` evaluates to 7. If the `1 + 2`should be evaluated first to make the expression evaluate to 9 then the expression can be wrapped in a block: `{ 1 + 2 } * 3`. This is similar to grouping with parentheses in some other languages.

```gleam
import gleam/io

pub fn main() {
  let fahrenheit = {
    let degrees = 64
    degrees
  }
  // io.debug(degrees) // <- This will not compile

  // Changing order of evaluation
  let celsius = { fahrenheit - 32 } * 5 / 9
  io.debug(celsius)
}
```

---

[

## Lists

](https://tour.gleam.run/everything/#basics-lists)

Lists are ordered collections of values.

[`List`](https://hexdocs.pm/gleam_stdlib/gleam/list.html) is a generic type, having a type parameter for the type of values it contains. A list of ints has the type `List(Int)`, and a list of strings has the type `List(String)`.

Lists are immutable single-linked lists, meaning they are very efficient to add and remove elements from the front of the list.

Counting the length of a list or getting elements from other positions in the list is expensive and rarely done. It is rare to write algorithms that index into sequences in Gleam, but when they are written a list is not the right choice of data structure.

```gleam
import gleam/io

pub fn main() {
  let ints = [1, 2, 3]

  io.debug(ints)

  // Immutably prepend
  io.debug([-1, 0, ..ints])

  // Uncomment this to see the error
  // io.debug(["zero", ..ints])

  // The original lists are unchanged
  io.debug(ints)
}
```

---

[

## Constants

](https://tour.gleam.run/everything/#basics-constants)

As well as let assignments Gleam also has constants, which are defined at the top level of a module.

Constants must be literal values, functions cannot be used in their definitions.

Constants may be useful for values that are used throughout your program, permitting them to be named and to ensure there are no differences in the definition between each use.

Using a constant may be more efficient than creating the same value in multiple functions, though the exact performance characteristics will depend on the runtime and whether compiling to Erlang or JavaScript.

```gleam
import gleam/io

const ints: List(Int) = [1, 2, 3]

const floats = [1.1, 2.2, 3.3]

pub fn main() {
  io.debug(ints)
  io.debug(ints == [1, 2, 3])

  io.debug(floats)
  io.debug(floats == [1.1, 2.2, 3.3])
}
```

---

### Functions

---

[

## Functions

](https://tour.gleam.run/everything/#functions-functions)

The `fn` keyword is used to define new functions.

The `double` and `multiply` functions are defined without the `pub` keyword. This makes them _private_ functions, they can only be used within this module. If another module attempted to use them it would result in a compiler error.

Like with assignments, type annotations are optional for function arguments and return values. It is considered good practice to use type annotations for functions, for clarity and to encourage intentional and thoughtful design.

```gleam
import gleam/io

pub fn main() {
  io.debug(double(10))
}

fn double(a: Int) -> Int {
  multiply(a, 2)
}

fn multiply(a: Int, b: Int) -> Int {
  a * b
}
```

---

[

## Higher order functions

](https://tour.gleam.run/everything/#functions-higher-order-functions)

In Gleam functions are values. They can be assigned to variables, passed to other functions, and anything else you can do with values.

Here the function `add_one` is being passed as an argument to the `twice` function.

Notice the `fn` keyword is also used to describe the type of the function that `twice`takes as its second argument.

```gleam
import gleam/io

pub fn main() {
  // Call a function with another function
  io.debug(twice(1, add_one))

  // Functions can be assigned to variables
  let my_function = add_one
  io.debug(my_function(100))
}

fn twice(argument: Int, passed_function: fn(Int) -> Int) -> Int {
  passed_function(passed_function(argument))
}

fn add_one(argument: Int) -> Int {
  argument + 1
}
```

---

[

## Anonymous functions

](https://tour.gleam.run/everything/#functions-anonymous-functions)

As well as module-level named functions, Gleam has anonymous function literals, written with the `fn() { ... }` syntax.

Anonymous functions can be used interchangeably with named functions.

Anonymous functions can reference variables that were in scope when they were defined, making them _closures_.

```gleam
import gleam/io

pub fn main() {
  // Assign an anonymous function to a variable
  let add_one = fn(a) { a + 1 }
  io.debug(twice(1, add_one))

  // Pass an anonymous function as an argument
  io.debug(twice(1, fn(a) { a * 2 }))

  let secret_number = 42
  // This anonymous function always returns 42
  let secret = fn() { secret_number }
  io.debug(secret())
}

fn twice(argument: Int, my_function: fn(Int) -> Int) -> Int {
  my_function(my_function(argument))
}
```

---

[

## Function captures

](https://tour.gleam.run/everything/#functions-function-captures)

Gleam has a shorthand syntax for creating anonymous functions that take one argument and immediately call another function with that argument: the function capture syntax.

The anonymous function `fn(a) { some_function(..., a, ...) }` can be written as `some_function(..., _, ...)`, with any number of other arguments passed directly to the inner function. The underscore `_` is a placeholder for the argument, equivalent to `a` in `fn(a) { some_function(..., a, ...) }`.

```gleam
import gleam/io

pub fn main() {
  // These two statements are equivalent
  let add_one_v1 = fn(x) { add(1, x) }
  let add_one_v2 = add(1, _)

  io.debug(add_one_v1(10))
  io.debug(add_one_v2(10))
}

fn add(a: Int, b: Int) -> Int {
  a + b
}
```

---

[

## Generic functions

](https://tour.gleam.run/everything/#functions-generic-functions)

Up until now each function has accepted precisely one type for each of its arguments.

The `twice` function in the previous lesson on _higher order functions_ only worked with functions that would take and return ints. This is overly restrictive, it should be possible to use this function with any type, so long as the function and the initial value are compatible.

To enable this, Gleam supports _generics_, also known as _parametric polymorphism_.

This works by using a type variable instead of specifying a concrete type. It stands in for whatever specific type is being used when the function is called. These type variables are written with a lowercase name.

Type variables are not like an `any` type, they get replaced with a specific type each time the function is called. Try uncommenting `twice(10, exclaim)` to see the compiler error from trying to use a type variable as an int and a string at the same time.

```gleam
import gleam/io

pub fn main() {
  let add_one = fn(x) { x + 1 }
  let exclaim = fn(x) { x <> "!" }

  // Invalid, Int and String are not the same type
  // twice(10, exclaim)

  // Here the type variable is replaced by the type Int
  io.debug(twice(10, add_one))

  // Here the type variable is replaced by the type String
  io.debug(twice("Hello", exclaim))
}

// The name `value` refers to the same type multiple times
fn twice(argument: value, my_function: fn(value) -> value) -> value {
  my_function(my_function(argument))
}
```

---

[

## Pipelines

](https://tour.gleam.run/everything/#functions-pipelines)

It's common to want to call a series of functions, passing the result of one to the next. With the regular function call syntax this can be a little difficult to read as you have to read the code from the inside out.

Gleam's pipe operator `|>` helps with this problem by allowing you to write code top-to-bottom.

The pipe operator takes the result of the expression on its left and passes it as an argument to the function on its right.

It will first check to see if the left-hand value could be used as the first argument to the call. For example, `a |> b(1, 2)` would become `b(a, 1, 2)`. If not, it falls back to calling the result of the right-hand side as a function, e.g., `b(1, 2)(a)`

Gleam code is typically written with the "subject" of the function as the first argument, to make it easier to pipe. If you wish to pipe to a different position then a function capture can be used to insert the argument to the desired position.

```gleam
import gleam/io
import gleam/string

pub fn main() {
  // Without the pipe operator
  io.debug(string.drop_start(string.drop_end("Hello, Joe!", 1), 7))

  // With the pipe operator
  "Hello, Mike!"
  |> string.drop_end(1)
  |> string.drop_start(7)
  |> io.debug

  // Changing order with function capturing
  "1"
  |> string.append("2")
  |> string.append("3", _)
  |> io.debug
}
```

---

[

## Labelled arguments

](https://tour.gleam.run/everything/#functions-labelled-arguments)

When functions take several arguments it can be difficult to remember what the arguments are, and what order they are expected in.

To help with this Gleam supports labelled arguments, where function arguments are given an external label in addition to their internal name. These labels are written before the argument name in the function definition.

When labelled arguments are used the order of the arguments does not matter, but all unlabelled arguments must come before labelled arguments.

There is no performance cost to using labelled arguments, it does not allocate a dictionary or perform any other runtime work.

Labels are optional when calling a function, it is up to the programmer to decide what is clearest in their code.

```gleam
import gleam/io

pub fn main() {
  // Without using labels
  io.debug(calculate(1, 2, 3))

  // Using the labels
  io.debug(calculate(1, add: 2, multiply: 3))

  // Using the labels in a different order
  io.debug(calculate(1, multiply: 3, add: 2))
}

fn calculate(value: Int, add addend: Int, multiply multiplier: Int) {
  value * multiplier + addend
}
```

---

[

## Label shorthand syntax

](https://tour.gleam.run/everything/#functions-label-shorthand-syntax)

When local variables have the same names as a function's labelled arguments, the variable names can be omitted when calling the function. This is known as shorthand syntax for labels.

The shorthand syntax can also be used for record constructor arguments.

```gleam
pub fn main() {
  let quantity = 5.0
  let unit_price = 10.0
  let discount = 0.2

  // Using the regular label syntax
  calculate_total_cost(
    quantity: quantity,
    unit_price: unit_price,
    discount: discount,
  )

  // Using the shorthand syntax
  calculate_total_cost(quantity:, unit_price:, discount:)
}

fn calculate_total_cost(
  quantity quantity: Float,
  unit_price price: Float,
  discount discount: Float,
) -> Float {
  let subtotal = quantity *. price
  let discount = subtotal *. discount
  subtotal -. discount
}
```

---

[

## Documentation comments

](https://tour.gleam.run/everything/#functions-documentation-comments)

Documentation and comments are important tools for making your code easier to work with and understand.

As well as regular `//` comments Gleam has `///` and `////` comments which are used for attaching documentation to code.

`///` is used for documenting types and functions, and should be placed immediately before the type or function it is documenting.

`////` is used for documenting modules, and should be placed at the top of the module.

```gleam
//// A module containing some unusual functions and types.

/// A type where the value can never be constructed.
/// Can you work out why?
pub type Never {
  Never(Never)
}

/// Call a function twice with an initial value.
///
pub fn twice(argument: value, my_function: fn(value) -> value) -> value {
  my_function(my_function(argument))
}

/// Call a function three times with an initial value.
///
pub fn thrice(argument: value, my_function: fn(value) -> value) -> value {
  my_function(my_function(my_function(argument)))
}
```

---

[

## Deprecations

](https://tour.gleam.run/everything/#functions-deprecations)

Functions and other definitions can be marked as deprecated using the `@deprecated`attribute.

If a deprecated function is referenced the compiler will emit a warning, letting the programmer know they ought to update their code.

The deprecation attribute takes a message and this will be displayed to the user in the warning. In the message explain to the user the new approach or replacement function, or direct them to documentation on how to upgrade.

```gleam
pub fn main() {
  old_function()
  new_function()
}

@deprecated("Use new_function instead")
fn old_function() {
  Nil
}

fn new_function() {
  Nil
}
```

---

### Flow control

---

[

## Case expressions

](https://tour.gleam.run/everything/#flow-control-case-expressions)

The case expression is the most common kind of flow control in Gleam code. It is similar to `switch` in some other languages, but more powerful than most.

It allows the programmer to say "if the data has this shape then run this code", a process called _pattern matching_.

Gleam performs _exhaustiveness checking_ to ensure that the patterns in a case expression cover all possible values. With this you can have confidence that your logic is up-to-date for the design of the data you are working with.

Try commenting out patterns or adding new redundant ones, and see what problems the compiler reports.

```gleam
import gleam/int
import gleam/io

pub fn main() {
  let x = int.random(5)
  io.debug(x)

  let result = case x {
    // Match specific values
    0 -> "Zero"
    1 -> "One"

    // Match any other value
    _ -> "Other"
  }
  io.debug(result)
}
```

---

[

## Variable patterns

](https://tour.gleam.run/everything/#flow-control-variable-patterns)

Patterns in case expressions can also assign variables.

When a variable name is used in a pattern the value that is matched against is assigned to that name, and can be used in the body of that clause.

```gleam
import gleam/int
import gleam/io

pub fn main() {
  let result = case int.random(5) {
    // Match specific values
    0 -> "Zero"
    1 -> "One"

    // Match any other value and assign it to a variable
    other -> "It is " <> int.to_string(other)
  }
  io.debug(result)
}
```

---

[

## String patterns

](https://tour.gleam.run/everything/#flow-control-string-patterns)

When pattern matching on strings the `<>` operator can be used to match on strings with a specific prefix.

The pattern `"Hello, " <> name` matches any string that starts with `"Hello, "` and assigns the rest of the string to the variable `name`.

```gleam
import gleam/io

pub fn main() {
  io.debug(get_name("Hello, Joe"))
  io.debug(get_name("Hello, Mike"))
  io.debug(get_name("System still working?"))
}

fn get_name(x: String) -> String {
  case x {
    "Hello, " <> name -> name
    _ -> "Unknown"
  }
}
```

---

[

## List patterns

](https://tour.gleam.run/everything/#flow-control-list-patterns)

Lists and the values they contain can be pattern matched on in case expressions.

List patterns match on specific lengths of lists. The pattern `[]` matches an empty list, and the pattern `[_]` matches a list with one element. They will not match on lists with other lengths.

The spread pattern `..` can be used to match the rest of the list. The pattern `[1, ..]`matches any list that starts with `1`. The pattern `[_, _, ..]` matches any list that has at least two elements.

```gleam
import gleam/int
import gleam/io
import gleam/list

pub fn main() {
  let x = list.repeat(int.random(5), times: int.random(3))
  io.debug(x)

  let result = case x {
    [] -> "Empty list"
    [1] -> "List of just 1"
    [4, ..] -> "List starting with 4"
    [_, _] -> "List of 2 elements"
    _ -> "Some other list"
  }
  io.debug(result)
}
```

---

[

## Recursion

](https://tour.gleam.run/everything/#flow-control-recursion)

Gleam doesn't have loops, instead iteration is done through recursion, that is through top-level functions calling themselves with different arguments.

A recursive function needs to have at least one _base case_ and at least one _recursive case_. A base case returns a value without calling the function again. A recursive case calls the function again with different inputs, looping again.

The Gleam standard library has functions for various common looping patterns, some of which will be introduced in later lessons, however for more complex loops manual recursion is often the clearest way to write it.

Recursion can seem daunting or unclear at first if you are more familiar with languages that have special looping features, but stick with it! With time it'll become just as familiar and comfortable as any other way of iterating.

```gleam
import gleam/io

pub fn main() {
  io.debug(factorial(5))
  io.debug(factorial(7))
}

// A recursive functions that calculates factorial
pub fn factorial(x: Int) -> Int {
  case x {
    // Base case
    0 -> 1
    1 -> 1

    // Recursive case
    _ -> x * factorial(x - 1)
  }
}
```

---

[

## Tail calls

](https://tour.gleam.run/everything/#flow-control-tail-calls)

When a function is called a new stack frame is created in memory to store the arguments and local variables of the function. If lots of these frames are created during recursion then the program would use a large amount of memory, or even crash the program if some limit is hit.

To avoid this problem Gleam supports _tail call optimisation_, which allows the stack frame for the current function to be reused if a function call is the last thing the function does, removing the memory cost.

Unoptimised recursive functions can often be rewritten into tail call optimised functions by using an accumulator. An accumulator is a variable that is passed along in addition to the data, similar to a mutable variable in a language with `while` loops.

Accumulators should be hidden away from the users of your code, they are internal implementation details. To do this write a public function that calls a recursive private function with the initial accumulator value.

```gleam
import gleam/io

pub fn main() {
  io.debug(factorial(5))
  io.debug(factorial(7))
}

pub fn factorial(x: Int) -> Int {
  // The public function calls the private tail recursive function
  factorial_loop(x, 1)
}

fn factorial_loop(x: Int, accumulator: Int) -> Int {
  case x {
    0 -> accumulator
    1 -> accumulator

    // The last thing this function does is call itself
    // In the previous lesson the last thing it did was multiply two ints
    _ -> factorial_loop(x - 1, accumulator * x)
  }
}
```

---

[

## List recursion

](https://tour.gleam.run/everything/#flow-control-list-recursion)

While it is more common to use functions in the [`gleam/list`](https://hexdocs.pm/gleam_stdlib/gleam/list.html) module to iterate across a list, at times you may prefer to work with the list directly.

The `[first, ..rest]` pattern matches on a list with at least one element, assigning the first element to the variable `first` and the rest of the list to the variable `rest`. By using this pattern and a pattern for the empty list `[]` a function can run code on each element of a list until the end is reached.

This code sums a list by recursing over the list and adding each int to a `total`argument, returning it when the end is reached.

```gleam
import gleam/io

pub fn main() {
  let sum = sum_list([18, 56, 35, 85, 91], 0)
  io.debug(sum)
}

fn sum_list(list: List(Int), total: Int) -> Int {
  case list {
    [first, ..rest] -> sum_list(rest, total + first)
    [] -> total
  }
}
```

---

[

## Multiple subjects

](https://tour.gleam.run/everything/#flow-control-multiple-subjects)

Sometimes it is useful to pattern match on multiple values at the same time in one case expression.

To do this, you can give multiple subjects and multiple patterns, separated by commas.

When matching on multiple subjects there must be the same number of patterns as there are subjects. Try removing one of the `_,` sub-patterns to see the compile time error that is returned.

```gleam
import gleam/int
import gleam/io

pub fn main() {
  let x = int.random(2)
  let y = int.random(2)
  io.debug(x)
  io.debug(y)

  let result = case x, y {
    0, 0 -> "Both are zero"
    0, _ -> "First is zero"
    _, 0 -> "Second is zero"
    _, _ -> "Neither are zero"
  }
  io.debug(result)
}
```

---

[

## Alternative patterns

](https://tour.gleam.run/everything/#flow-control-alternative-patterns)

Alternative patterns can be given for a case clause using the `|` operator. If any of the patterns match then the clause matches.

If a pattern defines a variable then all of the alternative patterns for that clause must also define a variable with the same name and same type.

Currently it is not possible to have nested alternative patterns, so the pattern `[1 | 2 | 3]` is not valid.

```gleam
import gleam/int
import gleam/io

pub fn main() {
  let number = int.random(10)
  io.debug(number)

  let result = case number {
    2 | 4 | 6 | 8 -> "This is an even number"
    1 | 3 | 5 | 7 -> "This is an odd number"
    _ -> "I'm not sure"
  }
  io.debug(result)
}
```

---

[

## Pattern aliases

](https://tour.gleam.run/everything/#flow-control-pattern-aliases)

The `as` operator can be used to assign sub patterns to variables.

The pattern `[_, ..] as first` will match any non-empty list and assign that list to the variable `first`.

```gleam
import gleam/io

pub fn main() {
  io.debug(get_first_non_empty([[], [1, 2, 3], [4, 5]]))
  io.debug(get_first_non_empty([[1, 2], [3, 4, 5], []]))
  io.debug(get_first_non_empty([[], [], []]))
}

fn get_first_non_empty(lists: List(List(t))) -> List(t) {
  case lists {
    [[_, ..] as first, ..] -> first
    [_, ..rest] -> get_first_non_empty(rest)
    [] -> []
  }
}
```

---

[

## Guards

](https://tour.gleam.run/everything/#flow-control-guards)

The `if` keyword can be used with case expressions to add a _guard_ to a pattern. A guard is an expression that must evaluate to `True` for the pattern to match.

Only a limited set of operators can be used in guards, and functions cannot be called at all.

```gleam
import gleam/io

pub fn main() {
  let numbers = [1, 2, 3, 4, 5]
  io.debug(get_first_larger(numbers, 3))
  io.debug(get_first_larger(numbers, 5))
}

fn get_first_larger(numbers: List(Int), limit: Int) -> Int {
  case numbers {
    [first, ..] if first > limit -> first
    [_, ..rest] -> get_first_larger(rest, limit)
    [] -> 0
  }
}
```

---

### Data types

---

[

## Tuples

](https://tour.gleam.run/everything/#data-types-tuples)

Lists are good for when we want a collection of one type, but sometimes we want to combine multiple values of different types. In this case tuples are a quick and convenient option.

The tuple access syntax can be used to get elements from a tuple without pattern matching. `some_tuple.0` gets the first element, `some_tuple.1` gets the second element, etc.

Tuples are generic types, they have type parameters for the types they contain. `#(1, "Hi!")` has the type `#(Int, String)`, and `#(1.4, 10, 48)` has the type `#(Float, Int, Int)`.

Tuples are most commonly used to return 2 or 3 values from a function. Often it is clearer to use a _custom type_ where a tuple could be used. We will cover custom types next.

```gleam
import gleam/io

pub fn main() {
  let triple = #(1, 2.2, "three")
  io.debug(triple)

  let #(a, _, _) = triple
  io.debug(a)
  io.debug(triple.1)
}
```

---

[

## Custom types

](https://tour.gleam.run/everything/#data-types-custom-types)

Gleam has a few built in types such as `Int` and `String`, but custom types allow the creation of entirely new types.

A custom type is defined with the `type` keyword followed by the name of the type and a constructor for each _variant_ of the type. Both the type name and the names of the constructors start with uppercase letters.

Custom type variants can be pattern matched on using a case expression.

```gleam
import gleam/io

pub type Season {
  Spring
  Summer
  Autumn
  Winter
}

pub fn main() {
  io.debug(weather(Spring))
  io.debug(weather(Autumn))
}

fn weather(season: Season) -> String {
  case season {
    Spring -> "Mild"
    Summer -> "Hot"
    Autumn -> "Windy"
    Winter -> "Cold"
  }
}
```

---

[

## Records

](https://tour.gleam.run/everything/#data-types-records)

A variant of a custom type can hold other data within it. In this case the variant is called a record.

The fields of a record can be given labels, and like function argument labels they can be optionally used when calling the record constructor. Typically labels will be used for variants that define them.

It is common to have a custom type with one variant that holds data, this is the Gleam equivalent of a struct or object in other languages.

```gleam
import gleam/io

pub type SchoolPerson {
  Teacher(name: String, subject: String)
  Student(String)
}

pub fn main() {
  let teacher1 = Teacher("Mr Schofield", "Physics")
  let teacher2 = Teacher(name: "Miss Percy", subject: "Physics")
  let student1 = Student("Koushiar")
  let student2 = Student("Naomi")
  let student3 = Student("Shaheer")

  let school = [teacher1, teacher2, student1, student2, student3]
  io.debug(school)
}
```

---

[

## Record accessors

](https://tour.gleam.run/everything/#data-types-record-accessors)

The record accessor syntax `record.field_label` can be used to get contained values from a custom type record.

The accessor syntax can always be used for fields with the same name that are in the same position and have the same type for all variants of the custom type. Other fields can only be accessed when the compiler can tell which variant the value is, such after pattern matching in a `case` expression.

The `name` field is in the first position and has type `String` for all variants, so it can be accessed.

The `subject` field is absent on the `Student` variant, so it cannot be used on all values of type `SchoolPerson`. Uncomment the `student.subject` line to see the compile error from trying to use this accessor.

```gleam
import gleam/io

pub type SchoolPerson {
  Teacher(name: String, subject: String)
  Student(name: String)
}

pub fn main() {
  let teacher = Teacher("Mr Schofield", "Physics")
  let student = Student("Koushiar")

  io.debug(teacher.name)
  io.debug(student.name)
  // io.debug(student.subject)
}
```

---

[

## Record pattern matching

](https://tour.gleam.run/everything/#data-types-record-pattern-matching)

It is possible to pattern match on a record, this allows for the extraction of multiple field values from a record into distinct variables, similar to matching on a tuple or a list.

The `let` keyword can only match on single variant custom types, or when the variant is know, such as after pattern matching with a case expression.

It is possible to use underscore `_` or the spread syntax `..` to discard fields that are not required.

```gleam
import gleam/io

pub type Fish {
  Starfish(name: String, favourite_color: String)
  Jellyfish(name: String, jiggly: Bool)
}

pub type IceCream {
  IceCream(flavour: String)
}

pub fn main() {
  handle_fish(Starfish("Lucy", "Pink"))
  handle_ice_cream(IceCream("strawberry"))
}

fn handle_fish(fish: Fish) {
  case fish {
    Starfish(_, favourite_color) -> io.debug(favourite_color)
    Jellyfish(name, ..) -> io.debug(name)
  }
}

fn handle_ice_cream(ice_cream: IceCream) {
  // if the custom type has a single variant you can
  // destructure it using `let` instead of a case expression!
  let IceCream(flavour) = ice_cream
  io.debug(flavour)
}
```

---

[

## Record updates

](https://tour.gleam.run/everything/#data-types-record-updates)

The record update syntax can be used to create a new record from an existing one of the same type, but with some fields changed.

Gleam is an immutable language, so using the record update syntax does not mutate or otherwise change the original record.

```gleam
import gleam/io

pub type SchoolPerson {
  Teacher(name: String, subject: String, floor: Int, room: Int)
}

pub fn main() {
  let teacher1 = Teacher(name: "Mr Dodd", subject: "ICT", floor: 2, room: 2)

  // Use the update syntax
  let teacher2 = Teacher(..teacher1, subject: "PE", room: 6)

  io.debug(teacher1)
  io.debug(teacher2)
}
```

---

[

## Generic custom types

](https://tour.gleam.run/everything/#data-types-generic-custom-types)

Like functions, custom types can also be generic, taking contained types as parameters.

Here a generic `Option` type is defined, which is used to represent a value that is either present or absent. This type is quite useful! The [`gleam/option`](https://hexdocs.pm/gleam_stdlib/gleam/option.html) module defines it so you can use it in your Gleam projects.

```gleam
pub type Option(inner) {
  Some(inner)
  None
}

// An option of string
pub const name: Option(String) = Some("Annah")

// An option of int
pub const level: Option(Int) = Some(10)
```

---

[

## Nil

](https://tour.gleam.run/everything/#data-types-nil)

`Nil` is Gleam's unit type. It is a value that is returned by functions that have nothing else to return, as all functions must return something.

`Nil` is not a valid value of any other types. Therefore, values in Gleam are not nullable. If the type of a value is `Nil` then it is the value `Nil`. If it is some other type then the value is not `Nil`.

Uncomment the line that assigns `Nil` to a variable with an incompatible type annotation to see the compile time error it produces.

```gleam
import gleam/io

pub fn main() {
  let x = Nil
  io.debug(x)

  // let y: List(String) = Nil

  let result = io.println("Hello!")
  io.debug(result == Nil)
}
```

---

[

## Results

](https://tour.gleam.run/everything/#data-types-results)

Gleam doesn't use exceptions, instead computations that can either succeed or fail return a value of the built-in `Result(value, error)` type. It has two variants:

- `Ok`, which contains the return value of a successful computation.
- `Error`, which contains the reason for a failed computation.

The type is generic with two type parameters, one for the success value and one for the error. With these the result can hold any type for success and failure.

Commonly a Gleam program or library will define a custom type with a variant for each possible problem that can arise, along with any error information that would be useful to the programmer.

This is advantageous over exceptions as you can immediately see what if any errors a function can return, and the compiler will ensure they are handled. No nasty surprises with unexpected exceptions!

A result value can be handled by pattern matching with a `case` expression, but given how frequently results are returned this can become unwieldy. Gleam code commonly uses the [`gleam/result`](https://hexdocs.pm/gleam_stdlib/gleam/result.html) standard library module and `use` expressions when working with results, both of which will be covered in later chapters.

```gleam
import gleam/int
import gleam/io

pub fn main() {
  let _ = io.debug(buy_pastry(10))
  let _ = io.debug(buy_pastry(8))
  let _ = io.debug(buy_pastry(5))
  let _ = io.debug(buy_pastry(3))
}

pub type PurchaseError {
  NotEnoughMoney(required: Int)
  NotLuckyEnough
}

fn buy_pastry(money: Int) -> Result(Int, PurchaseError) {
  case money >= 5 {
    True ->
      case int.random(4) == 0 {
        True -> Error(NotLuckyEnough)
        False -> Ok(money - 5)
      }
    False -> Error(NotEnoughMoney(required: 5))
  }
}
```

---

[

## Bit arrays

](https://tour.gleam.run/everything/#data-types-bit-arrays)

Bit arrays represent a sequence of 1s and 0s, and are a convenient syntax for constructing and manipulating binary data.

Each segment of a bit array can be given options to specify the representation used for that segment.

- `size`: the size of the segment in bits.
- `unit`: the number of bits that the `size` value is a multiple of.
- `bits`: a nested bit array of any size.
- `bytes`: a nested byte-aligned bit array.
- `float`: a 64 bits floating point number.
- `int`: an int with a default size of 8 bits.
- `big`: big endian.
- `little`: little endian.
- `native`: the endianness of the processor.
- `utf8`: utf8 encoded text.
- `utf16`: utf16 encoded text.
- `utf32`: utf32 encoded text.
- `utf8_codepoint`: a utf8 codepoint.
- `utf16_codepoint`: a utf16 codepoint.
- `utf32_codepoint`: a utf32 codepoint.
- `signed`: a signed number.
- `unsigned`: an unsigned number.

Multiple options can be given to a segment by separating each with a dash:`x:unsigned-little-size(2)`.

Bit arrays have limited support when compiling to JavaScript, not all options can be used. Full bit array support will be implemented in the future.

For more information on bit arrays see the [Erlang bit syntax documentation](https://www.erlang.org/doc/programming_examples/bit_syntax.html).

```gleam
import gleam/io

pub fn main() {
  // 8 bit int. In binary: 00000011
  io.debug(<<3>>)
  io.debug(<<3>> == <<3:size(8)>>)

  // 16 bit int. In binary: 0001100000000011
  io.debug(<<6147:size(16)>>)

  // A bit array of UTF8 data
  io.debug(<<"Hello, Joe!":utf8>>)

  // Concatenation
  let first = <<4>>
  let second = <<2>>
  io.debug(<<first:bits, second:bits>>)
}
```

---

### Standard library

---

[

## Standard library package

](https://tour.gleam.run/everything/#standard-library-standard-library-package)

The Gleam standard library is a regular Gleam package that has been published to the [Hex](https://hex.pm/) package repository. You could opt to not use it if you wish, though almost all Gleam projects depend on it.

All of the modules imported so far in this guide, such as [`gleam/io`](https://hexdocs.pm/gleam_stdlib/gleam/io.html), are from the standard library.

All of the documentation for the standard library is available on [HexDocs](https://hexdocs.pm/gleam_stdlib/). We will go over some of the most commonly used modules now.

```gleam
import gleam/io

pub fn main() {
  io.println("Hello, Joe!")
  io.println("Hello, Mike!")
}
```

---

[

## List module

](https://tour.gleam.run/everything/#standard-library-list-module)

The [`gleam/list`](https://hexdocs.pm/gleam_stdlib/gleam/list.html) standard library module contains functions for working with lists. A Gleam program will likely make heavy use of this module, the various functions serving as different types of loops over lists.

[`map`](https://hexdocs.pm/gleam_stdlib/gleam/list.html#map) makes a new list by running a function on each element in a list.

[`filter`](https://hexdocs.pm/gleam_stdlib/gleam/list.html#filter) makes a new list containing only the elements for which a function returns true.

[`fold`](https://hexdocs.pm/gleam_stdlib/gleam/list.html#fold) combines all the elements in a list into a single value by running a function left-to-right on each element, passing the result of the previous call to the next call.

[`find`](https://hexdocs.pm/gleam_stdlib/gleam/list.html#find) returns the first element in a list for which a function returns `True`.

It's worth getting familiar with all the functions in this module when writing Gleam code, you'll be using them a lot!

```gleam
import gleam/io
import gleam/list

pub fn main() {
  let ints = [0, 1, 2, 3, 4, 5]

  io.println("=== map ===")
  io.debug(list.map(ints, fn(x) { x * 2 }))

  io.println("=== filter ===")
  io.debug(list.filter(ints, fn(x) { x % 2 == 0 }))

  io.println("=== fold ===")
  io.debug(list.fold(ints, 0, fn(count, e) { count + e }))

  io.println("=== find ===")
  let _ = io.debug(list.find(ints, fn(x) { x > 3 }))
  io.debug(list.find(ints, fn(x) { x > 13 }))
}
```

---

[

## Result module

](https://tour.gleam.run/everything/#standard-library-result-module)

The [`gleam/result`](https://hexdocs.pm/gleam_stdlib/gleam/result.html) standard library module contains functions for working with results. Gleam programs will make heavy use of this module to avoid excessive nested case expressions when calling multiple functions that can fail.

[`map`](https://hexdocs.pm/gleam_stdlib/gleam/result.html#map) updates a value held within the Ok of a result by calling a given function on it. If the result is an error then the function is not called.

[`try`](https://hexdocs.pm/gleam_stdlib/gleam/result.html#try) runs a result-returning function on the value held within an Ok of a result. If the result is an error then the function is not called. This is useful for chaining together multiple function calls that can fail, one after the other, stopping at the first error.

[`unwrap`](https://hexdocs.pm/gleam_stdlib/gleam/result.html#unwrap) extracts the success value from a result, or returning a default value if the result is an error.

Result functions are often used with pipelines to chain together multiple calls to result-returning functions.

```gleam
import gleam/int
import gleam/io
import gleam/result

pub fn main() {
  io.println("=== map ===")
  let _ = io.debug(result.map(Ok(1), fn(x) { x * 2 }))
  let _ = io.debug(result.map(Error(1), fn(x) { x * 2 }))

  io.println("=== try ===")
  let _ = io.debug(result.try(Ok("1"), int.parse))
  let _ = io.debug(result.try(Ok("no"), int.parse))
  let _ = io.debug(result.try(Error(Nil), int.parse))

  io.println("=== unwrap ===")
  io.debug(result.unwrap(Ok("1234"), "default"))
  io.debug(result.unwrap(Error(Nil), "default"))

  io.println("=== pipeline ===")
  int.parse("-1234")
  |> result.map(int.absolute_value)
  |> result.try(int.remainder(_, 42))
  |> io.debug
}
```

---

[

## Dict module

](https://tour.gleam.run/everything/#standard-library-dict-module)

The [`gleam/dict`](https://hexdocs.pm/gleam_stdlib/gleam/dict.html) standard library module defines Gleam's `Dict` type and functions for working with it. A dict is a collection of keys and values which other languages may call a hashmap or table.

[`new`](https://hexdocs.pm/gleam_stdlib/gleam/dict.html#new) and [`from_list`](https://hexdocs.pm/gleam_stdlib/gleam/dict.html#from_list) can be used to create new dicts.

[`insert`](https://hexdocs.pm/gleam_stdlib/gleam/dict.html#insert) and [`delete`](https://hexdocs.pm/gleam_stdlib/gleam/dict.html#delete) are used to add and remove items from a dict.

Like lists, dicts are immutable. Inserting or deleting an item from a dict will return a new dict with the item added or removed.

Dicts are unordered! If it appears that the items in a dict are in a certain order, it is incidental and should not be relied upon. Any ordering may change without warning in future versions or on different runtimes.

```gleam
import gleam/dict
import gleam/io

pub fn main() {
  let scores = dict.from_list([#("Lucy", 13), #("Drew", 15)])
  io.debug(scores)

  let scores =
    scores
    |> dict.insert("Bushra", 16)
    |> dict.insert("Darius", 14)
    |> dict.delete("Drew")
  io.debug(scores)
}
```

---

[

## Option module

](https://tour.gleam.run/everything/#standard-library-option-module)

Values in Gleam are not nullable, so the [`gleam/option`](https://hexdocs.pm/gleam_stdlib/gleam/option.html) standard library module defines Gleam's [`Option`](https://hexdocs.pm/gleam_stdlib/gleam/option.html#Option) type, which can be used to represent a value that is either present or absent.

The option type is very similar to the result type, but it does not have an error value. Some languages have functions that return an option when there is no extra error detail to give, but Gleam always uses result. This makes all fallible functions consistent and removes any boilerplate that would be required when mixing functions that use each type.

```gleam
import gleam/io
import gleam/option.{type Option, None, Some}

pub type Person {
  Person(name: String, pet: Option(String))
}

pub fn main() {
  let person_with_pet = Person("Al", Some("Nubi"))
  let person_without_pet = Person("Maria", None)

  io.debug(person_with_pet)
  io.debug(person_without_pet)
}
```

---

### Advanced features

---

[

## Opaque types

](https://tour.gleam.run/everything/#advanced-features-opaque-types)

_Opaque types_ are types where a custom type itself is public and can be used by other modules, but the constructors for the type are private and can only be used by the module that defines the type. This prevents other modules from constructing or pattern matching on the type.

This is useful for creating types with _smart constructors_. A smart constructor is a function that constructs a value of a type, but is more restrictive than if the programmer were to use one of the type's constructors directly. This can be useful for ensuring that the type is used correctly.

For example, this `PositiveInt` custom type is opaque. If other modules want to construct one they have to use the `new` function, which ensures that the integer is positive.

```gleam
import gleam/io

pub fn main() {
  let positive = new(1)
  let zero = new(0)
  let negative = new(-1)

  io.debug(to_int(positive))
  io.debug(to_int(zero))
  io.debug(to_int(negative))
}

pub opaque type PositiveInt {
  PositiveInt(inner: Int)
}

pub fn new(i: Int) -> PositiveInt {
  case i >= 0 {
    True -> PositiveInt(i)
    False -> PositiveInt(0)
  }
}

pub fn to_int(i: PositiveInt) -> Int {
  i.inner
}
```

---

[

## Use

](https://tour.gleam.run/everything/#advanced-features-use)

Gleam lacks exceptions, macros, type classes, early returns, and a variety of other features, instead going all-in with just first-class-functions and pattern matching. This makes Gleam code easier to understand, but it can sometimes result in excessive indentation.

Gleam's `use` expression helps out here by enabling us to write code that uses callbacks in an unindented style, as shown in the code window.

The higher order function being called goes on the right hand side of the `<-`operator. It must take a callback function as its final argument.

The argument names for the callback function go on the left hand side of the `<-`operator. The function can take any number of arguments, including zero.

All the remaining code in the enclosing `{}` block becomes the body of the callback function.

This is a very capable and useful feature, but excessive application of `use` may result in unclear code, especially to beginners. Usually the regular function call syntax results in more approachable code!

```gleam
import gleam/io
import gleam/result

pub fn main() {
  let _ = io.debug(without_use())
  let _ = io.debug(with_use())
}

pub fn without_use() -> Result(String, Nil) {
  result.try(get_username(), fn(username) {
    result.try(get_password(), fn(password) {
      result.map(log_in(username, password), fn(greeting) {
        greeting <> ", " <> username
      })
    })
  })
}

pub fn with_use() -> Result(String, Nil) {
  use username <- result.try(get_username())
  use password <- result.try(get_password())
  use greeting <- result.map(log_in(username, password))
  greeting <> ", " <> username
}

// Here are some pretend functions for this example:

fn get_username() -> Result(String, Nil) {
  Ok("alice")
}

fn get_password() -> Result(String, Nil) {
  Ok("hunter2")
}

fn log_in(_username: String, _password: String) -> Result(String, Nil) {
  Ok("Welcome")
}
```

---

[

## Use sugar

](https://tour.gleam.run/everything/#advanced-features-use-sugar)

The `use` expression is syntactic sugar for a regular function call and an anonymous function.

This code:

use a, b <- my_function
next(a)
next(b)

Expands into this code:

my_function(fn(a, b) {
  next(a)
  next(b)
})

To ensure that your `use` code works and is as understandable as possible, the right-hand-side ideally should be a function call rather than a pipeline or other expression, which is typically more difficult to read.

`use` is an expression like everything else in Gleam, so it can be placed within blocks.

```gleam
import gleam/io
import gleam/result

pub fn main() {
  let x = {
    use username <- result.try(get_username())
    use password <- result.try(get_password())
    use greeting <- result.map(log_in(username, password))
    greeting <> ", " <> username
  }

  case x {
    Ok(greeting) -> io.println(greeting)
    Error(error) -> io.println("ERROR:" <> error)
  }
}

// Here are some pretend functions for this example:

fn get_username() {
  Ok("alice")
}

fn get_password() {
  Ok("hunter2")
}

fn log_in(_username: String, _password: String) {
  Ok("Welcome")
}
```

---

[

## Todo

](https://tour.gleam.run/everything/#advanced-features-todo)

The `todo` keyword is used to specify that some code is not yet implemented.

The `as "some string"` is optional, though you may wish to include the message if you have more than one code block marked as `todo` in your code.

When used the Gleam compiler will print a warning to remind you the code is unfinished, and if the code is run then the program will crash with the given message.

```gleam
pub fn main() {
  todo as "I haven't written this code yet!"
}

pub fn todo_without_reason() {
  todo
}
```

---

[

## Panic

](https://tour.gleam.run/everything/#advanced-features-panic)

The `panic` keyword is similar to the `todo` keyword, but it is used to crash the program when the program has reached a point that should never be reached.

This keyword should almost never be used! It may be useful in initial prototypes and scripts, but its use in a library or production application is a sign that the design could be improved. With well designed types the type system can typically be used to make these invalid states unrepresentable.

```gleam
import gleam/io

pub fn main() {
  print_score(10)
  print_score(100_000)
  print_score(-1)
}

pub fn print_score(score: Int) {
  case score {
    score if score > 1000 -> io.println("High score!")
    score if score > 0 -> io.println("Still working on it")
    _ -> panic as "Scores should never be negative!"
  }
}
```

---

[

## Let assert

](https://tour.gleam.run/everything/#advanced-features-let-assert)

`let assert` is the final way to intentionally crash your Gleam program. It is similar to the `panic` keyword in that it crashes when the program has reached a point that should never be reached.

`let assert` is similar to `let` in that it is a way to assign values to variables, but it is different in that the pattern can be _partial_. The pattern does not need to match every possible value of the type being assigned.

Like `panic` this feature should be used sparingly, and likely not at all in libraries.

```gleam
import gleam/io

pub fn main() {
  let a = unsafely_get_first_element([123])
  io.debug(a)

  let b = unsafely_get_first_element([])
  io.debug(b)
}

pub fn unsafely_get_first_element(items: List(a)) -> a {
  // This will panic if the list is empty.
  // A regular `let` would not permit this partial pattern
  let assert [first, ..] = items
  first
}
```

---

[

## Externals

](https://tour.gleam.run/everything/#advanced-features-externals)

Sometimes in our projects we want to use code written in other languages, most commonly Erlang and JavaScript, depending on which runtime is being used. Gleam's _external functions_ and _external types_ allow us to import and use this non-Gleam code.

An external type is one that has no constructors. Gleam doesn't know what shape it has or how to create one, it only knows that it exists.

An external function is one that has the `@external` attribute on it, directing the compiler to use the specified module function as the implementation, instead of Gleam code.

The compiler can't tell the types of functions written in other languages, so when the external attribute is given type annotations must be provided. Gleam trusts that the type given is correct so an inaccurate type annotation can result in unexpected behaviour and crashes at runtime. Be careful!

External functions are useful but should be used sparingly. Prefer to write Gleam code where possible.

```gleam
import gleam/io

// A type with no Gleam constructors
pub type DateTime

// An external function that creates an instance of the type
@external(javascript, "./my_package_ffi.mjs", "now")
pub fn now() -> DateTime

// The `now` function in `./my_package_ffi.mjs` looks like this:
// export function now() {
//   return new Date();
// }

pub fn main() {
  io.debug(now())
}
```

---

[

## Multi target externals

](https://tour.gleam.run/everything/#advanced-features-multi-target-externals)

Multiple external implementations can be specified for the same function, enabling the function to work on both Erlang and JavaScript.

If a function doesn't have an implementation for the currently compiled-for target then the compiler will return an error.

You should try to implement functions for all targets, but this isn't always possible due to incompatibilities in how IO and concurrency works in Erlang and JavaScript. With Erlang concurrent IO is handled transparently by the runtime, while in JavaScript concurrent IO requires the use of promises or callbacks. If your code uses the Erlang style it is typically not possible to implement in JavaScript, while if callbacks are used then it won't be compatible with most Gleam and Erlang code as it forces any code that calls the function to also use callbacks.

Libraries that make use of concurrent IO will typically have to decide whether they support Erlang or JavaScript, and document this in their README.

```gleam
import gleam/io

pub type DateTime

@external(erlang, "calendar", "local_time")
@external(javascript, "./my_package_ffi.mjs", "now")
pub fn now() -> DateTime

pub fn main() {
  io.debug(now())
}
```

---

[

## External gleam fallbacks

](https://tour.gleam.run/everything/#advanced-features-external-gleam-fallbacks)

It's possible for a function to have both a Gleam implementation and an external implementation. If there exists an external implementation for the currently compiled-for target then it will be used, otherwise the Gleam implementation is used.

This may be useful if you have a function that can be implemented in Gleam, but there is an optimised implementation that can be used for one target. For example, the Erlang virtual machine has a built-in list reverse function that is implemented in native code. The code here uses this implementation when running on Erlang, as it is then available.

```gleam
import gleam/io

@external(erlang, "lists", "reverse")
pub fn reverse_list(items: List(e)) -> List(e) {
  tail_recursive_reverse(items, [])
}

fn tail_recursive_reverse(items: List(e), reversed: List(e)) -> List(e) {
  case items {
    [] -> reversed
    [first, ..rest] -> tail_recursive_reverse(rest, [first, ..reversed])
  }
}

pub fn main() {
  io.debug(reverse_list([1, 2, 3, 4, 5]))
  io.debug(reverse_list(["a", "b", "c", "d", "e"]))
}
```