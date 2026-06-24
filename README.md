# qmdNMU

Quarto + Typst document templates styled in the Nelson Mandela University
(Faculty of Science) brand. **Unofficial** — built for the Statistics
Department.

One Quarto extension (`_extensions/nmu`) provides five document types from a
single `nmu-typst` format. You pick the document type with a front-matter flag;
everything shares one brand layer (colours, fonts, logos, the geometric mosaic,
and callouts).

| Document type | Front-matter flag | Demo file |
|---|---|---|
| Module guide | *(default — no flag)* | `module-guide.qmd` |
| Letter | `letter: true` | `letter.qmd` |
| Slides (16:9 / 4:3) | `slides: true` | `slides.qmd` |
| Research poster (600×900 mm) | `poster: true` | `poster.qmd` |
| Lecture notes | `lecture-notes: true` | `notes.qmd` |
| Assessment (test / exam) | `assessment: true` | `assessment.qmd` |

## Requirements

- **Quarto ≥ 1.5** (bundles the Typst compiler — no separate install needed).
- **Nunito Sans** font (free, on Google Fonts) — the brand's sanctioned digital
  font and the default here. Optionally **Avenir** (the print brand font, if you
  have it licensed) via `brand-font: "avenir"`.

Render any document with:

```bash
quarto render module-guide.qmd
```

## Common options (all templates)

| Key | Values | Default | Notes |
|---|---|---|---|
| `format` | `nmu-typst` | — | **Required.** Selects the extension. |
| `brand-font` | `"nunito"` \| `"avenir"` | `"nunito"` | `"avenir"` only if installed locally. |
| `title` | string | — | Used by every template. |

> **Dates:** use the template-specific date key (`letter-date`, `slide-date`,
> `notes-date`), **not** `date:` — Quarto reformats a plain `date` to ISO.

---

## Module guide *(default)*

The richest template: a full navy cover (logo, faculty band, title, hashtag,
metadata, geometric mosaic), a table of contents, then the body.

| Key | Type | Description |
|---|---|---|
| `title` | string | Cover title (e.g. "Module Guide"). |
| `subtitle` | string | Optional. |
| `faculty` | string | Yellow cover band text. Default "Faculty of Science". |
| `hashtag` | string | Cover hashtag tail, e.g. `"2026"` → renders `#2026 AY`. |
| `module-name` | string | Large yellow cover line. |
| `module-code` | string | e.g. "STA101". |
| `qualification` | string | e.g. "BSc (Mathematical Sciences)". |
| `department` | string | |
| `campus` | string | "Gqeberha", etc. (rendered as "… Campus"). |
| `lecturer` | string | |
| `year` | string | |
| `cover-image` | path | Optional. Your own image, centred on the cover above the mosaic. Omit to keep the plain branded cover. Path is relative to the `.qmd`. |

