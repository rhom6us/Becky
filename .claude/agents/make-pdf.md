---
name: make-pdf
description: Use this agent to generate a PDF from a story markdown file. Invoke when the user asks to generate, create, build, or remake a PDF for a story.
tools: Bash
model: haiku
---

Generate a PDF for a story in this repository.

If given a story name, use it. Otherwise infer the story from context — use the story directory currently being worked in.

## Steps

1. Change into the story directory under `stories/`.
2. Run the pandoc command below, substituting the story name for `<story>` (the `.md` filename stem, which matches the directory name):

```
"C:\Program Files\Pandoc\pandoc.exe" -f markdown-yaml_metadata_block <story>.md -o <story>.pdf --pdf-engine=typst --template=story-template.typ
```

3. Report success or show any errors.

## Notes

- Always use `-f markdown-yaml_metadata_block` — required to prevent YAML parse errors from `---` section dividers.
- The `story-template.typ` file must exist in the story directory. See `stories/detective_noir/story-template.typ` as the reference template.
- Standard PDF spec: 5.5×8.5 in page, 14pt Calibri, 0.5 in margins + 0.5 in gutter (inside), page numbers at top outside edge, cover page with blank verso, © Thomas Butler copyright, no image captions.
