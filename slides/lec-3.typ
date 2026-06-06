#import "@preview/touying:0.7.3": *
#import themes.simple: *
#import "@preview/mannot:0.3.3": *
#import "@preview/theorion:0.6.0": *
// #import cosmos.simple: *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion
#import "@preview/diagraph:0.3.7": raw-render

#let cl-orange = rgb("#fe580f")
#let cl-grapefruit = rgb("#fe4036")
#let cl-magenta = rgb("#fe2562")

#let primary-color = cl-grapefruit.darken(5%)
#let primary-color-darken = cl-grapefruit.darken(70%)
#let text-color = rgb("#3f3f46")
#let solution-color = rgb("#0074d9")

#show: simple-theme.with(
  aspect-ratio: "16-9",
  footer: [Coding Lab 2026 Basic Abstract Algebra Study - Lecture 3],
  primary: primary-color-darken,
)

#let color-index = state("color-index", 0)

// Define the 16-color Math Palette
#let mat-colors = (
  v1: rgb("#cc517a"), // Rose
  v2: rgb("#3f83a6"), // Blue
  v3: rgb("#2d539e"), // Dark Blue
  v4: rgb("#668e3d"), // Green
  v5: rgb("#c57339"), // Orange
  v6: rgb("#7759b4"), // Purple
  v7: rgb("#33374c"), // Dark Slate
  v8: rgb("#8389a3"), // Slate
  v9: rgb("#cc3768"), // Red
  v10: rgb("#598030"), // Dark Green
  v11: rgb("#b6662d"), // Brown
  v12: rgb("#22478e"), // Navy
  v13: rgb("#6845ad"), // Deep Purple
  v14: rgb("#327698"), // Cyan
  v15: rgb("#e03c31"), // Bright Red
  v16: rgb("#00875A"), // Emerald
)

// highlight the quantifier and the parentheses,
#let forallp(formula, x: $x$, color: none) = {
  context {
    // Determine the color to use
    let display-color = if color == none {
      let i = color-index.get()
      mat-colors.values().at(calc.rem(i, mat-colors.len()))
    } else {
      color
    }

    // Only increment the global cycle if the user DIDN'T provide a manual color
    // This keeps the automatic sequence "pure"
    if color == none {
      color-index.update(n => n + 1)
    }

    $mark(forall #x paren.l, color: #display-color) #formula(mark(x, color: display-color)) mark(paren.r, color: #display-color)$
  }
}

// highlight the quantifier and the parentheses,
#let existsp(formula, x: $x$, color: none) = {
  context {
    // Determine the color to use
    let display-color = if color == none {
      let i = color-index.get()
      mat-colors.values().at(calc.rem(i, mat-colors.len()))
    } else {
      color
    }

    // Only increment the global cycle if the user DIDN'T provide a manual color
    // This keeps the automatic sequence "pure"
    if color == none {
      color-index.update(n => n + 1)
    }

    $mark(exists #x paren.l, color: #display-color) #formula(mark(x, color: display-color)) mark(paren.r, color: #display-color)$
  }
}

#set page(
  // left colored bar
  background: align(left, rect(width: 10pt, height: 100%, fill: gradient.linear(
    dir: ttb,
    cl-orange,
    cl-magenta,
  ))),
)

#title-slide[
  = Operations

  #v(2em)

  Abiria #h(1em)

  #datetime(year: 2026, month: 6, day: 5).display("[month repr:long] [day], [year]")
]

== A quick recap

- Well-defined function: 1. Existence of the image. 2. Uniqueness of the image.
  - Injection: $x != y$ then $f(x) != f(y)$.
  - Surjection: Range = Codomain.
  - Bijections are permutations!

- Identity function: A function $1_X : X -> X$ s.t. $1_X(x) = x$ for all $x$ in $X$.

- Equality of functions, composition of functions.

== Homework 2 review

+ Q1

+ Q2

+ Q3

+ Q4

+ Q5

== Recap examples

Are they well-defined? Injective? Surjective?

+ $f : RR -> RR$, $f(x) = x^2$
// well-defined, not injective, not surjective.

+ $f : ZZ -> cal(P)(ZZ)$, $f(x) = x ZZ$.
// well-defined, injective, not surjective.

+ $f : ZZ -> ZZ$, $f(x) = x^x$.
// not well-defined, as 0^0 is undefined.
+ $f : QQ -> (ZZ times ZZ)$, If $x$ can be written as $p / q$, then $f(x) = (p, q)$.
// not well-defined
+ $f : ZZ -> ZZ$, For $x in ZZ$, if $y$ is a multiple of $x$, then $f(x) = y$.
// not well-defined
+ $f : { O, E } -> { O, E }$ where $O$ is the set of all odd integers and $E$ is the set of all even integers. If there exists $y in x$ and $y + 5 in O$, then $f(x) = O$. Otherwise, $f(x) = E$.
// well-defined, bijective.

+ $f : RR -> RR$, $f(x) = a + x$ for any $a in RR$
// well-defined, always bijective.

+ $f : RR -> RR$, $f(x) = a x$ for any $a in RR$
// well-defined, not always injective, not always surjective.

+ $f : ZZ times ZZ -> ZZ$, $f(x, y) = x + y$
// well-defined, not injective, surjective.

#pagebreak()

cf. PCSA Q5.

Let $1_X$ be the identity function of the set $X$.

Let $S_1$ be the set of all possible functions that can be created by composing $1_X$ any number of times in any order.

What is the value of $|S_1|$?

#pagebreak()

cf. PCSA Q5.

Let $f : ZZ -> ZZ$ be a function such that $f(x) = - x$.

