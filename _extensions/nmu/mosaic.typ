// Bauhaus-style geometric mosaic band, recreated natively in Typst.
// Mirrors the tile band on the NMU Faculty of Science module-guide cover.
#import "brand.typ": nmu-navy, nmu-yellow, nmu-science, nmu-grey

// A single square tile, clipped. `m` selects the motif (0..9),
// `a` is the background fill, `b` the foreground fill.
#let nmu-tile(s, m, a, b) = box(width: s, height: s, fill: a, clip: true)[
  #let q = s / 2
  #if m == 0 {
    // diagonal split into two triangles
    place(top + left, polygon(fill: b, (0pt, 0pt), (s, 0pt), (0pt, s)))
  } else if m == 1 {
    // quarter circle in corner
    place(top + left, dx: -q, dy: -q, circle(radius: s, fill: b))
  } else if m == 2 {
    // half circle on bottom edge
    place(bottom + center, dy: q, circle(radius: q, fill: b))
  } else if m == 3 {
    // centred full circle
    place(center + horizon, circle(radius: q * 0.8, fill: b))
  } else if m == 4 {
    // concentric diamond + dot (the NMU logo motif)
    place(center + horizon, rotate(45deg, square(size: s * 0.62, fill: b)))
    place(center + horizon, circle(radius: q * 0.28, fill: nmu-yellow))
  } else if m == 5 {
    // 3x3 checkerboard
    for r in range(3) {
      for c in range(3) {
        if calc.rem(r + c, 2) == 0 {
          place(top + left, dx: c * s / 3, dy: r * s / 3,
            rect(width: s / 3, height: s / 3, fill: b))
        }
      }
    }
  } else if m == 6 {
    // upward triangle
    place(bottom + center, polygon(fill: b, (0pt, 0pt), (q, -s), (s, 0pt)))
  } else if m == 7 {
    // polka dots
    for r in range(3) {
      for c in range(3) {
        place(top + left, dx: c * s / 3 + s / 12, dy: r * s / 3 + s / 12,
          circle(radius: s / 12, fill: b))
      }
    }
  } else if m == 8 {
    // two opposing quarter circles
    place(top + left, dx: -q, dy: -q, circle(radius: s, fill: b))
    place(bottom + right, dx: q, dy: q, circle(radius: s, fill: b))
  } else {
    // circle on triangle
    place(bottom + center, polygon(fill: b, (0pt, 0pt), (q, -s), (s, 0pt)))
    place(top + center, dy: q * 0.4, circle(radius: q * 0.45, fill: nmu-yellow))
  }
]

// Deterministic mosaic band: `cols` wide, `rows` tall, total width `width`.
// `faint` renders a pale tint-on-white version for interior pages.
#let nmu-mosaic(width: 100%, cols: 9, rows: 3, faint: false) = context {
  let pal = if faint {
    (white, rgb("#eef3ee"), rgb("#fbf3da"), rgb("#eef1f4"))
  } else {
    (nmu-navy, nmu-science, nmu-yellow, white)
  }
  // resolve the ratio/length to a concrete width via layout
  block(width: width, layout(size => {
    let total = size.width
    let s = total / cols
    // fixed pseudo-pattern so the band looks lively but reproducible
    let motifs = (0,1,2,3,4,5,6,7,8,9)
    stack(dir: ttb,
      ..range(rows).map(r => stack(dir: ltr,
        ..range(cols).map(c => {
          let i = calc.rem(r * 7 + c * 3 + 1, 10)
          let j = calc.rem(c * 5 + r * 2, 4)
          let k = calc.rem(c * 3 + r + 1, 4)
          nmu-tile(s, i, pal.at(j), pal.at(k))
        })
      ))
    )
  }))
}
