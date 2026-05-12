#import "../exm/lib/lib.typ": *
#import "../exm/lib/lib.typ": mcq as exm-mcq, section as exm-section
#import "@preview/theorion:0.6.0": *
#import cosmos.rainbow: *
#import cosmos.simple: render-fn
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

// vars

#let show-answers = sys.inputs.at("answers", default: "false") == "true"

#docmode.update(if show-answers { "sol" } else { "screen" })

// colors
#let cl-orange = rgb("#fe580f")
#let cl-grapefruit = rgb("#fe4036")
#let cl-magenta = rgb("#fe2562")

#let primary-color = cl-grapefruit.darken(5%)
#let text-color = rgb("#3f3f46")
#let solution-color = rgb("#0074d9")

// etc
#let image_box_max_width = 120pt
#let image_box_max_height = 50pt
#let title-font = "Roboto"

// metadata
#let author = "Abiria"
#let date = datetime(year: 2026, month: 5, day: 11)
#let title = "Pre-course Self Assessment"
#let emp-title = upper(title)
#let course-name = "2026 Basic Abstract Algebra Study"
#let institution = "Coding Lab"
#let version = "1.0.3"

// theorion

#show: show-theorion

// Make every theorion frame share `theorem-counter` (the default counter behind
// definition, note, lemma, proposition, …) and count linearly across sections
// instead of inheriting two heading levels.
#set-inherited-levels(0)

#let (_, inline-note-box, inline-note, show-inline-note) = make-frame(
  "inline-note",
  "Note",
  counter: theorem-counter,
  render: render-fn,
)

#show: show-inline-note

#let (_, hint-box, hint, show-hint) = make-frame("hint", "Hint", counter: theorem-counter, render: render-fn)

#show: show-hint

#let definition = definition.with(fill: primary-color)

// exm

#let section(..args) = {
  set enum(numbering: (..nums) => text(fill: primary-color, weight: "bold")[#numbering("(a)", ..nums)])

  context {
    let n = section-counter.get().at(0) + 1
    heading(level: 2, outlined: true, bookmarked: true, numbering: none, supplement: [qbookmark])[Q#n]
  }

  exm-section(number: true, display: "Q1. ", color: primary-color, "", ..args)

  v(20pt)
}

#show heading.where(supplement: [qbookmark]): it => place(hide(it.body))

#let qref(lbl) = {
  // use `link` to make it clickable
  link(lbl)[
    // use `context` to look up the counter's value at the specific label
    *Q#context section-counter.at(lbl).first()*
  ]
}

#let question = question.with(ansbox: show-answers, color: solution-color, color-text: text-color)

#let long-answer(body) = {
  if show-answers {
    block(
      width: 100%,
      breakable: true, // make the #long-answer breakable
      stroke: 0.5pt + solution-color,
      inset: (top: 8.5pt, bottom: 8.5pt, left: 7.5pt, right: 7.5pt),
      body,
    )
  }
}

#let mcq(
  question,
  choices,
  ..args,
) = {
  // We take the choices array, loop over it, and add the A., B., C. labels
  let numbered-choices = choices
    .enumerate()
    .map(pair => {
      let (index, choice-text) = pair
      let label = numbering("1.", index + 1)

      // Combine the bold letter with the original choice text
      [ #text(primary-color)[*#label*] #choice-text ]
    })

  // We call the original mcq function.
  // 1. We pass the 'question' exactly as it was.
  // 2. We pass our new 'numbered-choices' array.
  // 3. We unpack '..args', which perfectly forwards the answer index, points,
  //    multi, cols, and any other configuration directly to the original function.
  exm-mcq(question, numbered-choices, ansbox: show-answers, color: solution-color, color-text: text-color, ..args)
}

#let blank = blank.with(color: solution-color)

// custom macros

#let truestmt = [The statement is #text(colorgreen)[#sym.checkmark *true*].]
#let falsestmt = [The statement is #text(colorred)[#sym.crossmark *false*].]

// set

// math tweaks

#set math.mat(delim: "[")

// doc

#set document(author: author, title: title, date: date)

// etc

// underline links
#show link: this => { underline(this) }

// font size
#set text(size: 11pt)

// enum styles, https://forum.typst.app/t/how-can-i-format-an-enums-numbering-without-overriding-the-numbering-style/3246
#set enum(
  full: true,
  numbering: (..nums, last) => {
    text(
      weight: "bold",
      numbering(("(a)", "i.").at(nums.pos().len(), default: "1."), last),
    )
  },
)

#set table(
  stroke: (x, y) => (
    left: if x == 0 { 0.5pt } else { 0pt },
    right: 0.5pt,
    top: if y <= 1 { 0.5pt } else { 0pt },
    bottom: 0.5pt,
  ),
  fill: (_, y) => if calc.even(y) { luma(245) } else { white },
  inset: (x: 10pt, y: 5pt),
)

#set page(
  // margin: (top: 1.65cm, bottom: 2.6cm, left: 1.65cm, right: 1.65cm),
  // margin: (top: 1.98cm, bottom: 3.12cm, left: 1.98cm, right: 1.98cm),

  background: context {
    let side-label-top = text(fill: luma(40%), size: 10pt)[
      #smallcaps[#course-name] #h(0.6cm) #institution
    ]

    let side-label-top-size = measure(side-label-top)
    let side-label-top-length-half = side-label-top-size.width / 2

    place(
      right + top,
      dx: -0.7cm + side-label-top-length-half,
      dy: 0.5cm + side-label-top-length-half,
      rotate(-90deg, side-label-top),
    )

    let side-label-bottom = [
      #context [
        #text(fill: primary-color)[*#counter(page).display()*] / #text(fill: luma(10%))[#counter(page).final().first()]
      ] #h(0.2cm) #box(stroke: (bottom: 0.5pt + luma(70%)), width: 0.8cm, outset: (bottom: -0.35em)) #h(0.2cm) #text(
        fill: luma(40%),
        size: 10pt,
      )[
        #smallcaps[#title]
      ]
    ]

    let side-label-bottom-size = measure(side-label-bottom)
    let side-label-bottom-length-half = side-label-bottom-size.width / 2

    place(
      right + bottom,
      dx: -0.7cm + side-label-bottom-length-half,
      dy: -0.5cm - side-label-bottom-length-half,
      rotate(-90deg, side-label-bottom),
    )
  },
)

// cover

#page(
  // left colored bar
  background: align(left, rect(width: 30pt, height: 100%, fill: gradient.linear(
    dir: ttb,
    cl-orange,
    cl-magenta,
  ))),
  {
    // logo
    align(top + right, box(
      height: image_box_max_height,
      width: image_box_max_width,
      image("../assets/cl-gradient-logo.svg"),
    ))

    // title
    align(horizon, {
      stack(
        spacing: 3.8em,
        text(size: 20pt, fill: luma(40%), smallcaps(course-name)),
        stack(
          spacing: 2.4em,
          text(size: 36pt, weight: "bold", font: title-font, emp-title),
          text(size: 28pt, weight: "semibold", font: title-font, context {
            if show-answers {
              text(fill: solution-color)[#upper[Solutions]]
            } else {
              text(fill: primary-color)[#upper[Question paper]]
            }
          }),
        ),
      )
    })

    // desc
    align(bottom + left, {
      stack(
        spacing: 1.8em,
      )[
        *Version* \
        v#version
      ][
        *Instructor* \
        #author
      ][
        *Published on* \
        #date.display("[year]-[month]-[day]")
      ][
        *Hosted by* \
        #institution
      ]
    })
  },
)

// body

#set page(
  margin: (top: 1.98cm, bottom: 3.12cm, left: 1.98cm, right: 1.98cm),
)

#emph-block[
  *Read this carefully before moving on.*

  In the following questions, _prove or disprove_ means you need to either show a correct logical proof of a given statement or provide at least one counterexample that disproves the statement. Describe each deduction step by step, citing the relevant definition or fact at each step.

  As a tiny example of a proof answer, consider the following statement.

  #align(center)[
    For any integers $a$ and $b$, if $a$ and $b$ are both even, then so is $a + b$.
  ]

  #block(
    stroke: (thickness: 0.5pt, dash: "dashed"),
    inset: (top: 8.5pt, bottom: 8.5pt, left: 7.5pt, right: 7.5pt),
  )[
    The above statement is true.

    #proof[
      Assume $a$ and $b$ are even integers. By the definition of an even integer, there exist integers $k$ and $l$ such that $a = 2 k$ and $b = 2 l$. Then $a + b = 2 k + 2 l = 2 (k + l)$, and since $k + l$ is an integer, $a + b$ is even by the same definition.
    ]
  ]

  As a tiny example of a disproof answer, consider the following statement.

  #align(center)[
    For any integers $a$ and $b$, if $a + b$ is even, then $a$ and $b$ are both even.
  ]

  #block(
    stroke: (thickness: 0.5pt, dash: "dashed"),
    inset: (top: 8.5pt, bottom: 8.5pt, left: 7.5pt, right: 7.5pt),
  )[
    The above statement is false.

    #proof[
      Take $a = 1$ and $b = 1$. Both are odd, but $a + b = 2$ is even. Hence the statement is false.
    ]
  ]

  It is highly encouraged to write down full sentences like the above samples, rather than just throwing out a few symbols or numbers without explaining why.
]

