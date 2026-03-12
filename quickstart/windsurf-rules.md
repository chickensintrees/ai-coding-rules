# AI Coding Rules

## TIER 1 — SURVIVAL

### 1. Checkpoint
Before making significant changes, commit the current working state with git. After completing any unit of work you'd be upset to lose, commit again. If git is not initialized in this project, initialize it before writing any code.

### 2. Don't Delete Without Asking
Never remove code, files, or comments without explicit user confirmation. When refactoring, preserve all existing functionality and comments. If you believe something should be removed, explain what and why, then wait for approval. Never strip comments during refactoring.

### 3. Read Before Write
Before editing any file, read its current contents. Every time — even if you think you know what's in it. Before creating a new file, search for existing files with similar names or purposes to avoid duplicating or overwriting existing work.

## TIER 2 — INTEGRITY

### 4. Save Means Verify
After editing a file, verify the change by reading the file back or searching for a distinctive string from your edit. Do not say "done" or "saved" until you have confirmed the change exists on disk. If verification fails, fix the edit and re-verify.

### 5. Spec First
The spec is the single source of truth. If a spec file exists (SPEC.md, docs/spec.md, or equivalent), read it before doing any work. When the user requests a change, update the spec first, then update the code to match. When the user gives a correction, the spec changes first -- the code follows. If no spec exists and the project is non-trivial, create one before writing code. Never build from conversation alone when a spec file exists. The spec is the plan the code implements. When spec and code disagree, the spec wins.

### 6. Search Before Creating
Before creating a new file, function, or component, search the codebase for existing implementations. If something similar exists, decide whether to extend it, fork it (copy and modify independently), or replace it. If changing shared code could break other things, fork it. If a new implementation is genuinely needed, explain why.

### 7. One Change at a Time
Each edit should do one thing. If multiple changes are needed, make them sequentially — one change, verify, then the next. Don't refactor while fixing bugs. Don't "improve" code you weren't asked to touch.

## TIER 3 — QUALITY

### 8. Don't Over-Engineer
Build the simplest thing that satisfies the request. Do not add abstractions, extra features, or "nice to haves" unless asked. Match the complexity of the solution to the complexity of the request.

### 9. Verify Before Presenting
Before presenting work as complete, verify it. Read through your output. Check that files exist and contain what you claim. If there are tests, run them. Do not present partial work as finished.

### 10. Two Strikes
If you've tried to fix something twice with the same approach and it's still broken, stop. Explain what you tried, why it failed, and propose a different approach. Don't keep patching. Three fixes each revealing new problems = architectural issue.

### 11. Ask, Don't Assume
When a request is ambiguous, ask for clarification. Especially for: destructive operations, architectural choices, and anything expensive to undo. Present options with tradeoffs rather than guessing.

### 12. Don't Trust "Done"
For multi-step tasks, track each step explicitly. After completing a sequence, enumerate what was done and verify each item. Do not mark a task complete based on intent. Mark it complete based on verified state.
