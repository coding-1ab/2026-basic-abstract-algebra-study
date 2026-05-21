// #import "../exm/lib/lib.typ": *
#import "@preview/theorion:0.6.0": cosmos, emph-block, proof
#import cosmos.rainbow: lemma, note, proposition, theorem

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

#emph-block[
  *Read this carefully before moving on.*

  Please, clearly specify whether the statement in question is _true_ or _false_, for the _prove or disprove_ type of questions. As always, it is highly encouraged for you to write each step clearly with full sentences.

  As a demonstration of a proof answer, consider the following example.

  #block(
    stroke: (thickness: 0.5pt, dash: "dashed"),
    inset: (top: 8.5pt, bottom: 8.5pt, left: 7.5pt, right: 7.5pt),
  )[
    The above statement is *true*.

    #proof[ ... ]
  ]

  As a demonstration of a disproof answer, consider the following example.

  #block(
    stroke: (thickness: 0.5pt, dash: "dashed"),
    inset: (top: 8.5pt, bottom: 8.5pt, left: 7.5pt, right: 7.5pt),
  )[
    The above statement is *false*.

    #proof[ ... ]
  ]

]

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

#definition[Roots of unity][
  Let $mu_n$ denote the set of all complex solutions to an equation of form $x^n = 1$ for a positive integer $n$. Elements of such a set are called _$n$-th roots of unity_.

  For instance, $mu_2 = { 1, -1 }$.
] <def:root-of-unity>

#section(level: lv-easy)[
  #[]<q:x2-sub-x4>

  #question[
    Show that $mu_2 subset mu_4$.
  ][
    #proof[
      Let's verify that by manually listing elements of $mu_2$ and $mu_4$.

      There are two complex solutions to $x^2 = 1$: $1$ and $-1$.

      Meanwhile, there are four complex solutions to $x^4 = 1$: $1$, $-1$, $i$, and $-i$.

      From here, clearly $mu_2 subset mu_4$.
    ]

    Now, let's consider squaring each element of $mu_2$. By the definition, $1^2 = 1$ and $(-1)^2 = 1$. Again, let's square them once more. $(1^2)^2 = 1^2 = 1$, and similarly $((-1)^2)^2 = 1^2 = 1$. Can you find a pattern?
  ]
]

#section(level: lv-easy)[
  #question[
    Prove or disprove that $ZZ subset n ZZ + m ZZ$ for any two distinct positive integers $n$ and $m$.

    #hint[
      Provide concrete $n$ and $m$ that make up a counterexample. Try justifying your answer by using the definition of set builder notation.
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
    Show by the @def:subset that for any two positive integers $n$ and $m$, $mu_n subset mu_(n m)$.

    #hint[
      Of course, it is a generalization of #qref(<q:x2-sub-x4>).
    ]
  ][
    Recall the @def:subset that $mu_n subset mu_(n m)$ essentially means the following.

    #align(center)[
      If $x$ is a solution to $x^n = 1$, then it is also a solution to $x^(n m) = 1$.
    ]

    #proof[
      For two positive integers $n$ and $m$, assume $x$ is an element of $mu_n$. By the definition, we have $x^n = 1$. By raising both sides to the $m$th power, we get $(x^n)^m = x^(n m) = 1^m = 1$. From here, we conclude that $x$ is a solution to the equation $x^(n m) = 1$, thus $x in mu_(n m)$.

      Therefore, $mu_n$ is a subset of $mu_(n m)$.
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

      Recall the definition that $n ZZ$ is the set of all multiples of $n$. And by the @def:subset, every integer $x$ should be a multiple of $n$. If $x = 1$, then $1$ should be a multiple of $n$ as well. As the only integer factors of $1$ are $1$ and $-1$, $n$ must be either $1$ or $-1$.
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

      Since $x in (A inter B) union C$ holds true in both cases, we conclude that  $A union B subset (A inter B) union C$.

      *Backward.* Let $x$ be an arbitrary element such that $x in A triangle B$. By definition of the symmetric difference:

      $ x in A union B quad "and" quad x in.not A inter B $

      By our assumption ($A union B subset (A inter B) union C$), since $x in A union B$, it must hold that:

      $ x in (A inter B) union C $

      This statement means that $x in A inter B$ or $x in C$. However, we already established that $x in.not A inter B$. Therefore, it must be true that $x in C$. Consequently, we conclude that $A triangle B subset C$.
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

      The real name of $M(k)$ is _coset_. You just proved that they create a complete _partition_ on $ZZ$!
    ]

  + #question[
      Show that the following holds for any two integers $a$ and $b$ by @def:set-ext.

      $ M(a) + M(b) = M(a + b) $
    ][
      #proof[
        Let $a$ and $b$ be integers.

        *Forward.* If $x$ is an element of $M(a) + M(b)$, there exist two integers $y$, $z$ such that $y equiv a thick (mod n)$ and $z equiv b thick (mod n)$ and $x = y + z$. As $x - a - b = (y - a) + (z - b)$ is a multiple of $n$, $x in M(a + b)$.

        *Backward.* If $x$ is an element of $M(a + b)$, then $x = k + a + b$ where $k$ is a multiple of $n$. Then, there exist two integers $k + a$, $b$ such that $k + a equiv a thick (mod n)$ and $b equiv b thick (mod n)$ and $x = (k + a) + b$.

        By extensionality, we conclude that $M(a) + M(b) = M(a + b)$.
      ]

      In such a case, we often say that _the operation is well-defined on cosets_. A subgroup that has such a property, such as $n ZZ$, is called _normal_. Moreover, we can now view $M$ as a special kind of function, called a _canonical homomorphism to the quotient_.
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

