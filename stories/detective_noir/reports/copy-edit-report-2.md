# Copy Edit Report 2 — *Forty Seconds*

**Author:** Thomas Butler
**Editor:** Stage 3, Pass 2 (Second Copy Edit)
**Date:** 2026-03-03
**Draft reviewed:** `stories/detective_noir/forty_seconds.md` (post-CE-1 version)
**Preceding stages:** Dev edit, line edit (×2), copy edit pass 1 (copy-edit-report.md)
**Style guide:** Chicago Manual of Style, 18th edition

---

## Summary

The manuscript arrived from the first copy edit in clean condition. Pass 1 applied one correction (CE-01: space before closing quote in interrupted dialogue) and raised one open query (CE-QUERY-01: "feels," present tense). This second pass identified two genuine mechanical errors not caught in pass 1, and raises four queries.

### Corrections Identified

| ID | Type | Location | Status |
|---|---|---|---|
| CE2-01 | Pronoun (who/that for persons) | Line 38 | Recommended correction |
| CE2-02 | Spelling (Commonwealth convention) | Line 192 | Recommended correction |

### Open Queries

| ID | Type | Location |
|---|---|---|
| CE2-QUERY-01 | Counting inconsistency ("two" / three items) | Line 58 |
| CE2-QUERY-02 | Physical action ambiguity (boombox tray) | Line 84 |
| CE2-QUERY-03 | Present-tense general-truth statement not in style sheet | Line 92 |
| CE2-QUERY-04 | Footnote definition order (organisational note) | End of file |

---

## Corrections

### CE2-01: "that" used for persons where "who" is required (line 38)

**Location:** Paragraph beginning "Tom didn't answer that..."

**Text as written:**
> The ones who could still talk afterwards struggled to describe the before and after. The ones who couldn't talk anymore were **the ones that** kept Tom up at night.

"Who" is used for persons throughout this sentence and the preceding one. The predicate complement "the ones that kept Tom up at night" switches to "that," inconsistent with the same construction earlier in the sentence ("The ones who couldn't talk anymore") and with standard CMOS usage for persons (CMOS 5.64).

**Recommended correction:**

> The ones who couldn't talk anymore were **the ones who** kept Tom up at night.

---

### CE2-02: "reveling" — spelling inconsistent with established Commonwealth convention (line 192)

**Location:** Paragraph beginning "The corruption, reveling to the end."

**Text as written:**
> The corruption, **reveling** to the end.

The manuscript uses Commonwealth spellings throughout: "grey" (×5), "recognise" (×1), "afterwards" (×1). These were confirmed in the pass-1 style sheet. In Commonwealth English, "revel" doubles the final consonant before a vowel suffix: "revelling," "revelled." The American form "reveling" is inconsistent with the manuscript's spelling convention.

**Recommended correction:**

> The corruption, **revelling** to the end.

---

## Author Queries

### CE2-QUERY-01: Three items enumerated after "Two alarm systems" (line 58)

**Location:** Paragraph beginning "Tom sat with his fist pressed hard against his chin..."

**Text:**
> Two alarm systems going off at once. The instinct. The rumors. The shape of the thing.

Three items are listed after the phrase "Two alarm systems." In the corridor scene (lines 200–201), the same construction is used correctly: "The instinct. The rumors. Two alarm systems, both going off at once." — two items, two alarm systems, exactly matched.

In the hiring scene (line 58), "The shape of the thing" appears as a third item. If it is meant as a third alarm system, "Two" is incorrect. If it is meant as a separate, trailing observation distinct from the two named alarm systems, the sentence is ambiguous — a reader may count three alarm systems on first pass.

[CE2-QUERY-01: Is "The shape of the thing" a third alarm system (in which case "Two" should be "Three"), or a separate thought appended after the two named systems? If the latter, consider a dash or "And" to signal the separation: e.g., "Two alarm systems going off at once. The instinct. The rumors. And the shape of the thing." Alternatively, confirm as intentionally ambiguous and add to the style sheet.]

---

### CE2-QUERY-02: Physical action ambiguity — "pressed stop, closed the tray" (line 84)

**Location:** Paragraph beginning "He listened for forty seconds."

**Text:**
> He listened for forty seconds. Then he pressed stop, **closed the tray**, and stood very still for a long moment.

On most boomboxes, pressing "stop" leaves the CD tray closed. The tray opens when "eject" is pressed. "Closed the tray" implies the tray was open — either because he had opened it (no prior mention), or because pressing stop on this particular device opened it.

This is a minor factual ambiguity, not a grammatical error. It may pass unnoticed, but a reader who visualises the action step by step may pause.

[CE2-QUERY-02: Does "closed the tray" reflect a specific boombox behaviour, or should the sequence be adjusted? One option: "pressed stop, eject, closed the tray." Another: omit "closed the tray" entirely, as it is not load-bearing. Confirm or revise as preferred.]

