#import "@preview/touying:0.7.3": *
#import themes.simple: *
#import "@preview/mannot:0.3.3": *
#import "@preview/theorion:0.6.0": *
// #import cosmos.simple: *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#show: simple-theme.with(
  aspect-ratio: "16-9",
  footer: [Simple slides],
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

#title-slide[
  = Sets, sets everywhere

  #v(2em)

  Abiria #h(1em)

  #datetime(year: 2026, month: 5, day: 17).display("[month repr:long] [day], [year]")
]

= What is algebra about?

= Propositions and logics

== Conditionals

- $p -> q$

- True if:
  - $p$ is true, $q$ is true.
  - $p$ is false, $q$ is true.
  - $p$ is false, $q$ is false.
- False if:
  - $p$ is true, $q$ is false.

== Vacuous truth

- If Abiria has two girlfriends, then the earth is flat.

- If $x$ is a real number and $x^2 + 4 = 0$, then $x$ is an odd number.

- An empty set is a subset of any set.
  - Let $A$ be a set.
  - $x in nothing -> x in A$

#pagebreak()

- $f : nothing -> Y$ is a function.
  - For a function to be well-defined, every element in the domain must have a unique image.
  - i.e., $x in X -> x "has an image in" f$.

- $f : nothing -> Y$ is an injective function.
  - Injective: $x, y in X -> f(x) = f(y) -> x = y$.

#pagebreak()

- $nothing$ is linearly independent subset.
  - A set is said to be linearly independent, if the only solution to $sum_i c_i v_i = 0$ is $c_i = 0$ for all $i$.
  - $v_i in nothing -> sum_i c_i v_i = 0 -> c_i = 0$

// == Contraposition

= Sets

== Set-builder notation

=== Comprehension form

- $X = { x | x in U, P(x) }$

- Or alternatively, $X = { x in U | P(x) }$

// - $#forallp(x => $#x in X <-> #x in U and P(#x)$)$

=== Comprehension + replacement form

- $X = { f(x) | x in U, P(x) }$

- $#forallp(x => $#x in X <-> #existsp(x: $x'$, xp => $#xp in U and P(#xp) and #x = f(#xp)$)$)$

=== Examples

- $A_1 = { x^2 | x in ZZ }$

- $A_2 = { x in RR | -2 < x, x < 10 }$

- $A_3 = { x in RR | x != 0 }$

- $A_4 = { (x, y) | x in RR, y in RR }$

- $A_5 = { 2x + 3y | x in ZZ, y in ZZ }$

- $A_6 = { x in CC | x^4 = 1 }$

- $A_7 = { (x, sin(x)) | x in RR }$

- $A_8 = { x in CC | |x| = 1 }$

- $A_9 = { { x } | x in NN }$

- $A_10 = { A in cal(P)(NN) | forall x in A ( x "is prime" ) }$

// - $A_11 = { x | x "is an infinite sequence where" x_i "is integers" }$

== Subsets

- $A subset B := forall x (x in A -> x in B)$

=== Examples

- $A = { x in ZZ | x "is a multiple of" 10 }$ \
  $B = { x in ZZ | x "is a multiple of " 100 }$
  - $A subset B$

- $A = { x in CC | x^1212 = 1 }$, $B = { x in CC | x^2424 = 1 }$
  - $A subset B$

== Axiom of Extensionality

#axiom[Axiom of Extensionality][
  Two sets $A$ and $B$ are equal if and only if $A subset B$ and $B subset A$.
]

== Notations

#definition[
  + $ZZ_n = { x in ZZ | x "is non negative, and" x "is less than" n }$

  + $n ZZ = { n x | x in ZZ }$

  + $A + B = { a + b | a in A, b in B }$
]

== Extensionality: Example

- Is $2 ZZ = ZZ$ true?

- $2 ZZ = { 2 x | x in ZZ }$

- $2 ZZ$ is a set of all even numbers.

- Every even number $x$ is in $ZZ$. i.e., $2ZZ subset ZZ$.

- However, $5$ is integer but not in $2 ZZ$.

- Therefore, $2 ZZ != ZZ$.

#pagebreak()

- Is $ZZ + ZZ = ZZ$ true?

- $ZZ + ZZ = { x + y | x in ZZ, y in ZZ }$

- $x + y$ is closed under addition.

#pagebreak()

- $ZZ + ZZ subset ZZ$:
  - $n in ZZ + ZZ$ means there are integers $x$, $y$ such that $n = x + y$
  - Hence, $n in ZZ$.

- $ZZ subset ZZ + ZZ$:
  - If $n in ZZ$, then there are integers $n$, $0$ such that $n = n + 0$.
  - Hence, $n in ZZ + ZZ$.

- Therefore, $ZZ + ZZ = ZZ$.

#pagebreak()

- Is $2ZZ + 3ZZ = ZZ$ true?

- In other words, is
  - sum of an even number and a multiple of $3$ always an integer?
  - any integer is a sum of an even number and a multiple of $3$?

- $2 ZZ + 3 ZZ subset ZZ$
  - $2 n + 3 m$ is always an integer.

#pagebreak()

- Can $2 n + 3 m$ be $1$?

- If so, $2 n + 3 m = 1$ for some integers $n$, $m$.

- If $x$ is an integer, we get $x = x dot 1$.

- $x = x (2n + 3m)$

- $x = 2 (n x) + 3 (m x)$

- Each $n x$ and $m x$ is an integer. Thus, $ZZ subset 2 ZZ + 3 ZZ$.

- Therefore, $2 ZZ + 3 ZZ = ZZ$.

// == Operations on Sets

// == Ordered pairs

// == Products

// = Functions
// == Well-defined functions
// == Composition
// == Injections, Surjections, and Bijections
// == Inverse