#note[
  The following symbols will be used throughout the following questions.

  - $ZZ$: A set of all integers.
  - $ZZ^+$: A set of all positive integers. i.e., $ZZ^+ = { 1, 2, 3, ... }$.
  - $ZZ_n$: A set of non-negative integers from $0$ to $n - 1$ for some positive integer $n$. For instance, $ZZ_4 = { 0, 1, 2, 3 }$.
  - $QQ$: A set of all rational numbers.
  - $RR$: A set of all real numbers.
  - $RR^+$: A set of all positive real numbers.
  - $CC$: A set of all complex numbers.
]

#definition[Extensionality][
  Two sets $X$ and $Y$ are said to be equal if and only if $X$ is a subset of $Y$ and $Y$ is a subset of $X$. This is called the _axiom of extensionality_. If two sets $X$ and $Y$ are equal, we write $X = Y$.
] <def:set-ext>

#section[
  #inline-note[
    $A without B$ denotes the set of all elements in $A$ that are not in $B$.
  ]

  #mcq(
    [
      Which of the following is distinct from the others?
    ],
    cols: 3,
    (
      ${ -x | x in RR }$,
      ${ x x | x in RR }$,
      ${ x y | x, y in RR }$,
      ${ x x x | x in RR }$,
      ${ x / y | x in RR, y in RR without { 0 } }$,
    ),
    1,
    explanation: [
      All the above choices but the second are the same as $RR$. For convenience, we denote each set as $X_i$ for $i = 1, 2, 3, 4, 5$.

      + If $x$ is a real number, then its additive inverse, $-x$ is also a real number, thus $X_1 subset RR$. Furthermore, if $r$ is a real number, then there exists a real number $-r$ such that $- (-r) = r$, thus $RR subset X_1$. Hence $X_1 = RR$ by extensionality.
      + If $x$ is a real number, then its square $x^2$ is also a real number, thus $X_2 subset RR$. However, there exists a real number $-5$ where there is no real number $x$ such that $x^2 = -5$, so $RR subset.not X_2$. Thus, $RR != X_2$.
      + If $x$, $y$ are real numbers, then their product, $x y$ is also a real number, thus $X_3 subset RR$. Furthermore, if $r$ is a real number, then there exist real numbers $r$ and $1$ such that $r dot 1 = r$, thus $RR subset X_3$. Hence $X_3 = RR$ by extensionality.
      + If $x$ is a real number, then its cube $x^3$ is also a real number, thus $X_4 subset RR$. Furthermore, if $r$ is a real number, then there exists a real number $root(3, r)$ such that $(root(3, r))^3 = r$, thus $RR subset X_4$. Hence $X_4 = RR$ by extensionality.
      + If $x$, $y$ are real numbers where $y$ is not zero, then their quotient, $x / y$ is also a real number, thus $X_5 subset RR$. Furthermore, if $r$ is a real number, then there exist real number $r$ and nonzero real number $1$ such that $r / 1 = r$, thus $RR subset X_5$. Hence $X_5 = RR$ by extensionality.

      As $X_2$ is the distinct one, the second choice is the correct answer.
    ],
  )
]

#section[
  #inline-note[
    The sum of two integers is always an integer.
  ]

  #question[
    Show that ${ x + y | x, y in ZZ } = ZZ$ using extensionality. (@def:set-ext)

    #hint[
      First, show that ${ x + y | x, y in ZZ } subset ZZ$. Then, show that $ZZ subset { x + y | x, y in ZZ }$. In the latter case, it is enough to show that for any integer, there exist at least a pair of integers such that their sum gets equal to that integer.
    ]
  ][
    Let $ZZ + ZZ$ denote the set ${ x + y | x, y in ZZ }$. We show both inclusions and conclude by extensionality.

    #proof[
      Let $n in ZZ + ZZ$. Then $n = x + y$ for some integers $x$ and $y$. As stated above, the sum of two integers is also an integer, so $n in ZZ$. Here we get $ZZ + ZZ subset ZZ$.

      Let $n in ZZ$. Since $n$ and $0$ are integers and $n = n + 0$, we have $n in ZZ + ZZ$. This shows that $ZZ subset ZZ + ZZ$.

      We have shown that both $ZZ + ZZ subset ZZ$ and $ZZ subset ZZ + ZZ$ hold. By extensionality, we conclude that $ZZ + ZZ = ZZ$.
    ]
  ]
]

#definition[Size of finite sets][
  A _size_ of a finite set $X$ is the number of elements it contains, and denoted as $|X|$.
]

#section[
  #mcq(
    [
      Let $A$ be a set of all prime numbers that are even. What is the value of $|A|$?
    ],
    cols: 5,
    (0, 1, 2, 3, 4),
    1,
    explanation: [
      The set $A$ is the set of all even prime numbers. Since $2$ is the only even prime number, the set $A$ contains only one element. Therefore, $|A| = 1$.

      Hence, the second choice is the correct answer.
    ],
  )
]

#section[
  #question[
    Let $A = { n + m | n, m in ZZ_20261212 }$. What is the value of $|A|$?

    #hint[
      $|{ n + m | n, m in ZZ_2 }| = |{ 0 + 0, 0 + 1, 1 + 0, 1 + 1 }| = |{ 0, 1, 2 }| = 3$.
    ]

    #v(12pt)

    Answer: #blank(50pt, "", answer: $40522423$)
  ][
    For a positive integer $n$, let $ZZ_n + ZZ_n$ denote the set ${ a + b | a, b in ZZ_n }$. We show that $ZZ_n + ZZ_n = ZZ_(2 n - 1)$ for every positive integer $n$ by the extensionality (@def:set-ext), from which the answer follows directly.

    #proof[

      *($ZZ_n + ZZ_n subset ZZ_(2 n - 1)$).* Let $a, b in ZZ_n$. Then $0 <= a, b <= n - 1$, so $0 <= a + b <= 2 n - 2$, hence $a + b in ZZ_(2 n - 1)$.

      *($ZZ_(2 n - 1) subset ZZ_n + ZZ_n$).* Let $k in ZZ_(2 n - 1)$, so $0 <= k <= 2 n - 2$. If $k <= n - 1$, write $k = k + 0$ with $k, 0 in ZZ_n$. Otherwise $n <= k <= 2 n - 2$, and $k = (n - 1) + (k - n + 1)$ with both summands in ${ 0, 1, ..., n - 1 } = ZZ_n$.

      By extensionality, $ZZ_n + ZZ_n = ZZ_(2 n - 1)$.
    ]

    Setting $n = 20261212$ gives $ZZ_20261212 + ZZ_20261212 = ZZ_40522423$, whose size is $40522423$.

    Therefore, the correct answer is $40522423$.
  ]
]

