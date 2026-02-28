# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

This is a collection of short stories. The governing principle is that every story MUST use all 8 pictures in `images/`. Each subdirectory within `stories/` represents one story, with the directory name describing the theme that seeded it.

## Commits

Commit changes immediately after finishing a task. Commits must be atomic — split them up if needed. Include the prompt(s) that triggered the task in the commit message.

## PDF Generation

Pandoc is installed at `C:\Program Files\Pandoc\pandoc.exe`. Use Typst as the PDF engine. Always use `-f markdown-yaml_metadata_block` to prevent YAML parse errors from `---` section dividers in story files.

Each story directory should contain a `story-template.typ` Typst template. Standard spec for all stories:

- **Page size:** 5.5 × 8.5 in (prints correctly in booklet mode on 8.5×11 paper)
- **Margins:** 0.5 in outside/top/bottom; 1 in inside (0.5 base + 0.5 gutter)
- **Page numbers:** top of page, outside edge (right on odd pages, left on even)
- **Font:** sans-serif best for print — Calibri preferred, Segoe UI / Arial as fallback
- **Font size:** 14pt
- **Images:** embed inline; suppress alt-text captions
- **Cover page:** title, subtitle, author, copyright notice; verso (page 2) blank
- **Copyright:** © Thomas Butler. All rights reserved.

Standard command (run from the story directory):
```
"C:\Program Files\Pandoc\pandoc.exe" -f markdown-yaml_metadata_block <story>.md -o <story>.pdf --pdf-engine=typst --template=story-template.typ
```

See `stories/detective_noir/story-template.typ` as the reference template.
