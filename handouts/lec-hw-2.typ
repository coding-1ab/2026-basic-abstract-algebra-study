// #import "../exm/lib/lib.typ": *
#import "@preview/theorion:0.6.0": cosmos, emph-block, proof
#import cosmos.rainbow: lemma, note, proposition, theorem

#import "../template.typ": *

// metadata
#let author = "Abiria"
#let date = datetime(year: 2026, month: 5, day: 30)
#let title = "Lecture 2 Homeworks"
#let emp-title = upper(title)
#let course-name = "2026 Basic Abstract Algebra Study"
#let institution = "Coding Lab"
#let version = "1.0.0"

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
  The following notations are used throughout the questions below.

  - $ZZ$: The set of all integers.
  - $ZZ^+$: The set of all positive integers; i.e., $ZZ^+ = { 1, 2, 3, ... }$.
  - $ZZ_n$: The set of non-negative integers from $0$ to $n - 1$ for some positive integer $n$. For instance, $ZZ_4 = { 0, 1, 2, 3 }$.
  - $RR$: The set of all real numbers.
  - $min(x, y)$: The minimum of $x$ and $y$; i.e., the smaller of the two.
  - $cal(P)(X)$: The power set of the set $X$.
  - $mu_n$: The set of all $n$-th roots of unity.
]

#section(level: lv-easy)[
  #mcq(
    [
      Let $f, g, h : ZZ -> ZZ$ be given by
      $ f(x) = x + 3, quad g(x) = 2x, quad h(x) = x - 1. $

      What is the value of $(h compose g compose f)(1)$?
    ],
    cols: 5,
    ($3$, $5$, $7$, $8$, $9$),
    2,
    explanation: [
      Keep in mind that composition of functions is associative. Hence, $(h compose g compose f)(1)$ is the same as $(h compose (g compose f))(1)$, which can be expanded as $h(g(f(1)))$.

      From here, it is easy to evaluate it sequentially from $f$ to $g$ and then $h$.

      $
        f(1) & = 1 + 3 = 4 \
        g(4) & = 2 dot 4 = 8 \
        h(8) & = 8 - 1 = 7
      $

      Therefore, the third choice is the correct answer.
    ],
  )
]

#section(level: lv-easy)[
  #mcq(
    [
      Let $S_5$ be the set of all bijections from $ZZ_5$ to $ZZ_5$.

      What is the value of $|S_5|$?
    ],
    cols: 5,
    ($5$, $25$, $120$, $125$, $625$),
    2,
    explanation: [
      As covered in the lecture, the number of bijections from a finite set of size $n$ to another set of size $n$ is given as $n!$.

      A quick calculation shows that $|S_5| = 5! = 2 dot 3 dot 4 dot 5 = 120$.

      Therefore, the third choice is the correct answer.
    ],
  )
]

#definition[Injection][
  A function $f : X -> Y$ is said to be _injective_, or called an _injection_, if for every $x, y in X$ with $x != y$, we have $f(x) != f(y)$.
]

#section(level: lv-easy)[
  #mcq(
    [
      Classify each of the following functions as injective or NOT injective. Which one differs from the rest?
    ],
    cols: 2,
    (
      $f_1 : RR -> RR, f_1(x) = min(x, 2x)$,
      $f_2 : RR -> RR, f_2(x) = 0 dot x$,
      $f_3 : ZZ -> ZZ, f_3(x) = gcd(x, 10)$,
      $f_4 : RR -> RR, f_4(x) = x^2 + 5 x + 6$,
      $f_5 : ZZ -> ZZ, f_5(x) = |x|!$,
    ),
    0,
    explanation: [
      + Note that $min(x, 2x) = x$ for $x >= 0$ and $min(x, 2x) = 2x$ for $x <= 0$, so $f_1$ is built from two strictly increasing lines that agree at $x = 0$. Hence $f_1$ is strictly increasing on all of $RR$, and a strictly increasing function never takes the same value twice. Thus, $f_1$ is injective.
      + There exist two distinct real numbers $1$ and $2$ such that $0 dot 1 = 0 dot 2 = 0$. Thus, $f_2$ is not injective.
      + There exist two distinct integers $4$ and $8$ such that $gcd(4, 10) = gcd(8, 10) = 2$. Thus, $f_3$ is not injective.
      + Observe that the polynomial can be factored into $(x + 2)(x + 3)$. From here, it is clear that there are two distinct real numbers $-2$ and $-3$ such that $f_4(-2) = f_4(-3) = 0$. Thus, $f_4$ is not injective.
      + There exist two distinct integers $0$ and $1$ such that $|0|! = |1|! = 1$. Thus, $f_5$ is not injective.

      Therefore, the first choice is the correct answer.
    ],
  )
]