#section[
  #question(ansbox: false)[
    Let $T$ be the set of all real numbers except $0$ and $1$. Define two functions $f, g : T -> T$ as $f(x) = x^(-1)$ and $g(x) = 1 - x$, respectively.

    Let $S$ be the set of all possible functions that can be created by composing $f$ and $g$ any number of times in any order, such as $f$, $g$, $g compose f$, $f compose g$, $g compose g compose f compose f$, $f compose g compose f$, $f^20261212$, etc.

    What is the value of $|S|$?

    #v(12pt)

    Answer: #blank(50pt, "", answer: $6$)
  ][]

  #long-answer[
    #proof[
      Let $1$ denote the identity function on $T$, i.e., $1(x) = x$ for all $x in T$. For convenience, we will write $g f$ to denote the composition $g compose f$.

      Keep in mind that having $x$ or $1 - x$ in the denominator is perfectly valid, as $T$ contains neither $0$ nor $1$.

      It is easily observed that $f^2 = g^2 = 1$ as $f^2(x) = (x^(-1))^(-1) = x$ and $g^2(x) = 1 - (1 - x) = x$, respectively. It directly follows that in any sequence of compositions, consecutive identical functions cancel out. Odd number of repetitions get shrunk to only one occurrence, while even number of repetitions are completely cancelled out as they are equal to the identity $1$. For instance, $g f f f g$ is the same as $g f g$, and $g f g g g g$ is the same as $g f$. This implies that any unique function in $S$ must be a strictly alternating sequence of $f$ and $g$, such as $f g f g f$.

      Next, let's evaluate the alternating sequence of length six, $g f g f g f$:

      $
        g f g f g f (x) = g f g f ( 1 - 1 / x ) = g f ( 1 / ( 1 - x ) ) = x
      $

      Since $g f g f g f (x) = x$, we establish that $g f g f g f = 1$.

      Based on this identity, we can compose both sides with $g$ or $f$ on the left, moving terms on the left to the right, once at a time. Keeping in mind that $g^2 = 1$ and $f^2 = 1$, we can find all equivalent alternating sequences as follows.

      $
        g f g f g f & = &           1 \
          f g f g f & = &           g && wide "(multiply by "g" on the left)" \
            g f g f & = &         f g && wide "(multiply by "f" on the left)" \
              f g f & = &       g f g && wide "(multiply by "g" on the left)" \
                g f & = &     f g f g && wide "(multiply by "f" on the left)" \
                  f & = &   g f g f g && wide "(multiply by "g" on the left)" \
                  1 & = & f g f g f g && wide "(multiply by "f" on the left)" \
      $

      From here, we can ensure that every possible composition of $f$ and $g$ is essentially the same as one of the values above, as any alternating pattern longer than 6 cycles back to the identity. For instance, $f g f g f g f$ is the same as $(f g f g f g) f = 1 f = f$, and so on.

      Consequently, any sequence longer than 3 can be rewritten as a shorter equivalent sequence. By keeping only the shorter side of each equation, we collect exactly six candidates.

      $ 1 wide f wide g wide g f wide f g wide f g f $

      Finally, we can explicitly evaluate the remaining compositions to confirm they are all distinct.

      $ (g f)(x) = 1 - 1 / x wide (f g)(x) = 1 / ( 1 - x ) wide (f g f)(x) = x / ( x - 1) $

      Since each expression yields a distinct rational function, there are exactly six distinct functions in the set $S$.

      Therefore, the correct answer is $6$.
    ]

    Because every possible composition of $f$ and $g$ results in a function that is already in $S$, we say that the set $S$ is _closed_ under function composition.  Moreover, we can always find a pair of functions that undo each other's action when composed together. Specifically, $1$, $f$, $g$, and $f g f$ are self-inverses, whereas $f g$ and $g f$ are inverses of each other. In fact, such a set $S$ forms a _group_ under function composition.

    One of the most famous names for this set $S$ is the _symmetric group of degree 3_, denoted as $S_3$. It represents all possible arrangements of three distinct elements. We say that $S_3$ is _generated_ by $f$ and $g$. In this context, $f$ and $g$ are called _transpositions_ because their action swaps exactly two elements while leaving the third one perfectly in place.

    This group $S$ has another famous name, the _dihedral group of degree 3_, denoted as $D_3$. This group captures all the rigid _symmetries_ of an equilateral triangle. We can visualize $f$ as a reflection (flip) of the triangle across an axis passing through the bottom-right corner and the center, while $g$ acts as a reflection across an axis passing through the bottom-left corner and the center.

    The remaining four symmetries can be generated entirely by chaining these two basic reflections. The diagram below is a _Cayley graph_ of $D_3$, mapping out the entire group. Here, applying $f$ is represented by following a red arrow, and applying $g$ is represented by a blue arrow.

    #v(8pt)

    #let tri(t, br, bl, size: 16pt) = {
      // 1. Map numbers to colors
      let color-map = (none, red, blue, yellow)
      let top-col = color-map.at(t)
      let br-col = color-map.at(br)
      let bl-col = color-map.at(bl)

      // 2. Calculate dynamic dimensions based on the input size
      let w = size
      let h = w * 0.866 // Height of an equilateral triangle

      // 3. Define the vertices and geometry dynamically
      let top-v = (w * 0.5, 0pt)
      let br-v = (w, h)
      let bl-v = (0pt, h)

      // The centroid of a triangle is exactly 2/3 of the way down from the top
      let center = (w * 0.5, h * 0.666)

      // Midpoints of the edges
      let mid-tr = (w * 0.75, h * 0.5)
      let mid-tl = (w * 0.25, h * 0.5)
      let mid-b = (w * 0.5, h)

      // 4. Draw everything inside a dynamically sized box
      box(width: w, height: h, {
        place(polygon(fill: top-col, center, mid-tr, top-v, mid-tl))
        place(polygon(fill: br-col, center, mid-b, br-v, mid-tr))
        place(polygon(fill: bl-col, center, mid-tl, bl-v, mid-b))

        place(polygon(stroke: 0.8pt + black, top-v, br-v, bl-v))

        // 5. Place the numbers so they stay safely outside the corners,
        // regardless of how big or small the triangle gets!
        place(dx: w * 0.5 - 2.5pt, dy: -10pt, text(size: 8pt, weight: "bold", str(t)))
        place(dx: w + 3pt, dy: h - 2pt, text(size: 8pt, weight: "bold", str(br)))
        place(dx: -7pt, dy: h - 2pt, text(size: 8pt, weight: "bold", str(bl)))
      })
    }

    #let i = (0, -2) // identity
    #let s = (2, 1) // rotation clockwise
    #let ss = (-2, 1) // rotation counterclockwise
    #let t1 = (0, 2) // flip by the 1st axis
    #let t2 = (2, -1) // flip by the 2nd axis (bottom right)
    #let t3 = (-2, -1) // flip by the 3rd axis (bottom left)

    #align(center)[
      #diagram(
        // debug: true,
        node-outset: 8pt,
        {
          // hexagon layout
          node(i, tri(1, 2, 3)) // 0
          node(t2, tri(3, 2, 1)) // 60
          node(s, tri(3, 1, 2)) // 120
          node(t1, tri(1, 3, 2)) // 180
          node(ss, tri(2, 3, 1)) // 240
          node(t3, tri(2, 1, 3)) // 300

          // top-to-bottom, left-to-right order
          edge(i, t2, text(red)[$f$], "<->", stroke: 1pt + red)
          edge(t3, s, text(red)[$f$], "<->", stroke: 1pt + red, label-pos: 40%)
          edge(ss, t1, text(red)[$f$], "<->", stroke: 1pt + red, label-side: right)

          // top-to-bottom, right-to-left order
          edge(i, t3, text(blue)[$g$], "<->", stroke: 1pt + blue)
          edge(t2, ss, text(blue)[$g$], "<->", stroke: 1pt + blue, label-side: left, label-pos: 60%)
          edge(s, t1, text(blue)[$g$], "<->", stroke: 1pt + blue, label-side: left)

          // extra
          edge(i, s, text(olive)[$f g$], "->", stroke: 0.6pt + olive, label-side: right, label-pos: 40%)
          edge(ss, t3, text(fuchsia)[$f g f = g f g$], "<->", stroke: 0.6pt + fuchsia, label-side: left)
        },
      )
    ]

    #v(8pt)

    To understand how this works, let's trace a path. Suppose we want to move from the starting triangle positioned at $(1, 2, 3)$ (reading top, bottom-right, bottom-left) to the triangle positioned at $(3, 1, 2)$. We can first follow the blue arrow ($g$) to $(2, 1, 3)$, and then follow the red arrow ($f$) to arrive at $(3, 1, 2)$. Because we apply $g$ first and then $f$, the resulting function composition is written right-to-left as $f g$. Geometrically, this combined motion is exactly equivalent to rotating the triangle by 120 degrees clockwise.

    Similarly, imagine navigating from the triangle at $(2, 3, 1)$ to $(2, 1, 3)$. We could trace the blue-red-blue path upward and then downward ($g$ then $f$ then $g$, forming $g f g$). Alternatively, we could trace the red-blue-red path downward and then upward ($f$ then $g$ then $f$, forming $f g f$). Both paths lead to the exact same destination, intuitively showing that $g f g = f g f$. If we look at the numbers on the triangles, this specific move swaps the bottom two corners while fixing the top, acting exactly like a reflection across the vertical axis, which makes the arrow bidirectional just like the $f$ and $g$.

    Notice that the red $f$ and blue $g$ arrows are bidirectional. This visually encodes the fact that $f$ and $g$ are self-inverses ($f^2 = 1$ and $g^2 = 1$). Because traversing an arrow back and forth simply cancels out the motion, simplifying an algebraic expression made of $f$'s and $g$'s is essentially the same puzzle as finding the shortest, non-backtracking path between two nodes on this graph.

    By simply chasing the arrows in our head, we can visually confirm why any sequence of $f$ and $g$, no matter how long, is completely trapped within these six perfectly closed states.
  ]
]

