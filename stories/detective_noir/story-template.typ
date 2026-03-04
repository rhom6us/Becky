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

// Suppress level-1 headings (title); render level-2 as centered italic chapter headers
#show heading.where(level: 1): it => []
#show heading.where(level: 2): it => [
  #v(1.2em)
  #align(center)[#text(size: 11pt, style: "italic", weight: "regular")[#it.body]]
  #v(0.8em)
]

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
  #v(3fr)
  #text(size: 11pt)[Written by Thomas Butler]
  #v(0.3em)
  #text(size: 11pt)[Pictures by Rebecca Stewart]
  #v(0.3em)
  #text(size: 11pt)[Edited by Ruth-Ann Butler]
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
