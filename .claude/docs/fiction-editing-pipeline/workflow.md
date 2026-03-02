# Workflow Reference

## State Machine

The pipeline operates as a linear state machine with author checkpoints between
each transition. No stage can be skipped without explicit author consent, and
no stage can begin until the previous stage's output is approved.

```
States:
  INTAKE          → Gathering manuscript and author context
  DEV_EDITING     → Developmental editor agent is active
  DEV_REVIEW      → Author is reviewing developmental edit
  DEV_REVISION    → Incorporating author-approved developmental changes
  LINE_EDITING    → Line editor agent is active
  LINE_REVIEW     → Author is reviewing line edit
  LINE_REVISION   → Incorporating author-approved line changes
  COPY_EDITING    → Copy editor agent is active
  COPY_REVIEW     → Author is reviewing copy edit + resolving queries
  COPY_REVISION   → Incorporating author decisions
  PROOFREADING    → Proofreader agent is active
  PROOF_REVIEW    → Author is reviewing proofread results
  COMPLETE        → Final manuscript delivered

Transitions:
  INTAKE         → DEV_EDITING      (when manuscript + context gathered)
  DEV_EDITING    → DEV_REVIEW       (when editorial letter + annotations complete)
  DEV_REVIEW     → DEV_REVISION     (when author provides feedback)
  DEV_REVISION   → LINE_EDITING     (when revised manuscript ready)
  LINE_EDITING   → LINE_REVIEW      (when annotated manuscript complete)
  LINE_REVIEW    → LINE_REVISION    (when author provides feedback)
  LINE_REVISION  → COPY_EDITING     (when revised manuscript ready)
  COPY_EDITING   → COPY_REVIEW      (when corrections + queries complete)
  COPY_REVIEW    → COPY_REVISION    (when author resolves all queries)
  COPY_REVISION  → PROOFREADING     (when final corrected manuscript ready)
  PROOFREADING   → PROOF_REVIEW     (when error list + clean manuscript complete)
  PROOF_REVIEW   → COMPLETE         (when author approves final manuscript)

Backward transitions (rework):
  DEV_REVIEW     → DEV_EDITING      (author requests substantial rethink)
  LINE_REVIEW    → LINE_EDITING     (author wants another pass on specific sections)
  COPY_REVIEW    → COPY_EDITING     (author decisions require re-checking consistency)
  PROOF_REVIEW   → PROOFREADING     (errors found in review; run second pass)
  Any REVIEW     → previous EDITING (if author finds the edit insufficient)
```

## API Integration Guide

When using this pipeline programmatically via the Anthropic API, each stage maps
to a separate API call (or series of calls) with a different model.

### Model Routing

```javascript
const MODELS = {
  orchestrator:    'claude-sonnet-4-5-20250929',
  developmental:   'claude-opus-4-6',
  lineEditor:      'claude-sonnet-4-5-20250929',
  copyEditor:      'claude-sonnet-4-5-20250929',
  proofreader:     'claude-haiku-4-5-20251001',
};
```

### Payload Structure

Each agent call should include:

1. **System prompt**: The full content of the agent's `.md` file
2. **User message**: The manuscript text + style sheet + any author context
3. **Model**: From the routing table above
4. **Max tokens**: Varies by stage (see below)

### Recommended Max Tokens Per Stage

```javascript
const MAX_TOKENS = {
  // Editorial letter is compact; manuscript annotations add volume
  developmental:  8192,

  // Full annotated manuscript is the longest output
  lineEditor:     16384,

  // Corrected manuscript + style sheet + summary
  copyEditor:     16384,

  // Error list is short; clean manuscript is the bulk
  proofreader:    8192,
};
```

For short stories under 5,000 words, these limits are generous. For longer pieces
(10,000+ words), consider splitting the manuscript into sections and running each
agent on sections sequentially, then merging results.

### Conversation Flow Pattern

```javascript
async function runStage(stage, manuscript, styleSheet, authorContext) {
  const agentPrompt = await loadAgentFile(stage);

  const response = await anthropic.messages.create({
    model: MODELS[stage],
    max_tokens: MAX_TOKENS[stage],
    system: agentPrompt,
    messages: [{
      role: 'user',
      content: buildStagePrompt(stage, manuscript, styleSheet, authorContext)
    }]
  });

  return parseAgentOutput(stage, response);
}

function buildStagePrompt(stage, manuscript, styleSheet, authorContext) {
  return `
## Style Sheet
${styleSheet}

## Author Context
${authorContext}

## Manuscript
${manuscript}

## Instructions
Execute the ${stage} checklist on the manuscript above. Produce all required
deliverables as specified in your agent definition. Update the style sheet
with any new decisions.
  `.trim();
}
```

### Handling Long Manuscripts

For manuscripts exceeding the context window:

1. **Developmental editing**: Cannot be split — the agent needs the full picture.
   Use Opus's 200K context window. For manuscripts approaching that limit,
   provide a scene-by-scene summary alongside the full text.

2. **Line editing**: Can be split by scene or chapter. Process sequentially.
   Carry the style sheet and any voice/tone notes between chunks.

3. **Copy editing**: Can be split, but the consistency pass (Step 2 in the
   checklist) must see the full text first. Run a full-text consistency scan
   first, then process corrections in chunks.

4. **Proofreading**: Splits easily by section. Each section is independent at
   this stage since all style decisions are locked in the style sheet.

## Interactive (Claude.ai / Claude Code) Usage

When running this pipeline interactively rather than via API:

1. **Model switching**: Tell the user to switch models between stages.
   Display a message like: "Stage 2 (Line Editing) works best with Sonnet 4.5.
   Please switch to Sonnet if you're currently on a different model."

2. **Context management**: In a long conversation, the full manuscript +
   annotations + style sheet may approach context limits. If this happens:
   - Summarize previous stage outputs rather than carrying full annotated versions
   - Keep the style sheet in full (it's the critical thread)
   - Keep the latest clean manuscript in full

3. **Checkpointing**: After each stage, suggest the user save the current
   manuscript version and style sheet to files. This protects against context
   loss and provides a revision history.

4. **Multi-session editing**: For longer works, each stage may span multiple
   sessions. The style sheet and latest manuscript are the minimum state needed
   to resume.

## Quality Gates

Each stage transition has a quality gate — minimum criteria before advancing:

### INTAKE → DEV_EDITING
- [ ] Full manuscript text received
- [ ] Genre and tone identified
- [ ] Author's concerns recorded
- [ ] Style sheet initialized

### DEV_EDITING → LINE_EDITING
- [ ] Editorial letter produced
- [ ] Author has reviewed and discussed all major points
- [ ] Structural revisions incorporated (or explicitly deferred by author)
- [ ] Style sheet updated with narrative fundamentals

### LINE_EDITING → COPY_EDITING
- [ ] Annotated manuscript produced
- [ ] Author has reviewed and approved/rejected all suggestions
- [ ] Approved revisions incorporated
- [ ] Style sheet updated with voice and style notes

### COPY_EDITING → PROOFREADING
- [ ] All corrections applied
- [ ] All queries resolved with author
- [ ] Style sheet finalized with complete word list and conventions
- [ ] Consistency verified across full manuscript

### PROOFREADING → COMPLETE
- [ ] Error list produced
- [ ] All errors corrected
- [ ] Clean manuscript produced
- [ ] Style sheet compliance verified
- [ ] Proofread certification issued
