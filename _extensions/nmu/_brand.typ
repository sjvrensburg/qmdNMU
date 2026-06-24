// Nelson Mandela University — shared brand layer
// Single source of truth for colours, fonts and reusable components.
// Imported by every per-format Typst partial in this extension.

// ---------------------------------------------------------------------------
// Colours (Brand Manual pp. 14–15)
// ---------------------------------------------------------------------------
#let nmu-navy        = rgb("#071b2c")  // Primary "Alfa Blue" (Pantone 296 C)
#let nmu-navy-web    = rgb("#141c2b")  // Web brand blue
#let nmu-navy-2      = rgb("#132e51")  // Secondary blue
#let nmu-logo-blue   = rgb("#001333")  // Background blue baked into logo JPG 02 (for seamless blend)
#let nmu-yellow      = rgb("#ffb81c")  // Secondary "Sunflower Yellow" (Pantone 7548 C)
#let nmu-yellow-web  = rgb("#ffcc00")  // Web brand yellow
#let nmu-yellow-2    = rgb("#f9b22a")  // Secondary yellow
#let nmu-grey        = rgb("#999999")  // 40% grey
#let nmu-grey-light  = rgb("#eef1f4")

// Faculty accent — Faculty of Sciences (Pantone 356 C, RGB 0,107,52)
#let nmu-science     = rgb("#006b34")
#let nmu-science-tint = rgb("#cfe3d6")

// Active accent for this template set (Science faculty)
#let nmu-accent      = nmu-science

// ---------------------------------------------------------------------------
// Fonts
//   Print brand font is Avenir (proprietary). Brand-sanctioned digital font
//   is Nunito Sans (free). Default to Nunito Sans; allow opt-in to Avenir.
// ---------------------------------------------------------------------------
#let nmu-font-body = ("Nunito Sans", "Avenir", "Arial")
#let nmu-font-head = ("Nunito Sans", "Avenir", "Arial")

// Override fonts when `brand-font: avenir` is set in front matter.
#let nmu-resolve-fonts(font-choice) = {
  if font-choice == "avenir" {
    (body: ("Avenir", "Nunito Sans", "Arial"),
     head: ("Avenir", "Nunito Sans", "Arial"))
  } else {
    (body: nmu-font-body, head: nmu-font-head)
  }
}

// ---------------------------------------------------------------------------
// Logo helpers (assets bundled with the extension)
// ---------------------------------------------------------------------------
#let nmu-logo-colour   = "assets/logos/logo-colour.jpg"
#let nmu-logo-white    = "assets/logos/logo-white.png"
#let nmu-logo-reversed = "assets/logos/logo-reversed.png"

// reversed = full-colour reversed logo (white text + yellow shapes, file 06),
// NOT the monochrome one-colour version — brand prefers full colour everywhere.
#let nmu-logo(reversed: false, width: 60mm) = {
  image(if reversed { nmu-logo-reversed } else { nmu-logo-colour }, width: width)
}

// Linear (single-line) lockup — "NELSON MANDELA" with "UNIVERSITY" set to its
// right, composed from the two wordmark crops. `height` sizes the main wordmark;
// "UNIVERSITY" keeps its native relative size (41/68) and is vertically centred.
// Proportions measured from the deck's linear footer logo (400-dpi render):
//   UNIVERSITY height = 0.685 x NELSON MANDELA height; gap = 1.63 x that height.
#let nmu-logo-linear(height: 6mm, reversed: false) = {
  let m = if reversed { "assets/logos/wordmark-mandela-white.png" } else { "assets/logos/wordmark-mandela.png" }
  let u = if reversed { "assets/logos/wordmark-university-white.png" } else { "assets/logos/wordmark-university.png" }
  box(grid(columns: (auto, auto, auto), align: horizon, rows: 1,
    image(m, height: height),
    h(height * 1.63),
    image(u, height: height * 0.685),
  ))
}

// ---------------------------------------------------------------------------
// Reusable components
// ---------------------------------------------------------------------------

// Coloured callout box with a header bar (kind: info | note | tip | warning).
// Header bar in the accent colour with a white title; light tinted body.
#let nmu-callout(title: none, kind: "info", body) = {
  let palette = (
    info:    (nmu-navy,    nmu-grey-light),
    note:    (nmu-navy,    nmu-grey-light),
    tip:     (nmu-science, nmu-science-tint),
    warning: (nmu-yellow-2, rgb("#fff5da")),
  )
  let (bar, bg) = palette.at(kind, default: palette.info)
  let title-fill = if kind == "warning" { nmu-navy } else { white }
  block(width: 100%, radius: 3pt, clip: true, stroke: 0.5pt + bar, breakable: true)[
    #if title != none {
      block(width: 100%, fill: bar, inset: (x: 12pt, y: 7pt), below: 0pt,
        text(weight: "bold", fill: title-fill)[#title])
    }
    #block(width: 100%, fill: bg, inset: 12pt, above: 0pt, body)
  ]
}

// Section header with a matching brand illustration on the right.
// `key` maps to assets/illustrations/<key>.jpg
#let nmu-section(title, key: none, subtitle: none) = {
  let img = if key != none { "assets/illustrations/" + key + ".jpg" } else { none }
  block(breakable: false, above: 18pt, below: 12pt)[
    #grid(
      columns: (1fr, auto), align: (horizon + left, horizon + right), gutter: 12pt,
      [
        #text(size: 20pt, weight: "bold", fill: nmu-navy)[#title]
        #if subtitle != none {
          linebreak()
          text(size: 11pt, fill: nmu-accent)[#subtitle]
        }
        #v(6pt)
        #line(length: 40%, stroke: 2pt + nmu-accent)
      ],
      if img != none { image(img, height: 28mm) } else { [] },
    )
  ]
}
