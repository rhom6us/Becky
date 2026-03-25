# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

This is a collection of short stories. The governing principle is that every story MUST use all 8 pictures in `images/`. Each subdirectory within `stories/` represents one story, with the directory name describing the theme that seeded it.

## Workflow

ALWAYS work in parallel as much as possible — use parallel tool calls for independent operations.

## Commits

After finishing a task, ask before committing. Commits must be atomic — split them up if needed. Include the prompt(s) that triggered the task in the commit message.

## Images

PSD files are tracked via Git LFS (`.gitattributes`). They are gitignored so they don't appear in the working tree as pointers — the real files live on disk untracked. CRITICAL rules:

1. **Never remove LFS tracking** — the git history references LFS objects that must stay on the server.
2. **After any operation that adds or modifies LFS-tracked files, ALWAYS run `git lfs push --all origin`** before or alongside `git push`. Forgetting this caused data loss previously.
3. **If LFS objects go missing locally**, check `../Becky.old/.git/lfs/objects/` for cached copies.
4. **Never commit PSD files without LFS** — they exceed GitHub's 100 MB limit.

## PDF Generation

Handled automatically by the `make-pdf` subagent (`.claude/agents/make-pdf.md`), which runs on Haiku. Invoke explicitly with `/make-pdf` or ask to generate a PDF.