**Body helpers** (in ```` ```{=typst} ```` blocks):

- `#nmu-section("Title", key: "Assessment", subtitle: "…")` — a section header
  with a matching brand illustration. Valid `key` values:
  `Module-Info`, `Lecturer-Information`, `Practical`, `Assessment`,
  `Resources`, `Feedback`.
- `#nmu-callout(title: "…", kind: "note")[ … ]` — see [Callouts](#callouts).

---

## Letter

Mirrors the Brand Manual letterhead (centred logo, sender block top-right,
"Change the World" + address footer; margins T35/B15/L20/R20 mm). The letter
body is the Markdown content.

| Key | Type | Description |
|---|---|---|
| `letter: true` | flag | Selects this template. |
| `campus` | string | Sender block (top-right). |
| `school` | string | Department / school / faculty line. |
| `tel` | string | |
| `fax` | string | |
| `email` | string | Rendered as a mailto link. |
| `ref` | string | "Ref:" line. |
| `contact` | string | "Contact person:" line. |
| `letter-date` | string | Free-text date, e.g. "24 June 2026". |
| `to` | string | Optional recipient block. |
| `salutation` | string | e.g. "Dear Dr Smith,". |
| `closing` | string | Default "Kind Regards,". |
| `signature` | string | Bold name under the closing. |
| `signature-title` | string | Grey line under the signature. |

The footer slogan ("Change the World") and physical address use brand defaults
(set in `_extensions/nmu/typst-template.typ` if you need to change them).

---

## Slides

Mirrors the Faculty of Science PowerPoint deck. Slides are driven by headings:

- `#` (level 1) → **section-divider** slide (navy, African pattern strip).
- `##` (level 2) → **content** slide (navy title, green underline, footer).

| Key | Type | Description |
|---|---|---|
| `slides: true` | flag | Selects this template. |
| `title` | string | Title slide. |
| `subtitle` | string | Yellow line on the title slide. |
| `author` | string | |
| `institute` | string | Default "Faculty of Science". |
| `slide-date` | string | Free-text date. |
| `aspect` | `"16:9"` \| `"4:3"` | Default `"16:9"`. |
| `cover-image` | path | Optional. Your own image for the title-slide band (fit within the band area). Omit to use the default Faculty of Science imagery. Path is relative to the `.qmd`. |

---

## Research poster

A single 600×900 mm (2:3 portrait) page: navy header band with the logo, a
multi-column white body, and a navy footer (slogan + URL). Headings:

- `#` (level 1) → **section header** (navy, green rule).
- `##` (level 2) → **subsection** (green).

| Key | Type | Description |
|---|---|---|
| `poster: true` | flag | Selects this template. |
| `title` | string | Poster title (above the columns). |
| `author` | string | |
| `affiliation` | string | Green line under the authors. |
| `poster-cols` | integer | Body columns. Default `2`. |
| `footer-url` | string | Yellow URL, bottom-right. Default "mandela.ac.za". |

---

## Lecture notes

Between the plain academic notes and the module guide: a compact branded title
header (logo + green accent rule), optional contents, numbered sections, and
branded callouts. No cover page.

| Key | Type | Description |
|---|---|---|
| `lecture-notes: true` | flag | Selects this template. **Use this key — `notes:` is reserved by Quarto.** |
| `title` | string | |
| `subtitle` | string | Green line (e.g. "Lecture Notes"). |
| `author` | string | |
| `notes-date` | string | Free-text date. |
| `module-code` | string | Shown in the footer (e.g. "STA321"). |
| `toc` | boolean | Include a table of contents. Default `false`. |

---

## Assessment (test / exam)

A branded test/exam paper with an auto-computed mark total and a `solutions`
toggle that shows or hides the memorandum.

| Key | Type | Description |
|---|---|---|
| `assessment: true` | flag | Selects this template. |
| `title` | string | e.g. "Class Test 2". |
| `module-name` | string | |
| `module-code` | string | Shown in the header and footer. |
| `examiner` | string | |
| `duration` | string | e.g. "90 minutes". |
| `assessment-date` | string | Free-text date. |
| `total-marks` | string | Optional override; omit to auto-sum from the questions. |
| `instructions` | string | Shown in a callout below the info bar. |
| `solutions` | boolean | `true` → memorandum (answers shown); `false` → question paper. |

**Question / mark helpers** (in ```` ```{=typst} ```` blocks):

```typst
#question(10)[
  Question text.
  #solution[ Answer shown only when `solutions: true`. ]
]

#question(none)[          // use none when the parts carry the marks
  Intro to a multi-part question.
  #part(4)[ First part. #solution[ … ] ]
  #part(4)[ Second part. #solution[ … ] ]
]
```

- `#question(marks)[…]` — auto-numbered; adds `marks` to the total. Pass `none`
  when the parts carry the marks (avoids double-counting).
- `#part(marks)[…]` — lettered (a), (b), … within the question; adds to the total.
- `#solution[…]` — rendered only when `solutions: true`.

The header's **Total marks** is computed automatically from all `question`/`part`
marks (unless you set `total-marks`).

## Callouts

Available in every template via a ```` ```{=typst} ```` block. Each renders a
header bar (accent colour, white/navy title) over a light tinted body.

```typst
#nmu-callout(title: "The Gauss–Markov Assumptions", kind: "note")[
  Body content here. Supports Typst markup and math: $E[epsilon_i | bold(X)] = 0$.
]
```

| `kind` | Bar colour |
|---|---|
| `info` / `note` | Navy |
| `tip` | Science green |
| `warning` | Amber (navy title) |

You can also use Quarto's native `::: {.callout-note}` blocks, but those render
in Quarto's default (non-brand) style — prefer `#nmu-callout` for brand
consistency.

## Multiple authors

`author` accepts a list; it is rendered comma-separated:

```yaml
author:
  - "S. Janse van Rensburg"
  - "A. N. Other"
```

## Project layout

```
_extensions/nmu/
  _extension.yml        format definition + bundled resources
  typst-template.typ    document functions (one per template)
  typst-show.typ        dispatches on the front-matter flag
  brand.typ             colours, fonts, logos, callouts (shared)
  mosaic.typ            geometric mosaic / pattern strip (shared)
  assets/               logos and illustrations
```