#definition[Equality of functions][
  Two functions with the same domain and same codomain are said to be _equal_ if and only if they map every element of the domain to the same element of the codomain.

  In other words, if $f, g : X -> Y$ are functions with the same domain and codomain, then $f = g$ if and only if $f(x) = g(x)$ for every $x in X$.
]

#section(level: lv-easy)[
  #mcq(
    [
      Given that every function below has $ZZ^+$ as both its domain and codomain, which one differs from the rest?
    ],
    cols: 2,
    (
      $f_1(x) = gcd(x, x^2) + gcd(x, x^3)$,
      $f_2(x) = lcm(2x, 3x) - lcm(x, 3x)$,
      $f_3(x) = attach(C, bl: x + 1, br: x) + x - 1$,
      $f_4(x) = gcd(2x, 6x)$,
      $f_5(x) = |3x| - |x|$,
    ),
    1,
    explanation: [
      + Observe that $x^2$ has all the factors of $x$, hence $gcd(x, x^2)$ is always the same as $x$. As the same goes for $x^3$ as well, $f_1(x)$ is the same as $2 x$.
      + As $2$ and $3$ are coprime, $lcm(2x, 3x)$ is always the same as $6x$. Also, $lcm(x, 3x) = 3x$ as $3x$ is a multiple of $x$. Thus, $f_2(x)$ is the same as $3 x$.
      + As $attach(C, bl: x + 1, br: x) = (x + 1)! slash x! 1! = x + 1$, $f_3(x)$ is the same as $2 x$.
      + Observe that $6 x$ is a multiple of $2 x$, hence $gcd(2x, 6x)$ is always the same as $2 x$.
      + For a positive integer $x$, $|x|$ is the same as $x$, from which we get $f_5(x) = 2 x$.

      Therefore, the second choice is the correct answer.
    ],
  )
]

#definition[Idempotent function][
  A function $f$ from a set $X$ to itself is called _idempotent_ when $f compose f = f$.
]

#section(level: lv-easy)[
  #mcq(
    [
      Which of the following functions is NOT idempotent?
    ],
    cols: 2,
    (
      $f_1 : ZZ -> ZZ, f_1(x) = x mod 5$,
      $f_2 : RR -> RR, f_2(x) = min(sqrt(2), x)$,
      $f_3 : mu_64 -> mu_64, f_3(x) = x^8$,
      $f_4 : RR -> RR, f_4(x) = |2x| - |x|$,
      $f_5 : cal(P)(RR) -> cal(P)(RR), f_5(x) = x union ZZ$,
    ),
    2,
    explanation: [
      + The value $f_1(x) = x mod 5$ lies in ${0, 1, 2, 3, 4}$, and each of these is its own remainder modulo $5$. So applying $f_1$ again changes nothing: $f_1(f_1(x)) = f_1(x)$. Thus, $f_1$ is idempotent.
      + Since $f_2(x) = min(sqrt(2), x) <= sqrt(2)$, we have $f_2(f_2(x)) = min(sqrt(2), f_2(x)) = f_2(x)$. Thus, $f_2$ is idempotent.
      + Take a root of unity $zeta = e^(2 pi i slash 64)$. Then $f_3(zeta) = zeta^8 = e^(2 pi i slash 8)$, while $f_3(f_3(zeta)) = zeta^64 = 1$. These differ, so $f_3$ is not idempotent.
      + Since $|2x| = 2|x|$, we have $f_4(x) = 2|x| - |x| = |x|$. As $|x| >= 0$, applying $f_4$ again gives $f_4(f_4(x)) = |thin|x|thin| = |x|$. Thus, $f_4$ is idempotent.
      + For a subset $x$ of $RR$, $f_5(x) = x union ZZ$. Then $f_5(f_5(x)) = (x union ZZ) union ZZ = x union ZZ = f_5(x)$, since $ZZ union ZZ = ZZ$. Thus, $f_5$ is idempotent.

      Therefore, the third choice is the correct answer.
    ],
  )
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

#context {
  // Derive the question count from the live section counter so the sheet never
  // drifts when questions are added or removed.
  let total-questions = section-counter.final().first()
  let rows = calc.ceil(total-questions / 2)

  align(center, table(
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
}

#emph-block[
  There are also a few additional questions; feel free to answer them.

  + Which was the hardest for you, among those you have solved? #h(4pt) #blank(50pt, "")

  + Which seemed to be the hardest for you, among those you haven't solved? #h(4pt) #blank(50pt, "")

  + Which was your favorite question, if you had to choose one? #h(4pt) #blank(50pt, "")
]