#section(level: lv-levi)[
  #question(ansbox: false)[
    Let $T$ be the set ${ z in CC | |z| = 1 }$ and $mu_oo$ be the set of all roots of unity as follows.

    $ mu_oo = union.big^oo_(n = 1) mu_n = mu_1 union mu_2 union ... $

    Prove or disprove that $T = mu_oo$.
  ][]

  #long-answer[
    #falsestmt

    #image("../assets/fishing.png", width: 4cm)

    If you have learned a set theory, you might have immediately realized that $T$ is uncountable while $mu_oo$ is countable.

    Here goes the proof!

    #proof[
      Let's first ensure that $mu_oo$ is countable. We know that each $mu_n$ is finite as $|mu_n| = n$ and not empty as they always include $1$, making $mu_oo$ not empty. Now take any function $f : ZZ^+ times ZZ^+ -> mu_oo$ such that if $m <= n$, then $f(n, m)$ is the $m$-th element of $mu_n$ when ordered by arguments. As such $f$ always exists and is clearly surjective, we have $|cal(A)| <= |ZZ^+ times ZZ^+| = aleph_0$. Hence, $mu_oo$ is countable. On the other hand, $T$ is uncountable as the argument $arg : T -> [0, 2 pi)$ is bijective, and $[0, 2 pi)$ is uncountable. As the one is countable yet the other is uncountable, they cannot be equal.
    ]

    Note that the above proof is perfectly valid even though it doesn't provide any counterexample. Nevertheless, I provide the below 'counterexample-based' disproof as well.

    #proof[
      Let $x = 4/5 + 3/5 i$. It is clear that $|x| = 1$ hence $x in T$. You may have already realized that this counterexample is from Pythagorean numbers.

      If $x$ is an element of $mu_oo$, there must exist a positive integer $n$ such that $x^n = 1$, otherwise put, $(4 + 3 i)^n = 5^n$. Now, let $(4 + 3 i)^k = A_k + B_k i$ for some $k in ZZ^+$ and find the next power.

      $ (4 + 3 i)^(k + 1) = (A_k + B_k i) (4 + 3 i) = (4 A_k - 3 B_k) + (3 A_k + 4 B_k) i $

      Thus, $A_(k + 1) = 4 A_k - 3 B_k$ and $B_(k + 1) = 3 A_k + 4 B_k$. As $A_1 = 4$ and $B_1 = 3$, we can ensure that every $A_k$, $B_k$ are integers by induction. From here, it is not hard to show that $A_k equiv 3 B_k thick (mod 5)$ and $B_(k + 1) equiv 3 B_k thick (mod 5)$. As $B_1 = 3$, we can conclude that every $B_k$ is essentially congruent to a power of $3$, namely $B_k equiv 3^k thick (mod 5)$.

      Since $(4 + 3 i)^n = 5^n$ is not an imaginary number, the imaginary part, $B_n$ must be $0$ when $k = n$. However, the congruence equation $3^n equiv 0 thick (mod 5)$ does not have a solution, as $3 perp 5$. Thus, such positive integer $n$ does not exist, contradicting with the assumption. Therefore, $x$ cannot be an $n$-th root of unity for any positive integer $n$.
    ]

    Keep in mind that multiplication of a complex number is a _rotation_ on the complex plane. Thus, what we've just shown here is that the angle (_argument_) of $x$ does not divide the circle evenly. Observe, or at least, feel how the problem of evenly dividing a circle turns into a problem of solving a solution to a modular congruence. The roots of unity can be visualized as an exact rotations of a circle, justifying why they are called _cyclic groups_.

    Of course, there's a shortcut to the above result. @thm:niven guarantees that every $arctan$ of rational number that isn't $0$, $1$, or $1/2$ to be always irrational multiple of $pi$. In the above case, $arctan(3/4)$ should be an irrational multiple of $pi$, which makes it never reaches to $1$ no matter how many times it rotates.

    #theorem[Niven][
      If $theta in [0, pi / 2]$ and both $theta / pi$ and $sin theta$ are rational, then $sin theta$ is either $0$, $1$, or $1/2$.
    ] <thm:niven>

    There is also a way more 'algebraic' proof as well.

    #proof[
      Let $x = 4/5 + 3/5 i$ and claim it's an $n$-th root of unity for some $n in ZZ^+$. Hence we get $(4 + 3 i)^n = 5^n$. As $5$ can be factored into Gaussian integers $(2 + i)(2 - i)$ and so on, we have the following prime factorization.

      $ i^n (2 - i)^(2 n) = (2 + i)^n (2 - i)^n $

      From here, the right hand side has $(2 + i)$ as a prime $n$ times, while the left hand side doesn't have it at all. As $n != 0$ by the @def:root-of-unity, this is a contradiction, as prime factorization by Gaussian integers should be unique. Therefore, $x$ is not an $n$-th root of unity for any positive integer $n$.
    ]

    From here, we have two different sets $T$ and $mu_oo$. However, as you might have already guessed, $mu_oo$ is a subset of $T$. If $x$ is a solution to $x^n = 1$ for some positive integer $n$, we have $|x^n| = |1|$ by taking absoluates on each side, from which we get $|x^n| = |x|^n = 1$. The only real solution to it is $|x| = 1$.

    In fact, $mu_oo$ forms a _subgroup_ of $T$ under multiplication. Moreover, every $mu_n$ is itself a subgroups of $mu_oo$ and called _cyclic_ as every element of $mu_n$ can be written as an exponentiation of _a primitive $n$-th root of identity_. Finally, $T$, as you might have imagined, is called the _circle group_, and is also a subgroup of a much larger group $U(CC)$, called the _unit group of the complex ring_.

    $ mu_n <= mu_oo <= T <= U(CC) $
  ]
]

