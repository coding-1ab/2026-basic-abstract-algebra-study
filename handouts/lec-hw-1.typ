// #import "../exm/lib/lib.typ": *
#import "@preview/theorion:0.6.0": cosmos, emph-block, proof
#import cosmos.rainbow: lemma, note, proposition

#import "../template.typ": *

// metadata
#let author = "Abiria"
#let date = datetime(year: 2026, month: 5, day: 18)
#let title = "Lecture 1 Homeworks"
#let emp-title = upper(title)
#let course-name = "2026 Basic Abstract Algebra Study"
#let institution = "Coding Lab"
#let version = "0.0.0"

#show: template.with(
  author: author,
  date: date,
  title: title,
  emp-title: emp-title,
  course-name: course-name,
  institution: institution,
  version: version,
)

#let problem-by(person) = [
  _Problem by_ \@#link(person.link)[#person.name].
]

#let escentia07 = (name: "escentia07", link: "https://escentia07.tistory.com")

#note[Notations][
  The following notations will be used throughout the following questions.

  - $ZZ$: A set of all integers.
  - $ZZ^+$: A set of all positive integers. i.e., $ZZ^+ = { 1, 2, 3, ... }$.
  - $ZZ_n$: A set of non-negative integers from $0$ to $n - 1$ for some positive integer $n$. For instance, $ZZ_4 = { 0, 1, 2, 3 }$.
  - $n ZZ$: A set given as ${ n x | x in ZZ }$ for an integer $n$. i.e., the set of all multiples of $n$ in $ZZ$. For instance, $5 ZZ = { ..., -10, -5, 0, 5, 10, ... }$.
  - $QQ$: A set of all rational numbers.
  - $RR$: A set of all real numbers.
  - $RR^+$: A set of all positive real numbers.
  - $CC$: A set of all complex numbers.
  - $A + B$: A set given as ${ a + b | a in A, b in B }$. For instance, $ZZ_2 + ZZ_3 = { (0 + 0), (0 + 1), (0 + 2), (1 + 0), (1 + 1), (1 + 2) } = { 0, 1, 2, 3 }$
]

#definition[Subset][
  Given two sets $A$ and $B$, $A$ is said to be a subset of $B$ if the following condition holds.

  #align(center)[
    If #text(purple)[#underline[$x$ is an element of $A$]], then #text(olive)[#underline[$x$ is an element of $B$]].
  ]
] <def:subset>

#definition[Extensionality][
  Two sets $A$ and $B$ are said to be equal if and only if $A$ is a subset of $B$ and $B$ is a subset of $A$. This is called the _axiom of extensionality_. If two sets $A$ and $B$ are equal, we write $A = B$.
] <def:set-ext>

#section(level: lv-easy)[
  #mcq(
    [
      Which of the following is distinct from the others?

      Let $A$ and $B$ be two sets. Let $A(x)$ mean $x$ is an element of $A$, and $B(x)$ mean $x$ is an element of $B$.

      Which of the following is equivalent to saying that $A subset B$?
    ],
    cols: 3,
    (
      $B(x) -> A(x)$,
      $"not" A(x) -> B(x)$,
      $"not" A(x) -> "not" B(x)$,
      $A(x) -> "not" B(x)$,
      $"not" B(x) -> "not" A(x)$,
    ),
    4,
    explanation: [
      A _contrapositive_ of a conditional $#text(purple)[p] -> #text(olive)[q]$ is the conditional $#text(red)[not] #text(olive)[q] -> #text(red)[not] #text(purple)[p]$. A contrapositive is _equivalent_ to the original conditional. i.e., it is true if and only if the original conditional is true.

      By @def:subset, $A subset B$ means $A(x) -> B(x)$ for any $x$. From the above choices, the only _equivalent_ choice is $"not" B(x) -> "not" A(x)$, which is a contrapositive of the original conditional.

      Therefore, the fifth choice is the correct answer.
    ],
  )
]

#section(level: lv-easy)[
  #[]<q:x2-sub-x4>

  #question[
    Let $Psi_2$ denote the set of all complex solutions to the equation $x^2 = 1$ and let $Psi_4$ denote the set of all complex solutions to the equation $x^4 = 1$.

    Show that $Psi_2 subset Psi_4$.
  ][
    #proof[
      Let's verify that by manually listing elements of $Psi_2$ and $Psi_4$.

      There are two complex solutions to $x^2 = 1$: $1$ and $-1$.

      Meanwhile, there are four complex solutions to $x^4 = 1$: $1$, $-1$, $i$, and $-i$.

      From here, clearly $Psi_2 subset Psi_4$.
    ]

    Now, let's consider squaring each element of $Psi_2$. By the definition, $1^2 = 1$ and $(-1)^2 = 1$. Again, let's square them once more. $(1^2)^2 = 1^2 = 1$, and similarly $((-1)^2)^2 = 1^2 = 1$. Can you find a pattern?
  ]
]