---

### CE2-QUERY-03: Present-tense general-truth statement not recorded in style sheet (line 92)

**Location:** Paragraph beginning "The picture became clear."

**Text:**
> **That's how it always started.** Just once.

"That's" (= "That is") is present tense within past-tense narration. The pass-1 style sheet records two present-tense exceptions: "cannot abide a witness" (line 94, locked as intentional general-truth statement) and "feels" (line 6, queried as CE-QUERY-01 pending author confirmation). This is a third instance of the same construction, one sentence before the locked exception, and was not noted in pass 1.

It reads naturally as indirect free thought in Tom's voice (a general truth about how the corruption spreads), consistent in register with "cannot abide a witness." However, since the pattern is being tracked for the proofreader, it should be confirmed and added to the style sheet if intentional.

[CE2-QUERY-03: Is "That's how it always started" intentional (general-truth present tense / indirect free thought), in parallel with "cannot abide a witness"? If confirmed, please add to the style sheet so the proofreader does not flag it. Suggested style-sheet addition: "That's how it always started" (line 92) — present tense, general-truth statement; locked.]

---

### CE2-QUERY-04: Footnote definitions not in first-appearance order (end of file)

**Location:** Lines 242–247 (footnote definitions block)

**Current definition order:**

```
[^discotheque]: Discothèque
[^angels]: If God Will Send His Angels
[^staring]: Staring at the Sun
[^wake]: Wake Up Dead Man
[^gone]: Gone
[^lastnight]: Last Night on Earth
```

**First-appearance order in text:**

1. `[^angels]` — line 44
2. `[^staring]` — line 46
3. `[^wake]` — line 46
4. `[^discotheque]` — line 72
5. `[^gone]` — line 108
6. `[^lastnight]` — line 116

Pandoc numbers footnotes by order of first appearance in the text, not by definition order. The rendered output will therefore be correctly numbered regardless of how the definitions are sequenced at the bottom of the file. This is not a functional error.

However, the current definition order (Discothèque first) does not match either first-appearance order or alphabetical order, which could cause confusion during future manual review or when checking footnote content against the text.

[CE2-QUERY-04: No action required for the rendered output. Consider reordering definitions to match first-appearance order for readability of the source file. Optional.]

---

## Consistency Pass — No New Issues Found

The following were re-checked against the pass-1 style sheet and confirmed consistent:

- **Character names:** Francois (no cedilla; possessive Francois's), Vivian Plume, PI Tom — consistent throughout
- **"boombox":** one word, lowercase, five appearances — consistent
- **"grey":** Commonwealth spelling, five appearances — consistent
- **"recognise":** Commonwealth spelling, one appearance — consistent
- **"afterwards":** Commonwealth spelling, one appearance — consistent
- **Numbers:** all under 100 spelled out — consistent
- **Dialogue mechanics:** italics + quotation marks, lowercase tags, new speaker = new paragraph — consistent
- **Em dashes:** no spaces around em dashes throughout — consistent
- **Interrupted dialogue:** em dash flush against closing quote mark — confirmed (CE-01 from pass 1 applied correctly; line 46 reads `*"Don't —"*`)
- **Image references:** all eight images present, correct filenames (600-ice-48000 through 600-ice-48007), alt text present on all — confirmed
- **Section breaks:** `---` throughout — consistent
- **Epilogue:** four italic lines plus `**— FIN —**` — consistent
- **Footnote content:** all six footnote definitions checked against CLAUDE.md lyric table — correct
- **`[^gone]` used at three positions** (lines 108, 150, 164): all three correctly cite "Gone" per lyric-bleed table — confirmed
- **`[^staring]` used at three positions** (lines 46, 188, 202): all three correctly cite "Staring at the Sun" per lyric-bleed table — confirmed
- **Timeline:** Monday (discovery) → same day or next (Tom hired) → three days (investigation) → confrontation/fight/aftermath → "some time later" (observation room) → Wednesday (burial) — no contradictions

**CE-QUERY-01 from pass 1 (status: pending):** "feels" (line 6) remains unresolved pending author confirmation. Not re-queried here. Add to style sheet once confirmed.

---

## Updated Style Sheet Additions (Pending Confirmation)

The following items should be added to the pass-1 style sheet once author confirms:

| Item | Location | Note |
|---|---|---|
| "That's how it always started" | Line 92 | Present-tense general-truth / indirect free thought; parallel to "cannot abide a witness" |
| "revelling" (corrected from "reveling") | Line 192 | Commonwealth convention; corrected in CE2-02 |

---

*Second copy edit complete. Manuscript ready for proofreader pending resolution of CE-QUERY-01 (pass 1) and CE2-QUERY-01 through CE2-QUERY-03 (this pass).*