#section[
  #mcq(
    [
      Let $"Di"_6 = { die.one, die.two, die.three, die.four, die.five, die.six }$ be a set of all possible faces of a six-sided die.

      How many distinct ordered pairs can be made from $"Di"_6$?
    ],
    cols: 5,
    (36, 21, 6, 30, 12),
    0,
    explanation: [
      Keep in mind that the order matters in an ordered pair. The total number of distinct pairs out of $6$ elements is $6^2 = 36$.

      Therefore, the first choice is the correct answer.
    ],
  )
]

#definition[Product of sets][
  Let $X$, $Y$ be two sets. A _product_ $X times Y$ between them is a set of all ordered pairs $(x, y)$ where $x in X$ and $y in Y$.
]

#section[
  #mcq(
    [
      Let $X = { 10, 20, 30 }$ and $Y = { <-, -> }$. Find the same set as $Y times X$.
    ],
    (
      ${ (10, 10), (20, 20), (30, 30), (<-, <-), (->, ->) }$,
      ${ (10, <-), (10, ->), (20, <-), (20, ->), (30, <-), (30, ->) }$,
      ${ (<-, 20), (20, <-), (<-, 20), (20, <-), (30, ->), (->, 30) }$,
      ${ (10, ->), (20, ->), (30, ->), (10, <-), (20, <-), (30, <-) }$,
      ${ (<-, 20), (<-, 30), (<-, 10), (<-, 20), (->, 10), (->, 20), (->, 30) }$,
    ),
    4,
    explanation: [
      Note that the question asks for $Y times X$, not $X times Y$. The order matters in an ordered pair, so does in product.

      The canonical answer would be $Y times X = { (<-, 10), (<-, 20), (<-, 30), (->, 10), (->, 20), (->, 30) }$.

      + It is neither a subset of $Y times X$ nor a superset of it.
      + It is the same as $X times Y$, but not $Y times X$.
      + It is a subset of $Y times X$, but lacks $(<-, 10)$ and $(->, 10)$.
      + It is also the same as $X times Y$, as the second choice.
      + It is a subset of $Y times X$, as well as a superset of it.

      Therefore, the fifth choice is the correct answer.
    ],
  )
]

#definition[Power set][
  A set of all subsets of a set $X$ is called a _power set_ of $X$, and denoted as $cal(P)(X)$.
]

#section[
  #mcq(
    [Which of the following is the same as $cal(P)( { a, 1, * } )$, if $a$, $1$, and $*$ are all distinct?],
    (
      ${ { nothing, { a }, { 1 }, { * }, { a, 1 }, { 1, * }, { a, * }, { a, 1, *} } }$,
      ${ { *, 1, a }, { *, a }, { *, 1 }, { 1, a }, { * }, { a }, { 1 } }$,
      ${ nothing, { 1 }, { a }, { * }, { (a, 1) }, { (1, *) }, { (a, *) }, { (1, a, *) } }$,
      ${ { *, 1, a}, { a }, { a, 1, a }, { *, * }, { 1 }, nothing, { 1, * }, { a }, { a, *, * } }$,
      ${ nothing, { a }, { 1 }, { * }, { a, 1 }, { 1, a }, { 1, * }, { *, 1 }, { a, 1, * } }$,
    ),
    3,
    explanation: [
      The canonical answer would be $cal(P)({ a, 1, * }) = { nothing, { a }, { 1 }, { * }, { a, 1 }, { 1, * }, { a, * }, { a, 1, * } }$. Let's call this simply $P$.

      + The first choice looks similar to $P$, however, it is a singleton containing the power set, ${ P }$, which is not equal to $P$.

      + The second choice is also close, however, it lacks the empty set $nothing$. Keep in mind that every power set must contain the empty set.

      + The third choice is also wrong. Some of its elements contain ordered pairs such as ${ (a, 1) }$, rather than individual elements, such as ${ a, 1 }$. They are indeed not the same.

      + The fourth choice is the correct answer. Let's verify it step by step:
        - ${ *, 1, a }$ is the same as ${ a, 1, * }$.
        - ${ a }$ is the same as ${ a }$.
        - ${ a, 1, a }$ is the same as ${ a, 1 }$.
        - ${ *, * }$ is the same as ${ * }$.
        - ${ 1 }$ is the same as ${ 1 }$.
        - $nothing$ is the same as $nothing$.
        - ${ 1, * }$ is the same as ${ 1, * }$.
        - ${ a }$ is the same as ${ a }$. Note that this is a duplicate of the second element.
        - ${ a, *, * }$ is the same as ${ a, * }$.

        From here, it is easily verified that the fourth choice has all the elements $P$ has, as well as $P$ has all the elements that the fourth choice has.

      + The fifth choice is also close but wrong, as it lacks ${ a, * }$. Since sets do not have orders, we have ${ a, 1 } = { 1, a }$. Based on this fact, the fifth choice is the same as ${ nothing, { a }, { 1 }, { * }, { a, 1 }, { 1, * }, { a, 1, * } }$.

      Therefore, the fourth choice is the correct answer.
    ],
  )
]

#section[
  #question[
    What is the value of $|cal(P)(ZZ_2 times ZZ_5)|$?

    #v(12pt)

    Answer: #blank(50pt, "", answer: $1024$)
  ][
    The size of the product of two finite sets is the product of their individual sizes. Thus, $|ZZ_2 times ZZ_5| = |ZZ_2| dot |ZZ_5| = 2 times 5 = 10$.

    The size of the power set of a finite set $X$ is given by $2^(|X|)$. Therefore, $|cal(P)(ZZ_2 times ZZ_5)| = 2^(|ZZ_2 times ZZ_5|) = 2^10 = 1024$.

    Hence, the correct answer is $1024$.
  ]
]

#section[
  #question[
    Prove or disprove that the following holds for any two sets $A$ and $B$.

    $ (A without B) inter (B without A) = nothing $
  ][
    #truestmt

    #proof[
      Let $x$ be an element of $A without B$ and $B without A$ at the same time, which is equivalent to saying that $x in (A without B) inter (B without A)$.

      - $x in A without B$ means that $x in A$ while $x in.not B$.
      - $x in B without A$ means that $x in B$ while $x in.not A$.

      By the first condition, $x in A$ should hold, while by the second condition, $x in.not A$ should hold at the same time. There is no $x$ that satisfies both conditions, as they are negations of each other.

      As there is no element $x$ in $(A without B) inter (B without A)$, by extensionality, it is equal to the empty set.
    ]
  ]
]

#section[
  #question[
    Prove or disprove that the following holds for any set $X$.

    $ cal(P)(X) inter X = nothing $
  ][
    #falsestmt

    #proof[
      Let $X$ be ${ nothing }$. Its power set $cal(P)(X)$ is ${ nothing, { nothing } }$, and they share $nothing$ as a common element, so $cal(P)(X) inter X = { nothing } != nothing$.
    ]
  ]
]

#definition[Singleton][
  A set is called a _singleton_ if it has only one element.
]

#section[
  #question[
    Prove or disprove the following statement.

    #align(center)[
      A set is a singleton if and only if it has only one proper subset.
    ]
  ][
    #truestmt

    #proof[

      *Forward.* If $A$ is a singleton, the only possible subsets are the empty set and $A$ itself. In such a case, the only possible proper subset is the empty set.

      *Backward.* Let $A$ be a set with only one proper subset. Because the empty set doesn't have any proper subsets, $A$ cannot be empty. In other words, there exists at least one element $x in A$. Moreover, as the empty set is a proper subset of every nonempty set, the only proper subset $A$ has must be the empty set. Now, let $y$ be an element of $A$. If $x != y$, then ${ y }$ would be a proper subset of $A$ different from $nothing$, contradicting the assumption that $A$ has only one proper subset. Thus, every $y in A$ is equal to $x$, showing that such an element $x$ is unique, and $A$ is a singleton.
    ]
  ]
]

#definition[Injection, Surjection, and Bijection][
  A function $f : X -> Y$ is said to be _injective_ or called an _injection_ if for every $x, y in X$, if $x != y$ then $f(x) != f(y)$. A function is said to be _surjective_ or called a _surjection_ if for every $y in Y$, there exists an $x in X$ such that $f(x) = y$. A function is said to be _bijective_ or called a _bijection_ if it is both an injection and a surjection.
]