#section(level: lv-easy)[
  #question[
    Prove or disprove that $ZZ subset n ZZ + m ZZ$ for any two distinct positive integers $n$ and $m$.

    #hint[
      Provide concrete $n$ and $m$ that make up a counterexample. Try justifying your answer using the definition of set builder notation.
    ]
  ][
    #falsestmt

    #proof[
      Consider $n = 10$ and $m = 8$. Take any odd integer, say, $7$. For $7$ to be an element of $10 ZZ + 8 ZZ$, there should be $x$, a multiple of $10$, and $y$, a multiple of $8$, such that $x + y = 7$. Note that every multiple of $10$ or $8$ is even. As there are no even numbers that become odd when summed, there are no such $x$ and $y$. Hence, $7 in.not 10 ZZ + 8 ZZ$.

      As there exists an element $a = 7$ that is an element of $ZZ$ but not an element of $10 ZZ + 8 ZZ$, the condition $a in ZZ -> a in 10 ZZ + 8 ZZ$ is false. Thus, $ZZ subset.not 8 ZZ + 10 ZZ$. As there is a counterexample in a case where $n = 10$ and $m = 8$, the statement is false.
    ]
  ]
]

#section(level: lv-hard)[
  #question[
    Prove or disprove that $2 ZZ + 3 ZZ = ZZ$.

    #hint[
      cf. lecture note.
    ]
  ][
    #truestmt

    #proof[
      By @def:set-ext, we need to show that both $2 ZZ + 3 ZZ subset ZZ$ and $ZZ subset 2 ZZ + 3 ZZ$ hold.

      *$2 ZZ + 3 ZZ subset ZZ$.* Recall that $2 ZZ + 3 ZZ$ is a set given by ${ 2 x + 3 y | x in ZZ, y in ZZ }$. If $n$ is an element of $2 ZZ + 3 ZZ$, then there exist integers $x$ and $y$ such that $n = 2 x + 3 y$. From here, we conclude that $n$ is an integer, as $2 x$ and $3 y$ are integers and their sum is also an integer. (cf. PCSA Q2)

      *$ZZ subset 2 ZZ + 3 ZZ$.* Let $n$ be an integer. First, let's try to find two integers $x$ and $y$ such that $1 = 2 x + 3 y$. For instance, there are $x = 2$ and $y = -1$ such that $1 = 2 (2) + 3 (-1)$. Now, we multiply both sides by $n$ to get $n = n (2 x + 3 y) = 2 x n + 3 y n = 2 (x n) + 3 (y n)$. As $n$ is a sum of a multiple of 2 and a multiple of 3, it is an element of $2 ZZ + 3 ZZ$.

      By extensionality, we conclude that $2 ZZ + 3 ZZ = ZZ$.
    ]

    In fact, any two coprime integers $n$ and $m$ have the same property. i.e., $n perp m -> n ZZ + m ZZ = ZZ$ for integers $n$, $m$. Moreover, not only $ZZ$ but all principal ideal domains have the same property.
  ]
]

#section(level: lv-hard)[
  #question[
    For a positive integer $n$, let $Psi_n$ denote the set of all complex solutions to the equation $x^n = 1$.

    Show by using @def:subset that for any two positive integers $n$ and $m$, $Psi_n subset Psi_(n m)$.

    #hint[
      Of course, it is a generalization of #qref(<q:x2-sub-x4>).
    ]
  ][
    Recall the @def:subset that $Psi_n subset Psi_(n m)$ essentially means the following.

    #align(center)[
      If $x$ is a solution to $x^n = 1$, then it is also a solution to $x^(n m) = 1$.
    ]

    #proof[
      For two positive integers $n$ and $m$, assume $x$ is an element of $Psi_n$. By the definition, we have $x^n = 1$. By rasing both sides to the $m$th power, we get $(x^n)^m = x^(n m) = 1^m = 1$. From here, we conclude that $x$ is a solution to the equation $x^(n m) = 1$, thus $x in Psi_(n m)$.

      Therefore, $Psi_n$ is a subset of $Psi_(n m)$.
    ]
  ]
]

#section(level: lv-hard)[
  #question[
    Show by @def:set-ext that $ZZ_n + ZZ_n = ZZ_(2n - 1)$ for any positive integer $n$.

    #hint[
      cf. PCSA Q4.
    ]
  ][
    Or, see the solution of PCSA Q4.

    #proof[

      *($ZZ_n + ZZ_n subset ZZ_(2 n - 1)$).* Let $a, b in ZZ_n$. Then $0 <= a, b <= n - 1$, so $0 <= a + b <= 2 n - 2$, hence $a + b in ZZ_(2 n - 1)$.

      *($ZZ_(2 n - 1) subset ZZ_n + ZZ_n$).* Let $k in ZZ_(2 n - 1)$, so $0 <= k <= 2 n - 2$. If $k <= n - 1$, write $k = k + 0$ with $k, 0 in ZZ_n$. Otherwise $n <= k <= 2 n - 2$, and $k = (n - 1) + (k - n + 1)$ with both summands in ${ 0, 1, ..., n - 1 } = ZZ_n$.

      By the @def:set-ext, $ZZ_n + ZZ_n = ZZ_(2 n - 1)$.
    ]
  ]
]

