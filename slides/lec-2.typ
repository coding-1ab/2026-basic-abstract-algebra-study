#import "@preview/touying:0.7.3": *
#import themes.simple: *
#import "@preview/mannot:0.3.3": *
#import "@preview/theorion:0.6.0": *
// #import cosmos.simple: *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#let cl-orange = rgb("#fe580f")
#let cl-grapefruit = rgb("#fe4036")
#let cl-magenta = rgb("#fe2562")

#let primary-color = cl-grapefruit.darken(5%)
#let primary-color-darken = cl-grapefruit.darken(70%)
#let text-color = rgb("#3f3f46")
#let solution-color = rgb("#0074d9")

#show: simple-theme.with(
  aspect-ratio: "16-9",
  footer: [Coding Lab 2026 Basic Abstract Algebra Study - Lecture 2],
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
  = Functions

  #v(2em)

  Abiria #h(1em)

  #datetime(year: 2026, month: 5, day: 17).display("[month repr:long] [day], [year]")
]

// == Outline <touying:hidden>

// #components.adaptive-columns(outline(title: none, indent: 1em))

== A quick recap

- Conditional: $p -> q$.

- Contrapositive: $not q -> not p$

- Subset: $A subset B$ is essentially a conditional of $x in A -> x in B$.

- Extensionality: $A = B$ means $A subset B$ and $B subset A$.

== Recap examples

Lec 1 HW Q1

#pagebreak()

$ZZ = 2 ZZ$? Prove or disprove.

#pagebreak()

If $ZZ = n ZZ$ for some integer $n$, then $n$ is either $1$ or $-1$. Prove or disprove.

cf. Lec 1 HW Q7

#pagebreak()

${ x y | x, y in ZZ } = ZZ$? Prove or disprove.

cf. PCSA Q2

#pagebreak()

$49 ZZ + 10 ZZ = ZZ$? Prove or disprove.

cf. Lec 1 HW Q4

#pagebreak()

If $x^n != 1$, then $x^m != 1$ for any factors $m$ of $n$. Prove or disprove.

cf. Lec 1 HW Q5

= Function

== Well-defined function

#definition[Function][
  A _function_ consists of three data:

  + A set, called the _domain_.
  + A set, called the _codomain_.
  + An assignment with the following property:
    + Every element in the domain is assigned an element in the codomain.
    + Such an assignment is unique.
]

#definition[Terminology & Notaton][
  $f : X -> Y$; $f$ is a function whose domain is $X$ and codomain is $Y$.

  *Image*: The elements in the codomain that are assigned by $f$.
  *Preimage*: The elements in the domain that are assigned by $f$.

  $f(x) = y$

  $x mapsto y$
]

== Examples for well?defined functions

+ $f : QQ -> (ZZ times ZZ)$, If $x$ can be written as $p / q$, then $f(x) = (p, q)$.
+ $f : RR times RR -> RR$, If $x$ can be written as $(x_1, x_2)$, then $f(x) = x_1$.
+ $f : ZZ^+ -> CC$, For $n in ZZ^+$, if $z in CC$ satisfies $z^n = 1$, then $f(n) = z$.
+ $f : CC -> CC slash #math.class("normal", sym.eq)$, If $X$ contains only one element $x$, then $f(x) = X$.
+ $f : RR -> RR$, $f(x) = tan(x)$.
+ $f : ZZ -> ZZ$, For $x in ZZ$, if $y$ is a multiple of $x$, then $f(x) = y$.
+ $f : ZZ -> { nothing }$, $f(x) = nothing$.
+ $f : ZZ -> { n ZZ | n in ZZ }$, $f(x) = x ZZ$.
// + $f : ZZ -> { { m in ZZ | m equiv 0 thick (mod n) } | n in ZZ }$, $f(x) = x ZZ$.
// + $f : ZZ -> ZZ slash ZZ_10$
// + $f : CC -> { { x | |x| = r } | r in RR without RR^- }$, $f(x) = |x|$.

== Equality of functions

#definition[Equality of functions][
  Two functions $f, g : X -> Y$ are considered to be _equal_ if for any $x$ in the domain, $f(x) = g(x)$ holds.
]

== Identity function

#definition[Identity function][
  An _identity function_ of a set $X$ is a function $f : X -> X$ such that $f(x) = x$ for all $x$ in $X$.
]

