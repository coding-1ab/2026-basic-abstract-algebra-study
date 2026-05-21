#import "./exm/lib/lib.typ": (
  blank, colorgreen, colorred, docmode, mcq as exm-mcq, question as exm-question, section as exm-section,
  section-counter,
)
#import "@preview/theorion:0.6.0": cosmos, set-inherited-levels, show-theorion, theorem-counter
#import cosmos.simple: make-frame, render-fn
#import cosmos.rainbow: definition

// vars

#let show-answers = sys.inputs.at("answers", default: "false") == "true"

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

// theorion

#let (_, inline-note-box, inline-note, show-inline-note) = make-frame(
  "inline-note",
  "Note",
  counter: theorem-counter,
  render: render-fn,
)

#let (_, hint-box, hint, show-hint) = make-frame("hint", "Hint", counter: theorem-counter, render: render-fn)

#let definition = definition.with(fill: primary-color)

// exm

#let lv-easy = (text: "EASY", color: rgb("#5fad4e"))
#let lv-hard = (text: "HARD", color: cl-grapefruit)
#let lv-levi = (
  text: "LEVI",
  color: gradient.linear(
    rgb("#fe7ba7"),
    rgb("#b290ff"),
  ),
)

#let section(level: none, ..args) = {
  set enum(numbering: (..nums) => text(fill: primary-color, weight: "bold")[#numbering("(a)", ..nums)])

  context {
    let n = section-counter.get().at(0) + 1
    heading(level: 2, outlined: true, bookmarked: true, numbering: none, supplement: [qbookmark])[Q#n]
  }

  // level label on the right margin
  if level != none {
    place(
      right,
      dy: 0pt,
      rect(
        stroke: 1.2pt + level.color,
        radius: 2pt,
        inset: (x: 6pt, y: 4pt),
      )[#box(text(fill: level.color, weight: "semibold", size: 0.8em, font: title-font)[#str(level.text)])],
    )
  }

  exm-section(number: true, display: "Q1. ", color: primary-color, "", ..args)

  v(20pt)
}

#let qref(lbl) = {
  // use `link` to make it clickable
  link(lbl)[
    // use `context` to look up the counter's value at the specific label
    *Q#context section-counter.at(lbl).first()*
  ]
}

#let question = exm-question.with(
  ansbox: show-answers,
  color: solution-color,
  color-text: text-color,
)

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

// wrapper
#let template(
  doc,
  author: none,
  date: none,
  title: none,
  emp-title: none,
  course-name: none,
  institution: none,
  version: none,
) = {
  // etc dynamic
  docmode.update(if show-answers { "sol" } else { "screen" })

  // set / show

  // theorion
  show: show-theorion
  show: show-inline-note
  show: show-hint

  // Make every theorion frame share `theorem-counter` (the default counter behind
  // definition, note, lemma, proposition, …) and count linearly across sections
  // instead of inheriting two heading levels.
  set-inherited-levels(0)

  // heading bookmark
  show heading.where(supplement: [qbookmark]): it => place(hide(it.body))

  // math tweaks
  set math.mat(delim: "[")

  // underline links
  show link: this => { underline(this) }

  // font size
  set text(size: 11pt)

  // enum styles, https://forum.typst.app/t/how-can-i-format-an-enums-numbering-without-overriding-the-numbering-style/3246
  set enum(
    full: true,
    numbering: (..nums, last) => {
      text(
        weight: "bold",
        numbering(("(a)", "i.").at(nums.pos().len(), default: "1."), last),
      )
    },
  )

  // exm-style table
  set table(
    stroke: (x, y) => (
      left: if x == 0 { 0.5pt } else { 0pt },
      right: 0.5pt,
      top: if y <= 1 { 0.5pt } else { 0pt },
      bottom: 0.5pt,
    ),
    fill: (_, y) => if calc.even(y) { luma(245) } else { white },
    inset: (x: 10pt, y: 5pt),
  )

  // main page configuration
  set page(
    // margin: (top: 1.65cm, bottom: 2.6cm, left: 1.65cm, right: 1.65cm),
    // margin: (top: 1.98cm, bottom: 3.12cm, left: 1.98cm, right: 1.98cm),

    // side-pagination config
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

  // document
  set document(author: author, title: title, date: date)

  // cover
  page(
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
        image("./assets/cl-gradient-logo.svg"),
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

  // normal page setup
  set page(
    margin: (top: 1.98cm, bottom: 3.12cm, left: 1.98cm, right: 1.98cm),
  )

  doc
}
