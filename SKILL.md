---
name: nmu-templates
description: >-
  Create Nelson Mandela University (Faculty of Science) branded documents with
  Quarto + Typst. Use when the user wants to produce an NMU-styled module guide,
  letter, slide deck, research poster, or lecture notes — or asks to write/render
  a .qmd using these templates. Five document types share one `nmu-typst` format,
  selected by a front-matter flag.
---

# NMU Templates (Quarto + Typst)

A single Quarto extension (`_extensions/nmu`) renders five NMU-branded document
types from one `nmu-typst` format. The document type is chosen with a
front-matter **flag**; everything else is shared (colours, fonts, logos, the
geometric mosaic, and callout boxes).

## When to use

Use this skill whenever the user wants an NMU / Faculty of Science document:
a **module guide**, **letter**, **slide deck**, **research poster**, or
**lecture notes** — or asks to create or render a `.qmd` with these templates.

## Prerequisites

- Quarto ≥ 1.5 (bundles Typst). Check the `_extensions/nmu` folder exists in the
  project; if not, copy it from this repo.
- Font **Nunito Sans** installed (default). **Avenir** is optional via
  `brand-font: "avenir"` only if the user has it licensed/installed.

## How to choose the template

| User wants… | Flag in front matter | Function |
|---|---|---|
| Module / learner guide | *(no flag — it's the default)* | `nmu-moduleguide` |
| Formal letter | `letter: true` | `nmu-letter` |
| Presentation slides | `slides: true` | `nmu-slides` |
| Conference / research poster | `poster: true` | `nmu-poster` |
| Lecture notes / handout | `lecture-notes: true` | `nmu-notes` |
| Test / exam / assessment | `assessment: true` | `nmu-assessment` |

Every document needs `format: nmu-typst`.

## Workflow

1. Create a `.qmd` in the project root (where `_extensions/nmu` is reachable).
2. Set `format: nmu-typst` and the correct document-type flag.
3. Fill in the front-matter keys (see below). Write the body in Markdown.
4. Render: `quarto render <file>.qmd` → produces a PDF.
5. To verify visually, rasterise a page:
   `pdftoppm -png -r 90 -f 1 -l 1 <file>.pdf /tmp/preview` and read the PNG.

## Critical rules (avoid common errors)

- **Dates**: never use `date:` — Quarto reformats it to ISO. Use the
  template-specific key: `letter-date`, `slide-date`, or `notes-date`.
- **Notes flag is `lecture-notes:`**, NOT `notes:` (`notes` is reserved by
  Quarto and must be a string).
- **`cover-image` paths** are relative to the `.qmd` and passed verbatim to
  Typst. Put the image in the project and reference it like
  `cover-image: "images/cover.jpg"`.
- **Brand callouts**: use `#nmu-callout(...)` in a `` ```{=typst} `` block for
  branded boxes. Native `::: {.callout-note}` works but is NOT brand-styled.
- Keep colours/logos as-is — do not introduce off-brand colours. Faculty accent
  is Science green `#006b34`; primary navy `#071b2c`; secondary yellow `#ffb81c`.

## Front-matter reference

### Module guide (default)
`title`, `subtitle`, `faculty` (default "Faculty of Science"), `hashtag`
(e.g. `"2026"` → `#2026 AY`), `module-name`, `module-code`, `qualification`,
`department`, `campus`, `lecturer`, `year`, `cover-image` (optional), `brand-font`.

Body helper: `#nmu-section("Title", key: "Assessment", subtitle: "…")` adds a
section header with a matching illustration. Keys: `Module-Info`,
`Lecturer-Information`, `Practical`, `Assessment`, `Resources`, `Feedback`.

### Letter (`letter: true`)
`campus`, `school`, `tel`, `fax`, `email`, `ref`, `contact`, `letter-date`,
`to`, `salutation`, `closing` (default "Kind Regards,"), `signature`,
`signature-title`, `brand-font`. The body is the letter text.

### Slides (`slides: true`)
`title`, `subtitle`, `author`, `institute` (default "Faculty of Science"),
`slide-date`, `aspect` (`"16:9"` | `"4:3"`), `cover-image` (optional),
`brand-font`.
Headings drive slides: `#` = section-divider slide, `##` = content slide.

### Poster (`poster: true`)
`title`, `author`, `affiliation`, `poster-cols` (default 2), `footer-url`
(default "mandela.ac.za"), `brand-font`. 600×900 mm.
Headings: `#` = section header, `##` = subsection.

### Lecture notes (`lecture-notes: true`)
`title`, `subtitle`, `author`, `notes-date`, `module-code`, `toc` (bool),
`brand-font`.

### Assessment / test / exam (`assessment: true`)
`title`, `module-name`, `module-code`, `examiner`, `duration`,
`assessment-date`, `total-marks` (optional — auto-summed if omitted),
`instructions`, `solutions` (bool), `brand-font`.
Write questions in `` ```{=typst} `` blocks:
- `#question(marks)[ … #solution[ … ] ]` — auto-numbered, adds to total.
- `#question(none)[ … ]` — when the parts carry the marks (no double-count).
- `#part(marks)[ … ]` — lettered (a),(b),… within a question.
- `#solution[ … ]` — shown only when `solutions: true`.
Total marks are auto-computed. Set `solutions: false` for the question paper,
`true` for the memorandum.

## Callouts

```typst
#nmu-callout(title: "Heading", kind: "note")[ Body, supports math: $x^2$. ]
```
`kind`: `info`/`note` (navy), `tip` (green), `warning` (amber).

## Minimal examples

Slides:
```yaml
---
slides: true
format: nmu-typst
title: "Introduction to Statistics"
subtitle: "Sampling Distributions"
author: "S. Janse van Rensburg"
slide-date: "Semester 1, 2026"
aspect: "16:9"
---

# Foundations

## What is a sampling distribution?

- Point one
- Point two
```

Letter:
```yaml
---
letter: true
format: nmu-typst
campus: "Gqeberha Campus"
school: "Department of Statistics, Faculty of Science"
email: "stats@mandela.ac.za"
letter-date: "24 June 2026"
salutation: "Dear Colleague,"
signature: "S. Janse van Rensburg"
signature-title: "Lecturer, Department of Statistics"
---

Body of the letter goes here.
```

See `README.md` for the full option reference and the demo files
(`module-guide.qmd`, `letter.qmd`, `slides.qmd`, `poster.qmd`, `notes.qmd`).
