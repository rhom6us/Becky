# Proofread Report 2 — *Forty Seconds*

**Author:** Thomas Butler
**Proofreader:** Stage 4 (Second Proofread Pass)
**Date:** 2026-03-03
**Draft reviewed:** `stories/detective_noir/forty_seconds.md` (post-first-proofread version)
**Preceding report:** `stories/detective_noir/reports/proofread-report.md` (2026-03-02, zero errors found)

---

## Scope

This pass was conducted against the instructions to catch only hard errors: spelling mistakes, missing or doubled words, punctuation errors, broken markdown, incorrect image paths, and anything that would appear as a defect in the final rendered output.

Items confirmed intentional in the prior proofread and the session handoff (`CLAUDE.md`) were not re-examined for style. The prior proofread's zero-error certification was taken as a baseline; this report covers only new findings not present in that report.

Two sequential passes were performed:

1. **Pass 1:** Full read-through, word by word, with attention to spelling, punctuation, broken markdown, and image paths.
2. **Pass 2:** Targeted mechanical checks — footnote reference/definition parity, doubled words, dash character consistency, heading hierarchy, quote character consistency.

---

## Errors Found: 0

| # | Location | Error | Correction |
|---|----------|-------|------------|
| — | — | *None* | — |

---

## Mechanical Checks Performed

### Spelling
No misspellings detected. All Commonwealth spellings (grey, recognise, revelling, afterwards) confirmed consistent.

### Doubled words
Script check for adjacent identical words returned no errors. All apparent duplications are intentional: "this. This" and "one. One" (sentence-initial repetitions for rhythm), "anything — anything" (emphatic repetition), footnote key/value matches.

### Missing or dropped words
None detected.

### Image paths
All eight images verified. Paths use `../../images/600-ice-4800X.jpg` format throughout, resolving correctly relative to `stories/detective_noir/forty_seconds.md`. All alt-text strings are present and non-empty. Images appear in story order matching the image-role table in `CLAUDE.md`:

| Line | Path | Role |
|------|------|------|
| 8 | `600-ice-48005.jpg` | Francois at bedpost |
| 22 | `600-ice-48006.jpg` | Vivian face down |
| 60 | `600-ice-48004.jpg` | Tom fist to chin |
| 90 | `600-ice-48002.jpg` | Boombox |
| 110 | `600-ice-48007.jpg` | Strangling |
| 144 | `600-ice-48003.jpg` | Scissors |
| 152 | `600-ice-48001.jpg` | Tom screaming |
| 220 | `600-ice-48000.jpg` | Francois under blanket |

All eight images (`600-ice-48000.jpg` through `600-ice-48007.jpg`) confirmed present on disk and referenced exactly once each.

### Footnotes
Six footnote definitions present (`[^angels]`, `[^staring]`, `[^wake]`, `[^discotheque]`, `[^gone]`, `[^lastnight]`). All definitions have at least one corresponding in-body reference. `[^staring]` is referenced three times (lines 46, 188, 202) and `[^gone]` three times (lines 108, 150, 164) — valid in Markdown; a single definition may be referenced multiple times. No orphaned definitions, no missing definitions. Accent preserved in `Discothèque` (footnote key is correctly ASCII `discotheque`; displayed text carries the accent).

### Punctuation
Em-dashes (U+2014) used consistently for interruptions and asides. No double-hyphens used in place of em-dashes. Hyphens used only in compound constructions. Quote characters are straight ASCII (`"` and `'`) throughout — consistent across the entire document.

### Dialogue formatting
Italicised dialogue pattern `*"..."*` applied consistently throughout. No instances found of unmatched asterisks, unclosed italics, or mixed formatting within a dialogue span.

### Markdown structure
Section breaks use `---` throughout. No stray formatting characters detected. Bold used only for the title (`# **Forty Seconds**`) and the sign-off (`**— FIN —**`). Epilogue lines correctly italicised. Credits correctly italicised.

### Heading hierarchy
The subtitle on line 2 uses `###` (H3) directly under `#` (H1), skipping H2. This was present and unchallenged in the prior proofread. In standard Markdown linting this constitutes a hierarchy violation; however, since the story renders via a custom Typst template that controls heading styles directly, and since the prior proofread certified the formatting as compliant, this is noted for the record but not raised as a new error requiring correction. If the template maps heading levels to semantic styles, the author may wish to confirm the subtitle renders as intended in the PDF output.

---

## Intentional Choices Confirmed (Not Flagged)

All elements confirmed in prior editorial stages remain correctly preserved:

- "deeply, fundamentally wrong" — retained
- Italicised dialogue throughout
- Sentence fragments
- Third-person slip: "Francois deserves that much"
- Present-tense general-truth statements: "That's how it always started," "a corrupted mind cannot abide a witness"
- Lyric-bleed lines at all nine footnoted positions
- Second-person intrusion: "by the slight wrongness of it against your fingers"
- "Something moved behind Francois's eyes" closing beat
- Epilogue in final form

---

## Outstanding Queries

None.

---

## Proofread Certification

**Total new errors found:** 0

**Queries for author:** 0

**Formatting compliance:** Verified

**Mechanical accuracy:** Verified

**Date:** 2026-03-03

**Status:** Ready for publication — no corrections required.