End.

You may now submit your work.

#pagebreak()

= Optional evaluation sheet

#v(8pt)

#emph-block[
  Unlike PCSA, submitting the sheet is *optional* for homeworks.

  For each question so far, you can evaluate it based on the following criteria:

  - If you failed to understand the question, mark #sym.crossmark in the Evaluation column.
  - If you understood the question, but didn't know how to solve it, mark #sym.quest in the Evaluation column.
  - If you understood the question and are sure you have solved it, mark #sym.circle in the Evaluation column.
]

#let total-questions = 11
#let rows = calc.ceil(total-questions / 2)

#align(center, table(
  columns: (auto, auto, auto, auto),
  stroke: 0.5pt,
  table.header([*No.*], [*Evaluation*], [*No.*], [*Evaluation*]),
  ..range(1, rows + 1)
    .map(n => (
      [Q#n],
      [],
      if n + rows <= total-questions { [Q#(n + rows)] } else { [] },
      [],
    ))
    .flatten(),
))

#emph-block[
  There are these additional questions as well; feel free to answer them.

  + Which was the hardest for you, among those you have solved? #h(4pt) #blank(50pt, "")

  + Which seemed to be the hardest for you, among those you haven't solved? #h(4pt) #blank(50pt, "")

  + Which was your favorite question, if you had to choose one? #h(4pt) #blank(50pt, "")
]
