#import "brand.typ": *
#import "mosaic.typ": nmu-mosaic

// ===========================================================================
// Lecture notes — between the plain academic notes and the module guide:
//   a compact branded title header (linear logo + green rule), numbered
//   sections, branded callouts, light footer. No cover page.
// ===========================================================================
#let nmu-notes(
  title: none,
  subtitle: none,
  author: none,
  date: none,
  module-code: none,
  toc: false,
  brand-font: "nunito",
  body,
) = {
  let fonts = nmu-resolve-fonts(brand-font)
  set document(title: if title != none { title } else { "Notes" })
  set page(
    paper: "a4",
    margin: (top: 24mm, bottom: 22mm, x: 24mm),
    footer: context {
      line(length: 100%, stroke: 0.5pt + nmu-science)
      v(2pt)
      set text(size: 8.5pt, fill: nmu-grey)
      grid(columns: (1fr, auto, 1fr),
        align: (left + horizon, center + horizon, right + horizon),
        if module-code != none [#module-code] else [],
        text(fill: nmu-navy, weight: "bold")[#counter(page).display()],
        if title != none { text[#title] } else [],
      )
    },
  )
  set text(font: fonts.body, size: 11pt, fill: nmu-navy, lang: "en")
  set par(justify: true, leading: 0.62em)
  set heading(numbering: "1.1")
  show heading: set text(font: fonts.head, fill: nmu-navy)
  show heading.where(level: 1): set text(size: 15pt)
  show heading.where(level: 2): set text(size: 12.5pt, fill: nmu-science)
  show heading.where(level: 3): set text(size: 11pt)
  show link: set text(fill: nmu-science)

  // ---- Branded title header (no separate cover) ----
  align(right, nmu-logo-linear(height: 7mm))
  v(2mm)
  line(length: 100%, stroke: 0.5pt + nmu-grey)
  v(7mm)
  align(center, block(width: 92%)[
    #text(size: 24pt, weight: "bold", fill: nmu-navy)[#title]
    #if subtitle != none { linebreak(); v(2mm); text(size: 14pt, fill: nmu-science)[#subtitle] }
    #if author != none { linebreak(); v(3mm); text(size: 12pt, fill: nmu-navy)[#author] }
    #if date != none { linebreak(); v(1mm); text(size: 10pt, fill: nmu-grey)[#date] }
  ])
  v(4mm)
  line(length: 100%, stroke: 2pt + nmu-science)
  v(8mm)

  if toc {
    show outline.entry.where(level: 1): set text(weight: "bold", fill: nmu-navy)
    outline(title: [Contents], depth: 3, indent: 1em)
    v(4mm)
  }

  body
}

// ===========================================================================
// Research poster (mirrors Research-poster-template.pptx: 600x900mm, navy
//   header band with linear logo, navy footer with slogan + URL, multi-column
//   white body). `#` headings are section headers; `##` are subsections.
// ===========================================================================
#let nmu-poster(
  title: none,
  author: none,
  affiliation: none,
  cols: 2,
  footer-url: "mandela.ac.za",
  slogan: "Change the World",
  brand-font: "nunito",
  body,
) = {
  let fonts = nmu-resolve-fonts(brand-font)
  let header-h = 115mm
  let footer-h = 45mm

  set document(title: if title != none { title } else { "Poster" })
  set page(
    width: 600mm, height: 900mm,
    margin: (top: header-h + 24mm, bottom: footer-h + 22mm, x: 30mm),
    footer: none,
    background: {
      // Header band with right-aligned stacked full-colour reversed logo
      place(top, rect(width: 100%, height: header-h, fill: nmu-navy))
      place(top, box(width: 100%, height: header-h, inset: (right: 30mm),
        align(right + horizon, nmu-logo(reversed: true, width: 250mm))))
      // Footer band: slogan left, URL right
      place(bottom, rect(width: 100%, height: footer-h, fill: nmu-navy))
      place(bottom, box(width: 100%, height: footer-h, inset: (x: 40mm),
        align(horizon, box(width: 100%, grid(columns: (1fr, auto),
          align: (left + horizon, right + horizon),
          text(fill: white, weight: "bold", size: 30pt)[#slogan],
          text(fill: nmu-yellow, weight: "bold", size: 30pt)[#footer-url],
        )))))
    },
  )
  set text(font: fonts.body, size: 22pt, fill: nmu-navy, lang: "en")
  set par(justify: true, leading: 0.6em)
  show link: set text(fill: nmu-science)

  // Section headers (level 1) and subsections (level 2)
  show heading.where(level: 1): it => block(breakable: false, above: 14pt, below: 8pt)[
    #text(size: 32pt, weight: "bold", fill: nmu-navy)[#it.body]
    #v(2pt)
    #line(length: 100%, stroke: 3pt + nmu-science)
  ]
  show heading.where(level: 2): set text(size: 26pt, fill: nmu-science, weight: "bold")

  // Title block spanning the full width, above the columns
  block(width: 100%, below: 14mm)[
    #if title != none { text(size: 56pt, weight: "bold", fill: nmu-navy)[#title] }
    #if author != none { v(6mm); text(size: 30pt, fill: nmu-navy)[#author] }
    #if affiliation != none { linebreak(); v(2mm); text(size: 24pt, fill: nmu-science)[#affiliation] }
    #v(6mm)
    #line(length: 100%, stroke: 4pt + nmu-yellow)
  ]

  columns(cols, gutter: 18mm, body)
}

// ===========================================================================
// Letter (mirrors Brand Manual letterhead spec, p.33)
//   Logo centred at top, sender block top-right, slogan bottom-left and
//   physical address bottom-right. Margins T35 / B15 / L20 / R20 mm.
// ===========================================================================
#let nmu-letter(
  campus: none,
  school: none,
  tel: none,
  fax: none,
  email: none,
  ref: none,
  contact: none,
  date: none,
  to: none,
  salutation: none,
  closing: "Kind Regards,",
  signature: none,
  signature-title: none,
  address: "PO Box 77000, Nelson Mandela University, Gqeberha, 6031, South Africa",
  slogan: "Change the World",
  brand-font: "nunito",
  body,
) = {
  let fonts = nmu-resolve-fonts(brand-font)
  set document(title: "Letter")
  set page(
    paper: "a4",
    margin: (top: 35mm, bottom: 15mm, left: 20mm, right: 20mm),
    footer: context {
      set text(size: 8pt)
      grid(columns: (1fr, auto),
        text(weight: "bold", fill: nmu-navy)[#slogan],
        text(fill: nmu-grey)[#address],
      )
    },
  )
  set text(font: fonts.body, size: 10pt, fill: nmu-navy, lang: "en")
  set par(justify: true, leading: 0.65em)
  show link: set text(fill: nmu-science)

  // Logo centred at the top of the content area (stacked, max ~84mm)
  align(center, nmu-logo(width: 70mm))
  v(8mm)

  // Sender details, right-aligned
  if (campus, school, tel, fax, email).any(x => x != none) {
    align(right, block[
      #set text(size: 9pt)
      #set par(leading: 0.5em)
      #if campus != none [#campus \ ]
      #if school != none [#school \ ]
      #if tel != none [T #tel #if fax != none [ #h(4pt) F #fax] \ ]
      #if email != none {
        let e = email.replace("\\@", "@")
        link("mailto:" + e)[#e]
      }
    ])
  }
  v(10mm)

  // Reference / contact / date
  if ref != none [*Ref:* #ref \ ]
  if contact != none [*Contact person:* #contact \ ]
  if date != none { v(4pt); text[#date] ; parbreak() }

  // Recipient block
  if to != none { v(4pt); block(to); parbreak() }

  v(4mm)
  if salutation != none [#salutation #parbreak()]

  body

  v(8mm)
  if closing != none [#closing #parbreak()]
  v(8mm)
  if signature != none { text(weight: "bold")[#signature]; parbreak() }
  if signature-title != none { text(fill: nmu-grey)[#signature-title] }
}

// ===========================================================================
// Slides (mirrors Faculty of Science PowerPoint deck)
//   Title slide: navy field + white logo. Content slides: white with a green
//   Science bar along the bottom edge and a footer (logo + "Change the World").
//   `##` headings start new content slides; `#` headings are section dividers.
// ===========================================================================
#let nmu-slides(
  title: none,
  subtitle: none,
  author: none,
  institute: "Faculty of Science",
  date: none,
  aspect: "16:9",
  cover-image: none,
  brand-font: "nunito",
  slogan: "Change the World",
  body,
) = {
  let fonts = nmu-resolve-fonts(brand-font)
  // Title-slide imagery band: user-supplied image, else the default science band.
  let cover-band = if cover-image != none { cover-image } else { "assets/illustrations/slide-title-band.png" }
  let band-h = 67mm
  let (pw, ph) = if aspect == "4:3" { (25.4cm, 19.05cm) } else { (25.4cm, 14.29cm) }
  let edge = 18mm  // left margin for title-slide text
  // Logo high, band clear of its "University" line, title below the band.
  let (band-dy, title-dy, title-size, detail-size) = if aspect == "4:3" {
    (34.5mm, 110mm, 36pt, 16pt)
  } else {
    (32.5mm, 104mm, 28pt, 13pt)
  }

  set document(title: if title != none { title } else { "Slides" })
  set text(font: fonts.body, size: 20pt, fill: nmu-navy, lang: "en")
  set page(
    width: pw, height: ph, margin: (top: 18mm, bottom: 16mm, x: 18mm),
    // Uninterrupted green Science bar along the very bottom edge
    background: place(bottom, rect(width: 100%, height: 4mm, fill: nmu-science)),
    // Footer sits ABOVE the green bar: transparent colour logo + slogan
    footer: pad(bottom: 3mm, grid(
      columns: (1fr, auto), align: (left + horizon, right + horizon),
      nmu-logo-linear(height: 3.8mm),
      text(size: 11pt, weight: "bold", fill: nmu-navy)[#slogan],
    )),
  )
  set list(marker: (text(fill: nmu-science)[•], text(fill: nmu-yellow)[‣]))

  // Content-slide titles from level-2 headings
  show heading.where(level: 2): it => {
    pagebreak(weak: true)
    block(below: 12pt)[
      #text(size: 28pt, weight: "bold", fill: nmu-navy)[#it.body]
      #v(3pt)
      #line(length: 28%, stroke: 2.5pt + nmu-science)
    ]
  }
  // Section-divider slides from level-1 headings:
  // navy field with an African geometric pattern strip down the left edge.
  show heading.where(level: 1): it => {
    page(fill: nmu-navy, footer: none, margin: 0pt, background: none)[
      #place(left + top, box(width: 38mm, height: 100%, clip: true,
        nmu-mosaic(width: 38mm, cols: 2, rows: 14)))
      #place(left + top, dx: 38mm, rect(width: 2mm, height: 100%, fill: nmu-yellow))
      #place(left + horizon, dx: 40mm, box(width: pw - 40mm, height: 100%)[
        #set align(center + horizon)
        #block(width: 84%, text(fill: white, size: 40pt, weight: "bold")[#it.body])
      ])
    ]
  }

  // ---- Title slide (mirrors Faculty of Science deck cover) ----
  // Background matches the logo JPG's baked-in blue so the logo blends seamlessly.
  page(fill: nmu-logo-blue, footer: none, margin: 0pt, background: none)[
    // White-on-blue logo centred near the top (Brand Manual logo 02)
    #place(top + center, dy: 6mm,
      image("assets/logos/logo-white-on-blue.jpg", width: 76mm))
    // Faculty imagery band spanning the full slide width, clear of the logo.
    // A user-supplied image is fit within the band area; the default fills it.
    #place(top + center, dy: band-dy, box(width: 100%, height: band-h,
      align(center, image(cover-band, fit: "contain", width: 100%, height: 100%))))
    // Title and details, left-aligned after a left margin, below the band
    #place(top + left, dx: edge, dy: title-dy, block(width: pw - 2 * edge)[
      #set align(left)
      #if title != none { text(fill: white, size: title-size, weight: "bold")[#title] }
      #v(-1mm)
      #set text(fill: white, size: detail-size)
      #let bullet(b) = grid(columns: (7mm, 1fr), align: (horizon, horizon),
        text(fill: nmu-science)[▪], b)
      #if subtitle != none { bullet(subtitle); v(1.5mm) }
      #let presenter = {
        let parts = ()
        if author != none { parts.push(author) }
        if institute != none { parts.push(institute) }
        if date != none { parts.push(text(fill: nmu-yellow)[#date]) }
        parts.join([ · ])
      }
      #if presenter != none and presenter != () { bullet(presenter) }
    ])
  ]

  body
}

// Module Guide document function (Faculty of Sciences look & feel)
#let nmu-moduleguide(
  title: "Module Guide",
  subtitle: none,
  faculty: "Faculty of Science",
  module-code: none,
  module-name: none,
  qualification: none,
  campus: none,
  department: none,
  lecturer: none,
  year: none,
  hashtag: none,
  cover-image: none,
  brand-font: "nunito",
  paper: "a4",
  body,
) = {
  let fonts = nmu-resolve-fonts(brand-font)

  set document(title: title)
  set page(
    paper: paper,
    margin: (top: 25mm, bottom: 22mm, left: 22mm, right: 22mm),
    footer: context {
      set text(size: 8pt, fill: nmu-grey)
      grid(columns: (1fr, auto),
        [#text(weight: "bold", fill: nmu-navy)[Change the World]],
        [#counter(page).display()],
      )
    },
  )
  set text(font: fonts.body, size: 10.5pt, fill: nmu-navy, lang: "en")
  set par(justify: true, leading: 0.65em)

  show heading: set text(fill: nmu-navy, font: fonts.head)
  show heading.where(level: 1): set text(size: 16pt)
  show heading.where(level: 2): set text(size: 13pt, fill: nmu-accent)
  show link: set text(fill: nmu-science)

  // ---- Cover page (mirrors "Module guide cover design.pdf") ----
  page(margin: 0pt, footer: none, fill: nmu-navy)[
    // Centred white logo near the top
    #place(top + center, dy: 22mm, nmu-logo(reversed: true, width: 62mm))

    // Full-width yellow band with the faculty name in navy
    #place(top + center, dy: 52mm,
      rect(width: 100%, height: 24mm, fill: nmu-yellow)[
        #set align(center + horizon)
        #text(fill: nmu-navy, weight: "bold", size: 30pt)[#faculty]
      ])

    // White title block
    #place(top + center, dy: 92mm, block(width: 80%)[
      #set align(center)
      #set par(leading: 0.4em)
      #text(fill: white, size: 34pt, weight: "bold")[#title]
      #if module-name != none {
        linebreak(); v(4mm)
        text(fill: white, size: 22pt, weight: "bold")[#module-name]
      }
      #if module-code != none {
        linebreak(); v(3mm)
        text(fill: white.transparentize(15%), size: 16pt)[#module-code]
      }
    ])

    // Hashtag accent line (green # + yellow tail), e.g. "#2026 AY"
    #if hashtag != none {
      place(top + center, dy: 150mm,
        text(size: 26pt, weight: "bold")[
          #text(fill: nmu-science)[\##hashtag] #text(fill: nmu-yellow)[AY]
        ])
    }

    // Optional user-supplied cover image, centred in the open mid-lower area
    #if cover-image != none {
      place(top + center, dy: 172mm, box(width: 72%, height: 70mm,
        align(center, image(cover-image, fit: "contain", width: 100%, height: 100%))))
    }

    // Metadata block above the mosaic
    #place(bottom + center, dy: -50mm, block(width: 80%)[
      #set align(center)
      #set text(fill: white.transparentize(10%), size: 12pt)
      #if qualification != none [#qualification \ ]
      #if department != none [#department \ ]
      #if campus != none [#campus Campus \ ]
      #if year != none { text(fill: nmu-yellow, weight: "bold")[#year] }
    ])

    // Geometric mosaic band anchored to the bottom edge
    #place(bottom + center, nmu-mosaic(width: 100%, cols: 9, rows: 2))
  ]

  // ---- Front matter / details block ----
  if lecturer != none or qualification != none {
    nmu-callout(title: "Module Information", kind: "info")[
      #if module-name != none [*Module:* #module-name #if module-code != none [(#module-code)] \ ]
      #if qualification != none [*Qualification:* #qualification \ ]
      #if department != none [*Department:* #department \ ]
      #if lecturer != none [*Lecturer:* #lecturer \ ]
      #if campus != none [*Campus:* #campus]
    ]
    v(6pt)
  }

  // ---- Table of contents ----
  show outline.entry.where(level: 1): set text(weight: "bold", fill: nmu-navy)
  outline(title: [Contents], depth: 2, indent: 1em)
  pagebreak()

  body
}