#section[
  #question[
    For a set $X$, think of another set $X slash #math.class("normal", sym.eq)$ that is a set of all singletons from all elements of $X$. For instance, if $X$ is ${ a, b, c }$, then $X slash #math.class("normal", sym.eq)$ becomes ${ { a }, { b }, { c } }$.

    Prove or disprove that there is a bijection between $X$ and $X slash #math.class("normal", sym.eq)$.
  ][
    #truestmt

    #proof[

      *Existence.* Consider a function $f : X -> X slash #math.class("normal", sym.eq)$ that maps each element of $X$ to its corresponding singleton in $X slash #math.class("normal", sym.eq)$, so that $f(x) = { x }$ for all $x in X$. Such a function is well-defined as every element $x$ of $X$ has a unique image ${ x }$, since there is only one singleton that contains only $x$.

      *Injectivity.* Let $x, y in X$ be arbitrary and assume $f(x) = f(y)$, which is equivalent to saying that ${ x } = { y }$. By extensionality, this means that ${ x } subset { y }$ and ${ y } subset { x }$. As there is only one element in each set, $x$ must be equal to $y$, thus $f$ is injective.

      *Surjectivity.* Let $s in X slash #math.class("normal", sym.eq)$ be arbitrary. Then $s$ is a singleton; call its only element $x$. By definition of $X slash #math.class("normal", sym.eq)$, $x$ must be an element of $X$, and $f(x) = { x } = s$, showing that $f$ is surjective.

      As $f$ is both injective and surjective, it is bijective.
    ]
  ]
]

#definition[Equality of functions][
  Two functions with the same domain and same codomain are said to be _equal_ if and only if they map every element of the domain to the same element of the codomain.

  In other words, if $f, g : X -> Y$ are functions with the same domain and codomain, then $f = g$ if and only if $f(x) = g(x)$ for every $x in X$.
]

#section[
  #question[
    Show that for any singleton, there is always a unique function from any set to it.

    #hint[
      Let ${ * }$ be a singleton and $X$ be any set, and consider a function $f : X -> { * }$. First show that such function always exists, and then prove that if there is a function $f' : X -> { * }$, then $f = f'$.
    ]
  ][
    A formal proof is provided below.

    #proof[

      *Existence.* There is a function $f : X -> { * }$ defined by $f(x) = *$ for all $x in X$. Since every element in $X$ has $*$ as the only image, $f$ is a well-defined function.

      *Uniqueness.* Let $f' : X -> { * }$ be any function. Since the codomain contains only one element that can be an image, it follows that $f'(x) = *$ regardless of the choice of $x$. Because $f(x) = * = f'(x)$ for all $x in X$, $f$ and $f'$ are equal by definition of functional equality. Thus, the function is unique.
    ]

    Of course, there is a quicker way as well. The number of functions from $X$ to $Y$ is given by $|Y|^(|X|)$. (#qref(<q:no-funs>) shows a similar result in finite cases.) It immediately follows that $1^(|X|) = 1$ if the codomain is a singleton. However, this calculation involves operations on _cardinal numbers_, as the set $X$ can possibly be infinite. As cardinals are out of the scope of this course, the provided proof didn't follow this approach.
  ]
]

#section[
  #inline-note[
    An induction here refers to the mathematical induction.
  ]

  #question[
    Let $A_i$ be a singleton for $i = 1, ..., n$ for a positive integer $n$. Show by induction that $A_1 times ... times A_n$ is also a singleton.
  ][
    For convenience, let $product^n_i A_i$ denote the product $A_1 times ... times A_n$.

    #proof[
      In the case where $n = 1$, $product^1_i A_i = A_1$ is trivially a singleton, by assumption.

      Now, assume that $product^k_i A_i$ is a singleton for some positive integer $k$, so that $abs(product^k_i A_i) = 1$. By assumption, $A_(k + 1)$ is also a singleton, so $|A_(k + 1)| = 1$.

      Since the size of a product of two finite sets is the product of their sizes, we have the following, showing that $product^(k + 1)_i A_i$ is also a singleton.

      $
        abs(product^(k + 1)_i A_i) = abs([product^k_i A_i] times A_(k + 1)) = abs(product^k_i A_i) dot abs(A_(k + 1)) = 1 dot 1 = 1
      $

      By induction, we conclude that $product^n_i A_i$ is a singleton for any positive integer $n$.
    ]
  ]
]

#section[
  #[]<q:no-funs>

  #mcq(
    [
      Let $X$, $Y$ be finite sets. How many functions $f : X -> Y$ are there from $X$ to $Y$?
    ],
    cols: 5,
    (
      $|Y|^(|X|)$,
      $2^(|X| dot |Y|)$,
      $attach(P, bl: |Y|, br: |X|)$,
      $|X|^(|Y|)$,
      $|X|! dot |Y|!$,
    ),
    0,
    explanation: [
      By the definition of a function, every element of the domain should be mapped. Moreover, they should be mapped to only one element of the codomain.

      If an element $x$ of the domain is given, it can be mapped to any elements in the codomain, thus there are $|Y|$ possibilities. If such a choice is performed for each of the $|X|$ elements of the domain, then there are $|Y| dot |Y| dot |Y| ... |Y| = |Y|^(|X|)$ possible functions in total. In short, the number of functions from $X$ to $Y$ is given as $|Y|^(|X|)$.

      Therefore, the first choice is the correct answer.
    ],
  )
]

#section[
  #question[
    Prove or disprove that the following statement holds for any finite sets $X$, $Y$ and $Z$.

    #align(center)[
      If the number of bijections from $X$ to $Y$ is the same as the number of bijections from $X$ to $Z$, then $|Y| = |Z|$.
    ]
  ][
    #falsestmt

    #proof[
      Let $X = { 1 }$, $Y = { 1, 2 }$, $Z = { 1, 2, 3 }$, respectively.

      The number of bijections from $X$ to $Y$ is $0$, and the number of bijections from $X$ to $Z$ is also $0$. However, their sizes are different as $|Y| = 2$ and $|Z| = 3$, so the statement is false.
    ]

    The statement is true if there is guaranteed to be at least one bijection between either $X$ and $Y$ or $X$ and $Z$. Say there is a bijection from $X$ to $Y$. As there is at least one bijection between them, by the premise there is also at least one bijection from $X$ to $Z$. Since a bijection between two finite sets implies they have the same cardinality, $|X| = |Y|$ and $|X| = |Z|$, hence $|Y| = |Z|$.
  ]
]

#section[
  #question[
    Prove or disprove that if $f$ and $g$ are injective, then $g compose f$ is injective for any functions $f$ and $g$.
  ][
    #truestmt

    #proof[
      Let $f : X -> Y$ and $g : Y -> Z$ be injective functions. To show that $g compose f$ is injective, let $x, x' in X$ be arbitrary and assume $(g compose f)(x) = (g compose f)(x')$, which is equivalent to saying that $g(f(x)) = g(f(x'))$. As $g$ is injective, it follows that $f(x) = f(x')$. As $f$ is injective as well, it follows that $x = x'$, showing that $g compose f$ is injective.
    ]
  ]
]

#section[
  #question[
    Prove or disprove that if $f compose g = f compose h$, then $g = h$ for any functions $f : Y -> Z$, $g, h : X -> Y$.
  ][
    #falsestmt

    #proof[
      Let $g, h : ZZ -> ZZ$ be functions defined by $g(x) = x$ and $h(x) = -x$, and let $f : ZZ -> ZZ$ be defined by $f(x) = x^2$. For any $x in ZZ$, $(f compose g)(x) = f(x) = x^2$ and $(f compose h)(x) = f(-x) = (-x)^2 = x^2$, so $f compose g = f compose h$. However $g != h$, since for instance $g(1) = 1 != -1 = h(1)$.
    ]

    However, the above statment is true if $f$ is injective. Can you prove it?
  ]
]

#section[
  #[]<q:fin-bij>

  #question[
    Prove or disprove the following statement.

    #align(center)[
      For any finite set $X$ and $Y$ where $|X| = |Y|$, a function $f : X -> Y$ is injective if and only if it is surjective.
    ]

    #hint[
      Use the pigeonhole principle.
    ]
  ][
    #truestmt

    #proof[
      Let $f(X) = { f(x) | x in X }$ denote the range of $f$. Note that $f(X) subset Y$, so $|f(X)| <= |Y|$.

      The _contrapositive_ form of the pigeonhole principle can be stated as: if $|Y|$ slots are given and no slot holds more than one item, then there are at most $|Y|$ items. Note that the injectivity of $f$ is essentially the "no slot holds more than one item" condition, which yields $|X| <= |f(X)|$.

      *Forward.* Assume $f$ is injective. By the contrapositive of the pigeonhole principle, $|X| <= |f(X)|$, and combined with $|f(X)| <= |Y| = |X|$ we get $|f(X)| = |X| = |Y|$. Since $f(X) subset Y$ and both are finite with the same size, $f(X) = Y$, hence $f$ is surjective.

      *Backward.* Assume $f$ is surjective, i.e., $f(X) = Y$, so $|f(X)| = |Y| = |X|$. Suppose for contradiction that $f$ is not injective. Then there exist $x != x'$ in $X$ with $f(x) = f(x')$, so the $|X|$ items collapse to at most $|X| - 1$ distinct slots, giving $|f(X)| <= |X| - 1 < |X|$. This contradicts $|f(X)| = |X|$. Hence $f$ is injective.
    ]
  ]
]