=== Notations

- $1_X : X -> X$
- $I_X : X -> X$
- $id_X : X -> X$

== Bonus: How many functions exist between two sets?

cf. PCSA Q16

Let $X$ and $Y$ be two finite sets, with the size $n$ and $m$ resp.

== Injection

#definition[Injection][
  A function $f$ is said to be _injective_ or called an _injection_ if for any elements $x != y$ in the domain, $f(x) != f(y)$ holds.
]

#definition[Injection - equivalent][
  A function $f$ is said to be _injective_ or called an _injection_ if for any elements $x$ and $y$, $f(x) = f(y)$ then $x = y$.
]

#pagebreak()

=== Examples

+ $f : RR -> RR$, $f(x) = x^2$
+ $f : RR -> RR$, $f(x) = sin(x)$
+ $f : RR -> RR$, $f(x) = a + x$ for any $a in RR$
+ $f : RR -> RR$, $f(x) = a x$ for any $a in RR$
+ $f : RR -> RR$, $f(x) = e^x$
+ $f : RR -> RR$, $f(x) = |x|$
+ $f : ZZ times ZZ -> ZZ$, $f(x, y) = x + y$

== Surjection

#definition[Surjection][
  A function $f$ is said to be _surjective_ or called a _surjection_ if for any element $y$ in the codomain, there exists an element $x$ in the domain such that $f(x) = y$.
]

#pagebreak()

=== Examples

+ $f : RR -> RR$, $f(x) = x^2$
+ $f : RR -> RR$, $f(x) = sin(x)$
+ $f : RR -> RR$, $f(x) = a + x$ for any $a in RR$
+ $f : RR -> RR$, $f(x) = a x$ for any $a in RR$
+ $f : RR -> RR$, $f(x) = e^x$
+ $f : RR -> RR$, $f(x) = |x|$
+ $f : ZZ times ZZ -> ZZ$, $f(x, y) = x + y$

== Bonus: Coincidence of two in finite cases

#theorem[][
  For two finite sets $X$ and $Y$ such that $|X| = |Y|$, a function $f : X -> Y$ is injective if and only if surjective.
]

cf. PCSA Q20.

== Bijection

#definition[Bijection][
  A function $f$ is said to be _bijection_ or called a _bijection_ if it is both injective and surjective.
]

== Relationship between functions and sizes of sets

For two sets $X$ and $Y$,

- If there exists an injection $f : X -> Y$, then $|X| <= |Y|$.

- If there exists a surjection $f : X -> Y$, then $|X| >= |Y|$.

- If there exists a bijection $f : X -> Y$, then $|X| = |Y|$.

== Bonus: How many bijections exist?

Let $X$ and $Y$ be two finite sets, with the size $n$.

Example:

- A bijection on three-element sets

== Composition

#definition[Composition][
  For two functions $f : X -> Y$ and $g : Y -> Z$, the _composition of $f$ and $g$_ is a function $g compose f : X -> Z$ given by $(g compose f)(x) = g(f(x))$.
]

=== Notes

- Be careful with the order.
- Does the composition always exist between any two functions?
- Do they commute?

=== Examples

+ $alpha : RR -> RR$, $beta : RR -> RR$, $alpha(x) = x^2 + 2$, $beta(x) = x - 1$
+ $1_X : X -> X$, $1_X : X -> X$, $1_X(x) = x$, $1_X(x) = x$
// + $f : RR -> RR$, $g : $, $1_X(x) = x$, $1_X(x) = x$

== Q33

== Inverses

#definition[Inverse of a function][
  The _inverse_ of a function $f : X -> Y$ is a function $f^(-1) : Y -> X$ such that $f^(-1) compose f = 1_X$ and $f compose f^(-1) = 1_Y$.
]

=== Examples

- $f : RR -> RR$, $g : RR -> RR$, $f(x) = x + 5$, $g(x) = x - 5$
- $f : NN -> NN$, $g : NN -> NN$, $f(x) = x + 5$, $g(x) = |x - 5|$

== Invertible iff bijective

#theorem[
  A function is invertible if and only if it is bijective.
]

#focus-slide[
  #text(size: 48pt)[
    Notice & Solution time
  ]
]
