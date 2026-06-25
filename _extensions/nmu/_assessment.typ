// Assessment helpers — question / part / solution environments with automatic
// numbering and mark counting. Used by the `assessment: true` document type.
#import "_brand.typ": *

#let nmu-qcounter   = counter("nmu-question")
#let nmu-pcounter   = counter("nmu-part")
#let nmu-marktotal  = counter("nmu-marktotal")
#let nmu-solutions-state = state("nmu-solutions", false)
// High-contrast, printer-friendly mode. Set by `monochrome: true` front matter;
// helpers below read it (in a context block) to pick a black/white palette.
#let nmu-mono-state = state("nmu-mono", false)

// Final accumulated mark total (resolves in a context block, two-pass layout).
#let nmu-total-marks() = context nmu-marktotal.final().first()

// Accent ink for marks / question headings — black in monochrome mode.
#let nmu-assess-accent() = if nmu-mono-state.get() { black } else { nmu-science }
#let nmu-assess-ink()    = if nmu-mono-state.get() { black } else { nmu-navy }

#let nmu-marks-tag(m) = context {
  text(fill: nmu-assess-accent(), weight: "bold")[
    [#m #if m == 1 [mark] else [marks]]
  ]
}

// A top-level question. Auto-numbered; adds `marks` to the running total.
// Pass `none` for the marks when the question's parts carry the marks instead
// (so the total is not double-counted).
#let question(marks, body) = {
  nmu-qcounter.step()
  nmu-pcounter.update(0)
  if marks != none { nmu-marktotal.update(n => n + marks) }
  block(above: 16pt, below: 8pt, breakable: true, width: 100%)[
    #grid(columns: (1fr, auto), align: (left + top, right + top),
      context text(weight: "bold", fill: nmu-assess-ink(), size: 12pt)[
        Question #nmu-qcounter.display()
      ],
      if marks != none { nmu-marks-tag(marks) } else [],
    )
    #v(2pt)
    #body
  ]
}

// A sub-part worth `marks`, lettered (a), (b), … within the current question.
#let part(marks, body) = {
  nmu-pcounter.step()
  nmu-marktotal.update(n => n + marks)
  block(above: 7pt, below: 3pt, width: 100%)[
    #grid(columns: (auto, 1fr, auto), column-gutter: 8pt,
      align: (left + top, left + top, right + top),
      [(#context nmu-pcounter.display("a"))],
      body,
      nmu-marks-tag(marks),
    )
  ]
}

// Solution / memorandum content — shown only when `solutions: true`.
#let solution(body) = context {
  if nmu-solutions-state.get() {
    nmu-callout(title: "Solution", kind: "tip", mono: nmu-mono-state.get())[#body]
  }
}
