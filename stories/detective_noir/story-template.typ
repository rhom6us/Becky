// story-template.typ
// 5.5 × 8.5 in booklet, sans-serif 16pt
// Gutter on inside edge; page numbers top outside; cover + blank verso

// Pandoc-generated elements
#let horizontalrule = block(width: 100%, height: 0pt, above: 1.5em, below: 1.5em)[
  #line(start: (20%, 0%), end: (80%, 0%), stroke: 0.5pt + luma(160))
]

#set text(font: ("Calibri", "Segoe UI", "Arial"), size: 14pt)
#set par(leading: 0.9em, spacing: 1.4em)
#set image(width: 100%)

// Suppress headings — cover page handles title/subtitle
#show heading: it => []

// Suppress figure captions — show image only
#show figure.where(kind: image): it => {
  v(0.5em)
  align(center, block(width: 90%, it.body))
  v(0.5em)
}

// === COVER PAGE ===
#set page(
  width: 5.5in,
  height: 8.5in,
  margin: (x: 0.75in, y: 1in),
  header: none,
  footer: none,
  numbering: none,
)

#align(center + horizon)[
  #v(1fr)
  #text(size: 42pt, weight: "bold", tracking: 1pt)[Forty Seconds]
  #v(0.4em)
  #text(size: 20pt, style: "italic", weight: "regular")[A Detective Noir]
  #v(3fr)
  #text(size: 13pt)[Thomas Butler]
  #v(0.6em)
  #text(size: 10pt, fill: luma(120))[© Thomas Butler. All rights reserved.]
  #v(1fr)
]

// === BLANK VERSO (back of cover) ===
#pagebreak()
#align(center + horizon)[]
#pagebreak()

// === STORY PAGES ===
#set page(
  width: 5.5in,
  height: 8.5in,
  margin: (inside: 1in, outside: 0.5in, top: 0.75in, bottom: 0.5in),
  header: context {
    let p = here().page()
    if p > 2 {
      if calc.odd(p) {
        align(right, text(size: 10pt, fill: luma(100))[#p])
      } else {
        align(left, text(size: 10pt, fill: luma(100))[#p])
      }
    }
  },
  footer: none,
  numbering: none,
)

$body$
