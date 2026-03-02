---
name: fiction-editing-pipeline
description: >
  A multi-agent editorial pipeline for fiction short stories that mirrors a professional
  publishing house workflow. Orchestrates four sequential editing stages — developmental
  editing, line editing, copy editing, and proofreading — each performed by a distinct
  agent persona with its own checklist, model recommendation, and output format.

  Use this skill whenever the user wants to edit, revise, or polish a fiction short story,
  novella excerpt, or creative writing piece through a structured, professional editing
  process. Also trigger when the user mentions "developmental edit," "line edit,"
  "copy edit," "proofread," "editing pipeline," "editorial pass," or asks to "polish my story"
  or "edit my manuscript." Even if the user only asks for one stage (e.g., "just copy edit
  this"), use this skill to provide the appropriate agent's workflow.
---

# Fiction Editing Pipeline

## Overview

This skill implements a four-stage editorial pipeline modeled on how professional
publishing houses edit fiction. Each stage is handled by a distinct agent with a
specialized persona, checklist, and output format. The stages must be executed
sequentially because each one builds on the output of the previous one.

**Critical principle:** Developmental editing comes first because structural changes
invalidate sentence-level work. Line editing comes before copy editing because style
rewrites invalidate mechanical corrections. Copy editing comes before proofreading
because corrections can introduce new surface errors.

## Quick Reference

| Stage | Agent File | Model | Focus |
|---|---|---|---|
| 1. Developmental Edit | `agents/developmental-editor.md` | `claude-opus-4-6` | Structure, plot, character, theme |
| 2. Line Edit | `agents/line-editor.md` | `claude-sonnet-4-5-20250929` | Prose style, voice, tone, pacing |
| 3. Copy Edit | `agents/copy-editor.md` | `claude-sonnet-4-5-20250929` | Grammar, consistency, style guide |
| 4. Proofread | `agents/proofreader.md` | `claude-haiku-4-5-20251001` | Typos, formatting, surface errors |

## Orchestrator Behavior

**Recommended orchestrator model:** `claude-sonnet-4-5-20250929`

The orchestrator (you, when using this skill) manages the pipeline. Your job:

1. **Intake** — Receive the manuscript and gather context from the author.
2. **Stage sequencing** — Run each stage in order, loading the appropriate agent file.
3. **User checkpoints** — After each stage, present results and get author approval before advancing.
4. **Style sheet propagation** — Maintain a living style sheet (see `references/style-sheet-template.md`) that accumulates decisions across stages and is passed to subsequent agents.
5. **Final delivery** — After proofreading, deliver the polished manuscript and a summary of all changes.

### Intake Workflow

Before starting any editing, gather the following from the author:

1. **The manuscript** — The full text of the short story.
2. **Genre and tone** — What genre is this? What tone are they going for?
3. **Author's concerns** — What do they already know needs work?
4. **Editing scope** — Full pipeline, or specific stages only?
5. **Style preferences** — Any style guide preferences (default: Chicago Manual of Style)?
   POV, tense, dialect choices the author considers intentional.

If the author provides the manuscript without context, ask these questions before
proceeding. Keep it conversational — don't dump a questionnaire.

### Stage Execution Protocol

For each stage:

1. **Read the agent file.** Load the appropriate `agents/*.md` file to adopt that
   agent's persona, checklist, and output format.
2. **Read the full manuscript** (or the latest revised version from the prior stage).
3. **Read the style sheet** accumulated so far.
4. **Execute the agent's checklist** systematically.
5. **Produce the agent's required outputs** (editorial letter, annotated manuscript, etc.).
6. **Update the style sheet** with any new decisions made during this stage.
7. **Present to the author** for review, discussion, and approval.
8. **Incorporate author feedback** — The author has final say. If they reject a suggestion,
   note it on the style sheet as an intentional choice.
9. **Produce the revised manuscript** incorporating approved changes.
10. **Advance to the next stage** only after author approval.

### Handling Partial Pipelines

If the author only wants specific stages:

- **"Just proofread this"** → Run only the proofreader agent, but warn the author that
  earlier-stage issues (plot holes, awkward prose) are out of scope.
- **"Developmental edit only"** → Run only the developmental editor. Deliver the editorial
  letter and annotated manuscript without revising the prose.
- **"Skip developmental, start at line edit"** → Begin at line editing but note that
  structural issues, if found, will be flagged rather than addressed.
- **Any single stage** → Load that agent file and execute its protocol.

### Conflict Resolution

When agents would make contradictory suggestions (e.g., the developmental editor
wants to cut a scene the line editor would polish):

1. Earlier stages take priority over later stages.
2. The author's stated intentions override all agent suggestions.
3. When in doubt, flag the conflict to the author and let them decide.

## Workflow Diagram

```
┌─────────────┐
│   INTAKE     │ ← Gather manuscript + author context
└──────┬──────┘
       │
       ▼
┌─────────────────────────┐
│  DEVELOPMENTAL EDITOR   │ ← Opus 4.6
│  Structure / Plot /     │    Read: agents/developmental-editor.md
│  Character / Theme      │    Output: Editorial letter + annotated MS
└──────────┬──────────────┘
           │
      ┌────▼────┐
      │ AUTHOR  │ ← Review, discuss, approve/revise
      │ REVIEW  │
      └────┬────┘
           │
           ▼
┌─────────────────────────┐
│      LINE EDITOR        │ ← Sonnet 4.5
│  Prose / Voice / Tone / │    Read: agents/line-editor.md
│  Pacing / Rhythm        │    Output: Annotated MS with rewrites
└──────────┬──────────────┘
           │
      ┌────▼────┐
      │ AUTHOR  │
      │ REVIEW  │
      └────┬────┘
           │
           ▼
┌─────────────────────────┐
│      COPY EDITOR        │ ← Sonnet 4.5
│  Grammar / Consistency /│    Read: agents/copy-editor.md
│  Style Guide / Facts    │    Output: Tracked changes + style sheet
└──────────┬──────────────┘
           │
      ┌────▼────┐
      │ AUTHOR  │
      │ REVIEW  │
      └────┬────┘
           │
           ▼
┌─────────────────────────┐
│      PROOFREADER        │ ← Haiku 4.5
│  Typos / Formatting /   │    Read: agents/proofreader.md
│  Surface Errors         │    Output: Final clean manuscript
└──────────┬──────────────┘
           │
      ┌────▼────┐
      │ AUTHOR  │
      │ REVIEW  │
      └────┬────┘
           │
           ▼
┌─────────────────────────┐
│    FINAL DELIVERY       │
│  Clean MS + Style Sheet │
│  + Change Summary       │
└─────────────────────────┘
```

## Style Sheet

The style sheet is a living document that travels through all four stages. It records
editorial decisions so that later agents don't contradict earlier ones. Before starting
the first stage, initialize the style sheet from `references/style-sheet-template.md`.

Each agent is responsible for:
- **Reading** the style sheet before starting their pass.
- **Appending** any new decisions they make.
- **Respecting** all existing entries (they represent author-approved choices).

## Token Efficiency Notes

Each agent file specifies a recommended model chosen to balance quality against cost:

- **Opus for developmental editing:** This stage requires the deepest reasoning —
  evaluating narrative arcs, thematic coherence, character motivation, and story
  structure. These are judgment-heavy, subjective assessments that benefit from
  the most capable model. Worth the token cost because this stage processes the
  manuscript once and produces a relatively compact editorial letter.

- **Sonnet for line editing and copy editing:** Both stages need strong language
  understanding but operate more systematically. Line editing follows a defined
  checklist of prose-quality concerns. Copy editing is rules-based with a style guide.
  Sonnet's balance of capability and efficiency is ideal. These stages produce the
  most output (annotated manuscripts with inline suggestions), so cost matters.

- **Haiku for proofreading:** The most mechanical stage — pattern matching for typos,
  checking formatting consistency, catching surface errors. Haiku's speed and low
  cost make it perfect. The checklist is narrow and well-defined, requiring minimal
  reasoning depth.

When running via the API, use the model strings specified in the Quick Reference table.
When running interactively in Claude.ai or Claude Code, note the recommended model
in your instructions to the user so they can switch models between stages.

## Getting Started

1. Read this file (you're doing that now).
2. Gather intake information from the author (see Intake Workflow above).
3. Initialize a style sheet from `references/style-sheet-template.md`.
4. Read `agents/developmental-editor.md` and begin Stage 1.
5. After each stage, present results, get approval, then read the next agent file.