#section[
  #inline-note[
    $ln(x)$ denotes the natural logarithm of $x$.
  ]

  #question[
    Prove or disprove that $ln : RR^+ -> RR$ is bijective.
  ][
    #truestmt

    #proof[

      *Injectivity.* Let $x, y in RR^+$ be arbitrary and assume $ln(x) = ln(y)$. By the definition of $ln$, it follows that $x = exp(ln(x)) = exp(ln(y)) = y$, showing that $ln$ is injective.

      *Surjectivity.* Let $x in RR$ be arbitrary. Then $exp(x)$ is a positive real number with $ln(exp(x)) = x$, so $x$ has a preimage in $RR^+$ under $ln$. Hence $ln$ is surjective.

      As $ln$ is both injective and surjective, it is bijective.
    ]
  ]
]

#section[
  #mcq(
    [
      Which of the following is the same as $(-i)^4443$?
    ],
    cols: 5,
    (
      $(-i)^666$,
      $i^321$,
      $i^123$,
      $(-i)^4812$,
      $(-i)^333$,
    ),
    1,
    explanation: [
      Observe the following few cases.

      - $(-i)^0 = 1$
      - $(-i)^1 = -i$
      - $(-i)^2 = -1$
      - $(-i)^3 = i$

      For any $n >= 4$, if we divide it by $4$ such that $n = 4 q + (n mod 4)$ for some integer $q$, then the following holds as $(-i)^4 = 1$.

      $
        (-i)^n = (-i)^(4 q + (n mod 4)) = ((-i)^4)^q dot (-i)^((n mod 4)) = 1^q dot (-i)^((n mod 4)) = (-i)^((n mod 4))
      $

      Thus, for any non-negative integer $n$, the value of $(-i)^n$ is determined by the remainder $n mod 4$ as examined above. In algebraic terms, it can be said that ${ 1, i, -1, -i }$ forms a cyclic group of order $4$ under multiplication, and $-i$ is the generator of the group.

      Similarly, $i^n$ is determined by the remainder $n mod 4$, as follows.

      - $i^0 = 1$
      - $i^1 = i$
      - $i^2 = -1$
      - $i^3 = -i$

      Now, the value in question can be evaluated to $i$, as $4443 mod 4 = 3$.

      $(-i)^4443 = (-i)^3 = i$

      Similarly, all the choices above can be evaluated as follows.

      + $(-i)^666 = (-i)^2 = -1$
      + $i^321 = i^1 = i$
      + $i^123 = i^3 = -i$
      + $(-i)^4812 = (-i)^0 = 1$
      + $(-i)^333 = (-i)^1 = -i$

      Therefore, the second choice is the correct answer.
    ],
  )
]

#section[
  #question[
    How many trailing zeros are there in the decimal representation of $629!$?

    #hint[
      There are two trailing zeros in $11!$, as $11! = 39916800$.
    ]

    #v(12pt)

    Answer: #blank(50pt, "", answer: $156$)
  ][
    The number of trailing zeros of an integer is the same as the number of pairs of $2$ and $5$ factors in its prime factorization. Since the predecessor of every positive multiple of $5$ is even, factors of $2$ are always available to pair with factors of $5$, so we only count the occurrences of $5$.

    Since $5^4 = 625$ is the largest power of $5$ not exceeding $629$, the count splits layer by layer:

    - There are $5^3$ distinct multiples of $5$ up to $625$, each contributing one factor of $5$. ($5, 10, dots, 625$)
    - Among them, there are $5^2$ distinct multiples of $5^2$, each contributing one extra factor. ($25, 50, dots, 625$)
    - Among those, there are $5$ distinct multiples of $5^3$, each contributing one more. ($125, 250, dots, 625$)
    - Finally, there is only one multiple of $5^4$, namely $625$ itself. ($625$)

    Thus the total count is

    $ 5^3 + 5^2 + 5^1 + 5^0 $

    which, by the partial-sum formula for a geometric series, evaluates to

    $ (5^4 - 1) / (5 - 1) = 624 / 4 = 156 $

    Therefore, the correct answer is $156$.
  ]
]

#section[
  #inline-note[
    For integers $a$ and $b$, $a perp b$ denotes that there are no common divisors of $a$ and $b$ other than 1. It is equivalent to saying that $gcd(a, b) = 1$. In contrast, $a cancel(perp) b$ denotes that there are common divisors other than 1 between $a$ and $b$.
  ]

  + #question[
      Prove or disprove that the following statement holds for any integers $a$, $b$ and $c$.

      #align(center)[
        If $a perp b$ and $b perp c$, then $a perp c$.
      ]
    ][
      #falsestmt

      #proof[
        Consider three integers $10$, $21$ and $20$. Even though $10$ and $21$ are relatively prime and so are $21$ and $20$, $10$ and $20$ share a common divisor $5$ greater than $1$.
      ]
    ]

  + #question[
      Prove or disprove that the following statement holds for any integers $a$, $b$ and $c$.

      #align(center)[
        If $a cancel(perp) b$ and $b cancel(perp) c$, then $a cancel(perp) c$.
      ]
    ][
      #falsestmt

      #proof[
        Consider three integers $15$, $20$ and $28$. Even though $15$ and $20$ are not relatively prime and $20$ and $28$ are not either, $15$ and $28$ are relatively prime.
      ]
    ]
]

#section[
  + #question[
      Prove or disprove that the following statement holds for any integers $a$, $b$ and $c$.

      #align(center)[
        If $a$ divides $b$ and $b$ divides $c$, then $a$ divides $c$.
      ]
    ][
      #truestmt

      #proof[
        If $a$ divides $b$, then there exists an integer $q$ such that $b = a q$. Similarly, if $b = a q$ divides $c$, then there is an integer $p$ such that $c = b p = a q p$. As $c$ is a multiple of $a$, it follows that $a$ divides $c$.
      ]
    ]

  + #question[
      Prove or disprove that the following statement holds for any integers $a$, $b$ and $c$.

      #align(center)[
        If $a$ does not divide $b$ and $b$ does not divide $c$, then $a$ does not divide $c$.
      ]
    ][
      #falsestmt

      #proof[
        Consider three integers $7$, $10$ and $14$. Even though $7$ doesn't divide $10$ and $10$ doesn't divide $14$, clearly $7$ divides $14$.
      ]
    ]
]

#lemma[Euclid's lemma][
  For integers $a$, $b$, $c$, if $a perp b$ and $a$ divides $b c$, then $a$ divides $c$.
] <lem:euclid>

#section[
  #inline-note[
    For a rational number $r$, an irreducible form of $r$ is a representation $r = p / q$ such that $p in ZZ$, $q in ZZ^+$, and $p perp q$.
  ]

  Define $f : QQ -> ZZ times ZZ^+$ to be the rule that sends each $r in QQ$ to $(p, q)$, where $p / q$ is an irreducible form of $r$.

  + #question[
      Show that $f$ is a well-defined function.

      #hint[
        First, show that every rational number admits an irreducible form. Then, show that if $p / q$ and $p' / q'$ are both irreducible forms of the same rational number, then $p = p'$ and $q = q'$.
      ]
    ][
      We show existence and uniqueness of the irreducible form.

      #proof[

        *Existence.* Let $r in QQ$. By the definition of rational numbers, there exist integers $a$, $b$ with $b != 0$ such that $r = a / b$. Since $a / b = (-a) / (-b)$, by replacing $a$ and $b$ with $-a$ and $-b$ if $b < 0$, we may assume $b > 0$. Let $d = gcd(a, b)$, which is a positive integer because $b > 0$, and define $p = a / d$ and $q = b / d$. Then $p in ZZ$, $q in ZZ^+$, $p perp q$, and $p / q = a / b = r$. Hence $r$ admits at least one irreducible form.

        *Uniqueness.* Suppose $p / q$ and $p' / q'$ are both irreducible forms of the same rational number, so that $p, p' in ZZ$, $q, q' in ZZ^+$, $p perp q$, and $p' perp q'$. From $p / q = p' / q'$, multiplying both sides by $q q'$ gives $p q' = p' q$. In particular, $q$ divides $p q'$. Since $p perp q$, #link(<lem:euclid>)[*Euclid's lemma*] yields that $q$ divides $q'$. By the symmetric argument, $q'$ divides $q$. As $q$ and $q'$ are positive integers that divide each other, $q = q'$. Substituting back into $p q' = p' q$ gives $p q = p' q$, and since $q != 0$, we conclude $p = p'$ by cancelling $q$.

        Since every rational number has a unique irreducible form, $f$ assigns a single image $(p, q)$ to each $r in QQ$, hence $f$ is a well-defined function.
      ]
    ]

  + #question[
      Prove or disprove that $f$ is injective.
    ][
      #truestmt

      #proof[
        Let $r, r' in QQ$ with $f(r) = f(r')$. Write the irreducible forms of $r$ and $r'$ as $p / q$ and $p' / q'$, so that $f(r) = (p, q)$ and $f(r') = (p', q')$. The equality of ordered pairs $(p, q) = (p', q')$ gives $p = p'$ and $q = q'$. Therefore $r = p / q = p' / q' = r'$, showing that $f$ is injective.
      ]
    ]

  + #question[
      Prove or disprove that $f$ is surjective.
    ][
      #falsestmt

      #proof[
        Consider $(2, 4) in ZZ times ZZ^+$. Suppose for contradiction that $f(r) = (2, 4)$ for some $r in QQ$. By the definition of $f$, $2 / 4$ would then be an irreducible form, which requires $gcd(2, 4) = 1$. However $gcd(2, 4) = 2$, a contradiction. Hence $(2, 4)$ has no preimage under $f$, and $f$ is not surjective.
      ]
    ]
]

