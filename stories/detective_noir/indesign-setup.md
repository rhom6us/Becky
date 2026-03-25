# InDesign Setup Guide — Forty Seconds

Research compiled for setting up a professional novel/novella in Adobe InDesign 2026, specifically for the *Forty Seconds* detective noir booklet (5.5 × 8.5", saddle-stitched, ~44 pages).

---

## 1. Document Setup

| Setting | Value | Notes |
|---------|-------|-------|
| **Intent** | Print | |
| **Facing Pages** | Yes | Creates mirrored Inside/Outside margins |
| **Primary Text Frame** | Yes | Auto-creates threaded text frames on master pages |
| **Page Size** | 5.5" × 8.5" | Trim size = document page size |
| **Orientation** | Portrait | |
| **Columns** | 1 | Standard for novels |
| **Inside Margin** | 0.75" | Combined spine (0.5") + gutter (0.25") |
| **Outside Margin** | 0.625" | ~0.5" remains after ~1/8" edge trim |
| **Top Margin** | 0.5" | Below running header/page number |
| **Bottom Margin** | 0.625" | Slightly deeper for visual balance |
| **Bleed** | 0.125" top/bottom/outside, 0" inside | Only needed for full-bleed images |
| **Slug** | 0" | Not needed for home printing |

**Preferences to set:**
- Units: Inches (Edit > Preferences > Units & Increments)
- Smart Text Reflow: Enabled, add pages at End of Story, limit to Primary Text Frames, delete empty pages
- Composition: Enable H&J Violations highlighting

---

## 2. Master Pages

| Master | Name | Purpose | Elements |
|--------|------|---------|----------|
| **A-Body** | Body Text | Standard story/back-matter pages | Primary text frame, page number (top outside edge) |
| **B-Chapter** | Chapter Opener | First page of each chapter | Primary text frame offset ~3" from top, NO page number |
| **C-FrontMatter** | Front Matter | Display pages (half title, title, dedication, etc.) | Text frame(s) for display text, NO page number |
| **D-Blank** | Blank | Intentionally blank pages | Empty — no elements |
| **E-FullImage** | Full-Page Image | Pages with a full-page photograph | Image frame filling page to bleed, no text, no page number |
| **[None]** | No Master | Unique pages needing custom layout | |

**Page numbers:** Type > Insert Special Character > Markers > Current Page Number, placed in a text frame at the top outside corner of A-Body master.

---

## 3. Paragraph Styles

### Body Styles

| Style | Based On | Font | Size | Leading | Align | 1st Indent | Space B/A | Keep | Next Style |
|-------|----------|------|------|---------|-------|------------|-----------|------|------------|
| **Body Text** | — | Garamond | 14pt | Multiple 1.1 (≈15.4pt) | Justify, last left | 16pt | 0 / 0 | First 2, last 2 | Body Text |
| **Body First** | Body Text | — | — | — | — | 0 | 0 / 0 | — | Body Text |
| **Body After Break** | Body First | — | — | — | — | 0 | 0 / 0 | — | Body Text |

### Chapter & Section Styles

| Style | Based On | Font | Size | Align | Space B/A | Keep | Next Style | Other |
|-------|----------|------|------|-------|-----------|------|------------|-------|
| **Chapter Number** | — | EB Garamond | 36pt | Left | 16pt / 120pt | Start on next odd page | Body First | 0.5pt bottom border |
| **Section Header** | — | Garamond | 16pt | Center | 0 / 0 | — | Body Text | Base for front/back matter headers |
| **Scene Break** | Body Text | — | — | Center | 12pt / 12pt | — | Body After Break | Used for `---` section breaks |

### Front Matter Styles

| Style | Based On | Font | Size | Style | Align | Space B/A | Other |
|-------|----------|------|------|-------|-------|-----------|-------|
| **Half Title** | Section Header | — | 28pt | — | Center | — | |
| **Title Author** | Section Header | — | 16pt | — | Center | 18pt / 0 | |
| **Title Photo Credit** | Section Header | — | 12pt | Italic | Center | 12pt / 0 | |
| **Publisher** | Section Header | — | 10pt | — | Center | — | Anchored to page bottom |
| **Dedication** | Section Header | — | 14pt | Italic | Center | — | |
| **Epigraph Quote** | Section Header | — | 12pt | Italic | Center | Exactly 16pt leading | |
| **Epigraph Attribution** | Section Header | — | 10pt | — | Center | 6pt / 0 | |
| **Also By Category** | Section Header | — | 11pt | Bold | Center | 12pt / 4pt | |
| **Also By Title** | Section Header | — | 11pt | Italic | Center | 4pt / 4pt | Exactly 15pt leading |
| **Also By Annotation** | Section Header | — | 9pt | — | Center | — | |
| **Copyright** | — | Garamond | 9pt | — | Left | Exactly 12pt leading | 6pt / 6pt |
| **Blurb Quote** | — | Garamond | 11pt | Italic | Justify | Exactly 15pt leading | 12pt / 0 |
| **Blurb Attribution** | Blurb Quote | — | 10pt | Regular | — | 4pt / 0 | |

### Back Matter Styles

| Style | Based On | Font | Size | Align | Leading | Space B/A |
|-------|----------|------|------|-------|---------|-----------|
| **Permissions Lyric** | Blurb Quote | — | 11pt | — | Exactly 15pt | 10pt / 0 |
| **Permissions Attribution** | — | Garamond | 10pt | Left | Exactly 14pt | 2pt / 6pt |
| **About Author** | — | Garamond | 11pt | Justify | Exactly 15pt | — |
| **Colophon** | — | Garamond | 10pt | Left | Exactly 14pt | — |
| **Page Number** | — | Garamond | 9pt | — | — | Header, outside edge |

### Character Styles

| Style | Attributes |
|-------|-----------|
| **Emphasis** | Italic |

---

## 4. Page Numbering

| Section | Style | Visible? | Start At |
|---------|-------|----------|----------|
| **Front matter** (pp. 1–10) | Hidden | No | — |
| **Body text** (pp. 11+) | Arabic | Yes (except chapter openers) | 11 |
| **Back matter** (pp. 91+) | Arabic, continuing | Yes | Continues |

Implementation: Use Numbering & Section Options (right-click page in Pages panel) to create section breaks at page 11.

---

## 5. Front Matter Order (This Book)

| Page | Content | Master | Page Number |
|------|---------|--------|-------------|
| 01 (recto) | Advance Praise | C-FrontMatter | No |
| 02 (verso) | Praise overflow | C-FrontMatter | No |
| 03 (recto) | Half Title | C-FrontMatter | No |
| 04 (verso) | Also By | C-FrontMatter | No |
| 05 (recto) | Title Page | C-FrontMatter | No |
| 06 (verso) | Copyright | C-FrontMatter | No |
| 07 (recto) | Dedication | C-FrontMatter | No |
| 08 (verso) | Blank | D-Blank | No |
| 09 (recto) | Epigraph | C-FrontMatter | No |
| 10 (verso) | Blank | D-Blank | No |

---

## 6. Back Matter Order (This Book)

| Page | Content | Master | Page Number |
|------|---------|--------|-------------|
| 91 (recto) | Acknowledgements | A-Body | Yes |
| 92 (verso) | Blank | D-Blank | No |
| 93 (recto) | Permissions | A-Body | Yes |
| 94 (verso) | Permissions overflow | A-Body | Yes |
| 95 (recto) | About the Author | A-Body | Yes |
| 96 (verso) | Blank | D-Blank | No |
| 97 (recto) | Colophon | A-Body | Yes |

---

## 7. Typography Best Practices

### Justification Settings

| Parameter | Minimum | Desired | Maximum |
|-----------|---------|---------|---------|
| **Word Spacing** | 85% | 100% | 130% |
| **Letter Spacing** | -3% | 0% | 3% |
| **Glyph Scaling** | 97% | 100% | 103% |

Use **Adobe Paragraph Composer** (not Single-Line).

### Hyphenation Settings

| Setting | Value |
|---------|-------|
| Hyphenate | On |
| Words with at least | 6 letters |
| After first | 3 letters |
| Before last | 3 letters |
| Hyphen limit | 2 |
| Hyphenate capitalized words | Off |
| Hyphenate last word | Off |
| Hyphenate across column | Off |

### Widows & Orphans
- Keep Options: Keep Lines Together, Start: 2 lines, End: 2 lines
- Manual fix: Adjust tracking ±10 on problem paragraphs

### Baseline Grid
- Increment: Match body text leading (~15.4pt for 14pt × 1.1)
- Start: Top of text frame
- Align Body Text to grid: All Lines

---

## 8. Image Handling

- **Full-page images:** Image frame filling page (extend to bleed if edge-to-edge)
- **Inline images:** Anchored objects, "Above Line" positioning, centered
- **Width:** 100% of text block (margin to margin)
- **Spacing:** 8pt above, 8pt below
- **Resolution:** 300 DPI minimum at print size
- **Fitting:** Fill Frame Proportionally, then adjust crop

### Image Placement Map

| Image | File | Placement |
|-------|------|-----------|
| Zebra on bedpost | `600-ice-48005.jpg` | Full even page after *"…life raft in a black ocean."* |
| Ostrich face down | `600-ice-48006.jpg` | Full even page after *"The officers exchanged a glance."* |
| Boy with zebra, thoughtful | `600-ice-48004.jpg` | Inline between *"…moving the floor on him."* and *"Finally, something gave"* |
| Zebra on boombox | `600-ice-48002.jpg` | Top of even page; story resumes below |
| Zebra choking ostrich | `600-ice-48007.jpg` | Inline in confession scene |
| Zebra with scissors | `600-ice-48003.jpg` | Inline after *"Of course it was the scissors"* |
| Boy mid-scream | `600-ice-48001.jpg` | Top of even page; story continues below |
| Zebra under blanket | `600-ice-48000.jpg` | Full odd page after *"…just to see."* |

---

## 9. Section Breaks

- **Scene breaks** (`---`): Blank line with centered ornament or whitespace. First paragraph after break has NO first-line indent.
- **Chapter breaks:** Chapter Number style with Start on Next Odd Page.
- **Front/back matter sections:** Each starts on recto.
- **Invisible break guard:** Always use a visual indicator (ornament/asterisks) so breaks aren't lost at page top/bottom.

---

## 10. Saddle-Stitch Specifics

- **Creep:** At 44 pages / 22 sheets of 24lb bond, creep is negligible (<2mm). No shingling needed.
- **Bleed:** 0.125" on outside edges only. Inside edge (spine/fold) needs 0" bleed.
- **Imposition:** Use File > Print Booklet > 2-up Saddle Stitch for print-ready imposition.
- **PDF Export:** PDF/X-1a:2001 or PDF/X-4, export as Pages (not Spreads), use document bleed settings.

---

## 11. Single Document Approach

For a ~44-page novella, use a **single InDesign document** (not the Book feature). Use Sections for numbering changes. This is simpler, with no synchronization overhead.

---

## Sources

- [Adobe: Text Composition](https://helpx.adobe.com/indesign/using/text-composition.html)
- [Adobe: Paragraph and Character Styles](https://helpx.adobe.com/indesign/using/paragraph-character-styles.html)
- [Adobe: Numbering Pages, Chapters, Sections](https://helpx.adobe.com/indesign/using/numbering-pages-chapters-sections.html)
- [Adobe: Print Booklets](https://helpx.adobe.com/indesign/using/printing-booklets.html)
- [Book Design Made Simple](https://www.bookdesignmadesimple.com/)
- [The Book Designer: Page Margins](https://www.thebookdesigner.com/book-layouts-page-margins/)
- [CreativePro: Primary Text Frames](https://creativepro.com/indesign-basics-primary-text-frames/)
- [Speakipedia: Book Design Series](https://speakipedia.com/book-design-part-1/)
- [Pangram Pangram: Justify Type](https://pangrampangram.com/blogs/journal/perfectly-justify-type-indesign)
- [Folio Fox: Saddle Stitch in InDesign](https://www.foliofox.com.au/resources/blog-post/how-to-setup-pages-for-saddle-stitch-booklet-printing-in-indesign/)
