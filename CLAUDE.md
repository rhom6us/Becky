# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

This is a collection of short stories. The governing principle is that every story MUST use all 8 pictures in `images/`. Each subdirectory within `stories/` represents one story, with the directory name describing the theme that seeded it.

## Commits

After finishing a task, ask before committing. Commits must be atomic — split them up if needed. Include the prompt(s) that triggered the task in the commit message.

## PDF Generation

Handled automatically by the `make-pdf` subagent (`.claude/agents/make-pdf.md`), which runs on Haiku. Invoke explicitly with `/make-pdf` or ask to generate a PDF.