#section[
  #question[
    Show by induction that an equation of the following form has a unique complex solution for each $n in ZZ^+$.

    $ x^n = 0 $

    #hint[
      If $a b = 0$, then either $a$ or $b$ is zero.
    ]
  ][
    The solution of such an equation is always $0$, and we show it by induction.

    #proof[
      If $n = 1$, then the solution of the equation $x^1 = x = 0$ is trivially $0$, and it is the only solution. It can be seen that $0$ is indeed the solution of the equation, as $0^1 = 0$.

      Assume that the equation $x^n = 0$ has a unique solution, namely $0$. If an equation $x^(n + 1) = 0$ is given, it follows that either $x = 0$ or $x^n = 0$ as $x^(n + 1) = x^n x = 0$. If $x = 0$, then it shows that the solution is $0$. If $x^n = 0$, then by the induction hypothesis, the unique solution of it is $0$, which also shows that the solution of $x^(n + 1) = 0$ is $0$. As the possible solution is $0$ in either case, the solution is $0$ and unique. It can easily be verified that $0$ is indeed a solution, as $0^(n + 1) = 0$.
    ]

    We have used the property that if $a b = 0$, then either $a$ or $b$ is zero. Such a property is a characteristic property of integral domains. As we already know that it holds in complex numbers, we can deduce that they form an integral domain.
  ]
]

#section[
  #question[
    Let $bold(X)$ be a $m times m$ matrix with complex entries and $bold(0)$ be the zero matrix. Prove or disprove that an equation of the following form has a unique solution for each $n, m in ZZ^+$.

    $ bold(X)^n = bold(0) $
  ][
    #falsestmt

    #proof[
      For instance, a $2 times 2$ matrix $mat(0, 1; 0, 0)$ is a solution to the equation where $n = 2$.

      $ mat(0, 1; 0, 0) mat(0, 1; 0, 0) = mat(0, 0; 0, 0) $

      On the other hand, the zero matrix itself is always a solution as well. As there is a counterexample in a case where $m = 2$ and $n = 2$, the statement is false.
    ]
  ]
]

#section[
  #question[
    Let $bold(A)$ be a $n times n$ matrix with complex entries. Prove or disprove that the following equation has a unique solution for each $n in ZZ^+$.

    $ bold(A) = - bold(A) $
  ][
    #truestmt

    #proof[
      Adding $bold(A)$ to both sides yields $bold(A) + bold(A) = 2 bold(A) = bold(0)$, where $bold(0)$ is the zero matrix. Multiplying by the scalar $1/2$, we find that $bold(A) = bold(0)$. Since the zero matrix is the only matrix satisfying this condition, and indeed $bold(0) = - bold(0)$, the solution is unique.
    ]

    Note that the proof above doesn't use anything special about complex numbers. Can you prove it for real matrices as well?
  ]
]

#section[
  #question[
    Prove or disprove that for any positive integer $n in ZZ^+$, an equation of the following form has at most two distinct solutions in $ZZ_n$.

    $ x^2 equiv 1 thick (mod n) $

    #hint[
      By 'at most two distinct' solutions, we mean that the number of solutions can be zero, one, or two, but not more than two.
    ]
  ][
    #falsestmt

    #proof[
      Consider $ZZ_8$, and examine the squares of each element.

      - $0^2 = 0 equiv 0 quad (mod 8)$
      - $1^2 = 1 equiv 1 quad (mod 8)$
      - $2^2 = 4 equiv 4 quad (mod 8)$
      - $3^2 = 9 equiv 1 quad (mod 8)$
      - $4^2 = 16 equiv 0 quad (mod 8)$
      - $5^2 = 25 equiv 1 quad (mod 8)$
      - $6^2 = 36 equiv 4 quad (mod 8)$
      - $7^2 = 49 equiv 1 quad (mod 8)$

      Here we conclude that there are four distinct solutions to the equation in $ZZ_8$, namely $1$, $3$, $5$, and $7$.

      As there is a counterexample, the statement is false.
    ]

    If you have tried this from $ZZ_1$, you may have noticed that $ZZ_8$ is the smallest counterexample.

    Also, note that the quadratic equations in modular arithmetic can have more than two solutions, unlike ordinary quadratic equations. If it were a usual quadratic equation, the solutions would be only $1$ and $-1$, as you may have assumed.
  ]
]

#section[
  #[]<q:mul-inv>

  #question[
    Given any $a in ZZ_n$ such that $a perp n$, prove or disprove that an equation of the following form has a unique solution in $ZZ_n$ for each $n in ZZ^+$.

    $ a x equiv 1 quad (mod n) $

    #hint[
      See #qref(<q:fin-bij>). Can you find a relevant bijection on $ZZ_n$?
    ]
  ][
    #truestmt

    A simple proof is given below.

    #proof[

      *Existence.* Consider $g : ZZ_n -> ZZ_n$ defined by $g(k) = a k mod n$. We show $g$ is injective. Suppose $g(i) = g(j)$ for $i, j in ZZ_n$, i.e., $a i equiv a j thick (mod n)$. Then $n$ divides $a (j - i)$, and since $a perp n$, by #link(<lem:euclid>)[*Euclid's lemma*] $n$ divides $j - i$. As $|i - j| < n$, this forces $i = j$. By #qref(<q:fin-bij>), $g$ is surjective, so $1 mod n in ZZ_n$ has a preimage: there exists $k in ZZ_n$ with $a k equiv 1 thick (mod n)$.

      *Uniqueness.* Suppose $x$ and $x'$ are both solutions, so $a x equiv 1 thick (mod n)$ and $a x' equiv 1 thick (mod n)$. Multiplying the first by $x'$ gives $x' a x equiv x' thick (mod n)$. Since $a x' equiv 1 thick (mod n)$, the left side simplifies to $x$, hence $x equiv x' thick (mod n)$. Therefore the solution is unique.
    ]

    As the theorem is quite well-known, there are many proofs available, one of which is a proof using Bézout's lemma.
  ]
]

#section[
  + #question[
      How many solutions does the equation below have in $ZZ_12121212$?

      $ 1212 x equiv 4848 quad (mod 12121212) $

      #hint[
        Try considering similar questions on $ZZ_3$, $ZZ_8$, or any small $ZZ_n$ and solving them. Can you find a pattern?
      ]

      #v(12pt)

      Answer: #blank(50pt, "", answer: $1212$)
    ][
      Observe that $12121212$ can be factored as $1212 dot 10001$. We simply denote $10001$ as $m$.

      If $x in ZZ_(1212 m)$ is a solution to the equation, then by the definition of congruence, there should exist an integer $k$ such that $1212 x - 4848 = 1212 ( x - 4 ) = 1212 m k$. If we simplify the equation by dividing both sides by $1212$ and rearrange it, we get $x = m k + 4$. As $x in ZZ_(1212 m)$ is non-negative and less than $1212 m$, the number of all possible values of $m k + 4$ is exactly $1212$.

      Therefore, the correct answer is $1212$.
    ]

  + #question[
      How many solutions does the equation below have in $ZZ_20261212$?

      $ 1212 x equiv 2026 quad (mod 20261212) $

      #v(12pt)

      Answer: #blank(50pt, "", answer: $0$)
    ][
      If $x in ZZ_20261212$ is a solution to the equation, then by the definition of congruence, there should exist an integer $k$ such that $1212 x - 2026 = 20261212 k$. If we simplify the equation by dividing both sides by $2$, we get $606 x - 1013 = 10130606 k$. Since the left side is odd while the right side is even, there are no solutions satisfying the equation.

      Therefore, the correct answer is $0$.
    ]

  + #question[
      How many solutions does the equation below have in $ZZ_20262121$?

      $ 1212 x equiv 2026 quad (mod 20262121) $

      #hint[
        See #qref(<q:mul-inv>).
      ]

      #v(12pt)

      Answer: #blank(50pt, "", answer: $1$)
    ][
      Let's factorize $1212$ first. Dividing it by $2$ gives $606$, and by $6$ it gives $101$, which is a prime. Thus, $1212 = 2^2 dot 3^1 dot 101^1$. Clearly, $20262121$ is odd, and by adding all of its digits, we get $16$, which is not a multiple of $3$. Indeed, it is not a multiple of $101$ either, as $20 - 26 + 21 - 21 = -6$ is not a multiple of $101$. Hence we conclude that $1212 perp 20262121$.

      As we have shown in #qref(<q:mul-inv>), there always exists a unique multiplicative inverse $1212^(-1) in ZZ_20262121$, as $1212 perp 20262121$. By multiplying it on the equation, we have $x equiv 1212^(-1) 2026 thick (mod 20262121)$. As there can be only one element in $ZZ_20262121$ that satisfies the congruence by $20262121$, the solution exists and is unique.

      Therefore, the correct answer is $1$.
    ]
]