#section(level: lv-hard)[
  #question[
    Prove or disprove that if $ZZ = n ZZ$ for an integer $n$, then either $n = 1$ or $n = -1$.

    #hint[
      What are the factors of $1$ and $-1$?
    ]
  ][
    #truestmt

    #proof[
      With the @def:set-ext in mind, the assumption says that $ZZ subset n ZZ$ and $n ZZ subset ZZ$ for some integer $n$. As the latter is pretty obvious, we will focus on the former.

      Recall the definition that $n ZZ$ is the set of all multiples of $n$. And by @def:subset
    ]
  ]
]

#definition[Symmetric difference][
  $A triangle B$ is a binary set operation given by $(A without B) union (B without A)$ and is called a _symmetric difference_ between $A$ and $B$.
]

#section(level: lv-levi)[
  #problem-by(escentia07)

  #question[
    Prove or disprove that $A triangle B subset C$ if and only if $A inter B subset (A inter B) union C$.
  ][
    #truestmt

    #proof[
      *Forward.* Let $x$ be an arbitrary element such that $x in A union B$. We consider two mutually exclusive cases:

      + *Case 1 ($x in A inter B$)* \
        If $x$ is in the intersection, it trivially follows that $x in (A inter B) union C$.

      + *Case 2 ($x in.not A inter B$)* \
        Since $x in A union B$ but $x in.not A inter B$, by the definition of symmetric difference, $x in A triangle B$. By our assumption ($A triangle B subset C$), this implies $x in C$. Therefore, $x in (A inter B) union C$.

      Since $x in (A inter B) union C$ holds true in both cases, we conclude:

      $ A union B subset (A inter B) union C $

      *Backward.* Let $x$ be an arbitrary element such that $x in A triangle B$. By definition of the symmetric difference:

      $ x in A union B quad "and" quad x in.not A inter B $

      By our assumption ($A union B subset (A inter B) union C$), since $x in A union B$, it must hold that:

      $ x in (A inter B) union C $

      This statement means that $x in A inter B$ or $x in C$. However, we already established that $x in.not A inter B$. Therefore, it must be true that $x in C$.

      Consequently, we conclude:

      $ A triangle B subset C $
    ]
  ]
]

#section(level: lv-levi)[
  For an integer $n$, let $M(k)$ denote the set ${ x | x equiv k thick (mod n) }$. Let $P$ the set given by $P = { M(k) | k in ZZ }$.

  + #question[
      Show that every two distinct elements of $P$ are disjoint.

      #hint[
        Use @def:set-ext and contraposition.
      ]
    ][
      #proof[
        Let us rephrase the statement first. The original statement is $M(a) != M(b) -> M(a) inter M(b) = nothing$ for all $a, b in ZZ$. Its contrapositive is $M(a) inter M(b) != nothing -> M(a) = M(b)$ for all $a, b in ZZ$.

        Assume $M(a) inter M(b) != nothing$ for some $a, b in ZZ$. As it is not empty, there exists at least one element $c$ in $M(a) inter M(b)$. By the definition, $c equiv a thick (mod n)$ and $c equiv b thick (mod n)$.

        If $x$ is an element of $M(a)$, then $x equiv a equiv c equiv b thick (mod n)$ by the symmetry and transitivity of the congruence. Hence, $x$ is an element of $M(b)$. Similarly, if $x$ is an element of $M(b)$, then $x equiv b equiv c equiv a thick (mod n)$, showing that $M(a) = M(b)$ as desired.
      ]

      If you're up for a challenge, try showing the symmetry and transitivity of the congruence used here.
    ]

  + #question[
      Show that the following holds for any two integers $a$ and $b$ by @def:set-ext.

      $ M(a) + M(b) = M(a + b) $
    ][

    ]
]

#section(level: lv-levi)[
  #problem-by(escentia07)

  #question[
    Let $f(x) = x^2121 + x - 1$

    How many real solutions does the equation $f^2026 (x) = x$ have? Justify your answer.

    #v(12pt)

    Answer: #blank(50pt, "", answer: $1$)
  ][
    As we are to find real solutions, we can think $f$ as a real function. Then, observe that $f$ is strictly increasing, as $x < y$ implies $f(x) < f(y)$.

    Now, let $S$ denote the set of all real solutions to the equation $f(x) = x$ and $S_2026$ denote the set of all real solutions to the equation $f^2026 (x) = x$. We will show that $S = S_2026$ by the @def:set-ext.

    #proof[

      *$S subset S_2026$.* Let $x$ be an element of $S$. As $f(x) = x$, we have $f^2026 (x) = x$, inductively, showing that $x$ is an element of $S_2026$.

      *$S_2026 subset S$.* Let $x$ be an element of $S_2026$. If $x < f(x)$, then inductively $x < f^2026 (x) = x$, which is a contradiction. Similarly, if $x > f(x)$, inductively $x > f^2026 (x) = x$, which is a contradiction. Therefore, $x$ must be equal to $f(x)$, which amounts to saying that $x$ is an element of $S$.
    ]

    The only real solution to $f(x) = x$ is $1$. As $S$ is a singleton, so is $S_2026$.

    Therefore, the correct answer is $1$.
  ]
]