Let $D_1$ be the set of all possible functions that can be created by composing $f$ any number of times in any order.

What is the value of $|D_1|$?

#pagebreak()

cf. PCSA Q5.

Let $f : RR without { 0, 1 } -> RR without { 0, 1 }$ be a function such that $f(x) = 1 - x^(-1)$.

Let $C_3$ be the set of all possible functions that can be created by composing $f$ any number of times in any order.

What is the value of $|C_3|$?

= Orders and products

== Ordered pairs

#definition[Equality of ordered pairs][
  $(a, b) = (c, d)$ if and only if $a = c$ and $b = d$.
]

- $(-3, 5) = (5, -3)$?

Map each ordered pair to an operation:

- e.g., map $(x, y)$ to $x - y$. Are $(2, 7)$ and $(7, 2)$ mapped to the same result?

#pagebreak()

=== Example: Directed graphs

- A directed graph is an ordered pair $(V, E)$ where $V$ is the set of vertices and $E$ is the set of edges. Each edge $e in E$ is again an ordered pair $(v_1, v_2)$ where $v_1$ and $v_2$ are vertices.

#raw-render(
  ```dot
  digraph {
   rankdir=LR;
   // node [shape=circle];
   node [fontsize=18];

   A [label="Abiria"];
   V [label="Vector4f"];
   K [label="Kri"];
   D [label="Devchj"];

   A -> V;
   D -> K;
   D -> A;
   V -> D;
   K -> A;
   K -> V [label="a", color=red, fontcolor=red];
   V -> K [label="b", color=blue, fontcolor=blue];
  }
  ```,
)

#pagebreak()

=== How many ordered pairs do we have?

- cf. PCSA Q6.

== Cartesian product

#definition[Cartesian product][
  A _Cartesian product_ of $A$ and $B$ is the set of all ordered pairs $(x, y)$ where $x in A$ and $y in B$.
]

- cf. PCSA Q7.

- cf. PCSA Q9.

== Binary operations are functions!

A set $S$ is given.

#definition[Binary operation][
  A function $f : S times S -> S$ is called a _binary operation_ on $S$.
]

#note[
  It is often denoted with the infix notation $f(x, y) = x * y$.
]

== Closedness

As a binary operation is a function, the result of $f(x, y)$ (or $x * y$) should be an element of $S$ if $x, y in S$.

=== Examples

+ A standard division is not a binary operation on $ZZ$.

  - Counterexample: $5 div 7 in.not ZZ$ even though $5, 7 in ZZ$.

+ A subtraction is not a binary operation on $ZZ^+$.

  - Counterexample: $5 - 7 in.not ZZ^+$ even though $5, 7 in ZZ^+$.


== Examples of binary operations

+ Addition on $ZZ$, $x + y$.
// yes

+ Subtraction on $ZZ$, $x + y$.
// yes

+ Multiplication on $ZZ$, $x y$.
// yes

+ Exponentiation on $ZZ$, $x^y$.
// no

+ Division on $RR$, $x div y$.
// no

+ Max on $RR$, $max(x, y)$.
// yes

+ $gcd$ on $ZZ^+$, $gcd(x, y)$.
// yes

+ $mod$ on $ZZ^+$, $mod(x, y)$.
// yes

+ Average on $QQ$, $(x + y) slash 2$.
// yes

+ Multiplication on $PP$, the set of all primes, $p q$.
// no

+ Addition on $10 ZZ$, the set of all multiples of $10$, $x + y$.
// yes

+ Vector addition on $RR^4$, the 4-dimensional Euclidean vector space, $v + w$.
// yes

+ Inner product on $RR^4$, $v dot w$.
// no

+ Matrix multiplication on $M_4$, the set of all $4 times 4$ matrices over $RR$, $A B$.
// yes

+ Addition on $RR without QQ$, the set of all irrational numbers, $x + y$.
// no

+ Intersection on $cal(P)(X)$, the power set of a set $X$, $A inter B$.
// yes

+ Union on $cal(P)(X)$, $A union B$.
// yes

+ Cartesian product on $cal(P)(X)$, $A times B$.
// no

+ Set difference on $cal(P)(X)$, $A without B$.
// yes

+ Symmetric difference on $cal(P)(X)$, $A triangle B$.
// yes

+ XOR on ${ 0, 1 }^32$, the set of all 32-bit binary strings, $x plus.o y$.
// yes

+ Concatenation on $Sigma^*$, the set of all strings, $x "++" y$.
// yes

+ Conditional on $scr(P)$, the set of all true propositions, $p -> q$.
// no

+ Tetration on $ZZ^+$, $x arrow.t arrow.t y$.
// yes

+ Multiplication on $mu_1212$, the set of all $1212$-th roots of unity. $x y$.
// yes

+ Addition on $mu_1212$, $x + y$.
// no

+ Set addition on $cal(P)(ZZ)$, $A + B$.
// yes

+ Function composition on $ZZ^ZZ$, the set of all functions from $ZZ$ to $ZZ$, $g compose f$.
// yes

+ Function composition on $S_2$, the set of all bijective functions from ${ 0, 1 }$ to ${ 0, 1 }$, $g compose f$.
// yes

+ Function composition on $ZZ^ZZ$, the set of all injective functions from $ZZ$ to $ZZ$, $g compose f$.
// yes

== Commutativity

#definition[Commutative binary operation][
  A binary operation $f : S times S -> S$ is said to be _commutative_ if $f(x, y) = f(y, x)$ for all $x, y in S$.
]

#note[
  In the infix notation, $x * y = y * x$ for all $x, y in S$.
]

#focus-slide[
  #text(size: 48pt)[
    Notice & Solution time
  ]
]