#section[
  #question[
    Let $ZZ^ZZ$ be a set of all functions from $ZZ$ to $ZZ$ and define a function $f in ZZ^ZZ$ by $f(x) = 2 x$. We denote the identity function on $ZZ$ by $1_ZZ$.

    Prove or disprove that the following equation has a unique solution in $ZZ^ZZ$. In other words, there is a unique function $x : ZZ -> ZZ$ such that the following equation holds.

    $ x compose f = 1_ZZ $
  ][
    #falsestmt

    #proof[
      The equation $x compose f = 1_ZZ$ essentially implies that $x$ should be a function such that $x(2 n) = n$ for all $n in ZZ$.

      Consider $x^arrow.b, x^arrow.t : ZZ -> ZZ$ where $x^arrow.b (n) = floor(n / 2)$ and $x^arrow.t (n) = ceil(n / 2)$, respectively.

      If $n$ is an integer, we have $x^arrow.b compose f = 1_ZZ$ as $(x^arrow.b compose f)(n) = floor((2 n) / 2) = floor(n) = n$. Similarly, $x^arrow.t compose f = 1_ZZ$ as $(x^arrow.t compose f)(n) = ceil((2 n) / 2) = ceil(n) = n$.

      However, $x^arrow.b$ and $x^arrow.t$ are not the same function, as $x^arrow.b (7) = floor(7 / 2) = 3$ and $x^arrow.t (7) = ceil(7 / 2) = 4$, for instance. Thus, there are at least two solutions to the equation, disproving that the solution is unique.

      As there is a counterexample, the statement is false.
    ]
  ]
]

#section[
  #question(ansbox: false)[
    Let $Gamma$ be an arbitrary finite set of invertible $n times n$ matrices with complex entries with $n in ZZ^+$. Suppose that $Gamma$ is closed under matrix multiplication. In other words, for any $bold(A), bold(B) in Gamma$, the product $bold(A) bold(B)$ is also in $Gamma$.

    Let $bold(Psi)$ be the sum of all matrices in $Gamma$.

    $ bold(Psi) = sum_(bold(Omega) in Gamma) bold(Omega) $

    Show that for any matrix $bold(Lambda) in Gamma$, the equation $bold(Lambda) bold(Psi) = bold(Psi)$ holds.

    #hint[
      See #qref(<q:fin-bij>).
    ]
  ][]

  #long-answer[
    #proof[
      We first show that the left multiplication by $bold(Lambda)$ is bijective for any $bold(Lambda) in Gamma$. That is, if we consider a function $f : Gamma -> Gamma$ defined by $f(bold(Omega)) = bold(Lambda) bold(Omega)$, then such $f$ is both injective and surjective.

      *Injectivity.* For arbitrary two matrices $bold(A), bold(B) in Gamma$, suppose $bold(Lambda) bold(A) = bold(Lambda) bold(B)$ holds. As every matrix in $Gamma$ is invertible, there exists an inverse matrix $bold(Lambda)^(-1)$. By multiplying it on both sides, we get $bold(Lambda)^(-1) bold(Lambda) bold(A) = bold(Lambda)^(-1) bold(Lambda) bold(B)$, which yields $bold(A) = bold(B)$. Hence, $f$ is injective.

      *Surjectivity.* As we have shown in #qref(<q:fin-bij>), $f$ is automatically surjective as it is an injective function between two finite sets with the same size.

      Here, we conclude that $f : Gamma -> Gamma$, the left multiplication by $bold(Lambda)$, is bijective.


      By the distributive property of matrix multiplication over addition, we have the following.

      $
        bold(Lambda) bold(Psi) = bold(Lambda) sum_(bold(Omega) in Gamma) bold(Omega) = sum_(bold(Omega) in Gamma) bold(Lambda) bold(Omega) =
        sum_(bold(Omega) in Gamma) f(bold(Omega))
      $

      Because $f$, the left multiplication by $bold(Lambda)$, is bijective, there is a one-to-one correspondence between each term $bold(Omega)$ in $bold(Psi)$ and each term $f(bold(Omega))$ in the above $bold(Lambda) bold(Psi)$ equation. Otherwise put, the product $bold(Lambda) bold(Omega)$ evaluates to every element of $Gamma$ exactly once, just in a potentially different order.

      Therefore, summing $f(bold(Omega))$ over all $bold(Omega) in Gamma$ must be exactly the same as summing $bold(Omega)$ over all $bold(Omega) in Gamma$, by the commutativity law of matrix addition. The terms are identical; only their order in the summation has changed, which doesn't affect the sum.

      $
        sum_(bold(Omega) in Gamma) f(bold(Omega)) = sum_(bold(Omega) in Gamma) bold(Omega) = bold(Psi)
      $

      Therefore, the equation $bold(Lambda) bold(Psi) = bold(Psi)$ holds for any matrix $bold(Lambda) in Gamma$.
    ]

    In fact, every finite subset of invertible $n times n$ complex matrices always forms a group, and it becomes a subgroup of a larger group called the _general linear group_ $"GL"_CC (n)$, which is a special case of so-called _matrix Lie groups_.

    Also, note that the above proof purely depends on just a few algebraic properties such as _closedness_, _commutativity_, _distributivity_, and _invertibility_. It doesn't depend on any specific properties of complex numbers or even matrices at all. If you are curious, try proving a generalized statement below.

    #proposition[
      Let $X$ be a set with two operations, $+$ and $times$ where both are associative and $+$ is commutative, and $times$ has an identity and $times$ distributes over $+$. For any finite subset $Y subset X$ that is closed under $times$ and every element $y in Y$ has an inverse $y^(-1) in Y$, the equation $y' sum_(y in Y) y = sum_(y in Y) y$ holds for any $y' in Y$.
    ]

    Believe it or not, we can reuse the exact same proof as above.

    Let us pause for a moment and reflect on what we just did. By _abstracting_ a few key properties out from matrices, we have generalized an interesting property of matrices to an incredible, much more powerful theorem that can be applied to any system that _behaves_ like matrices. That's why we call it an _abstract_ algebra. Indeed, this is what abstract algebra is all about.

    Thanks for putting up with this until the end. I'll see you in the lecture.
  ]
]

End.

You may now submit your work.

#pagebreak()

= Evaluation sheet

#v(8pt)

#emph-block[
  For each question so far, evaluate it based on the following criteria:

  - If you encountered new concepts or new words for the first time, mark #sym.checkmark in the New concepts column.
  - If you failed to understand the question, mark #sym.crossmark in the Evaluation column.
  - If you understood the question, but didn't know how to solve it, mark #sym.quest in the Evaluation column.
  - If you understood the question and are sure you have solved it, mark #sym.circle in the Evaluation column.
]

#let total-questions = 34
#let rows = calc.ceil(total-questions / 2)

#align(center, table(
  columns: (auto, auto, auto, auto, auto, auto),
  stroke: 0.5pt,
  table.header([*No.*], [*New concepts*], [*Evaluation*], [*No.*], [*New concepts*], [*Evaluation*]),
  ..range(1, rows + 1)
    .map(n => (
      [Q#n],
      [],
      [],
      if n + rows <= total-questions { [Q#(n + rows)] } else { [] },
      [],
      [],
    ))
    .flatten(),
))

#emph-block[
  Please answer these additional questions:

  + Which was the hardest for you, among those you have solved? #h(4pt) #blank(50pt, "")

  + Which seemed to be the hardest for you, among those you haven't solved? #h(4pt) #blank(50pt, "")

  + Which was your favorite question, if you had to choose one? #h(4pt) #blank(50pt, "")
]
