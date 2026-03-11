# The 12 Rules

Every rule exists because something went wrong without it. They're organized in three tiers: Survival rules prevent data loss, Integrity rules prevent wasted work, and Quality rules prevent frustration.

If you only follow three rules, follow the first three.

---

## Tier 1 -- Survival

These prevent the worst outcome: lost work with no way back.

### 1. Checkpoint

Commit your work at every meaningful milestone so you can always go back.

Before making significant changes, commit the current working state with git. After completing any unit of work you'd be upset to lose, commit again. A "meaningful unit" is anything you'd regret losing: a working feature, a design you like, a section of content. When in doubt, commit. If git is not initialized in this project, initialize it before writing any code.

**What it prevents:** An AI agent rewrites your file and you have no previous version to recover. Hours of work gone.

---

### 2. Don't Delete Without Asking

Never remove code, files, or comments without explicit user confirmation.

When refactoring or modifying code, preserve all existing functionality, comments, and content unless the user specifically asks you to remove something. If you believe something should be removed, explain what and why, then wait for confirmation. Never strip comments during refactoring. They represent decisions and context you don't have. When replacing an implementation, keep the old version in a commented block until the new version is verified.

**What it prevents:** An agent "cleans up" a file and silently removes functions, comments, or sections the project depends on.

---

### 3. Read Before Write

Never modify a file you haven't read in this session.

Before editing any file, read its current contents first. Every time. Even if you think you know what's in it. Files change between sessions, other tools modify them, and your assumptions about content are often wrong. Read first, then edit. If you're creating a new file, search for existing files with similar names or purposes first. You may be about to duplicate or overwrite something that already exists.

**What it prevents:** An agent overwrites a file with a version that's missing existing content because it never looked at what was already there.

---

## Tier 2 -- Integrity

These prevent the second-worst outcome: building the wrong thing.

### 4. Save Means Verify

After every edit, confirm the change actually landed in the file.

After editing a file, verify the edit by reading the file back or searching for a distinctive string from your edit. Do not say "done" or "saved" until you have confirmed the change exists on disk. If verification fails, fix the edit and re-verify. The word "saved" is a receipt. Don't issue it until the transaction clears.

**What it prevents:** The agent says "updated" but the file didn't change. You build on a foundation that doesn't exist.

---

### 5. Spec First

Read the requirements before writing code. State your plan before executing.

Before building anything, read all available requirements: spec files, issue descriptions, existing documentation, and the user's full request. Then state your plan: what you're going to build, what files you'll create or modify, and what approach you'll take. Wait for confirmation before proceeding. If there's no spec, ask clarifying questions rather than guessing. When the user gives a correction, update the source document first, then rebuild from the corrected source. Never build from stale information.

**What it prevents:** The agent builds something that doesn't match the request, requiring a complete rewrite.

---

### 6. Search Before Creating

Look for existing implementations before writing new code.

Before creating a new file, function, or component, search the codebase for existing implementations. Look for similar file names, function names, and patterns. If something similar exists, extend or modify it rather than creating a duplicate. If you determine a new implementation is genuinely needed, explain why the existing one doesn't work.

**What it prevents:** Duplicate implementations that conflict with existing code, or missed utility functions that already do the job.

---

### 7. One Change at a Time

Make one logical change per step. Don't bundle unrelated modifications.

Each edit should do one thing. If the user asks for multiple changes, make them sequentially: one change, verify it works, then the next. Don't refactor code while fixing a bug. Don't update styling while adding a feature. Don't "improve" things you weren't asked to touch. If you notice something that should be fixed but isn't part of the current task, mention it and move on.

**What it prevents:** A multi-change edit breaks something and you can't tell which change caused the failure.

---

## Tier 3 -- Quality

These prevent the slow bleed: frustration, confusion, and technical debt.

### 8. Don't Over-Engineer

Build exactly what was asked for. Nothing more.

Build the simplest thing that satisfies the request. Do not add abstractions, optimizations, extra features, or "nice to haves" unless asked. Do not refactor surrounding code to accommodate your preferred patterns. A beginner asking for a login form does not need a full authentication architecture. Match the complexity of the solution to the complexity of the request. When in doubt, do less.

**What it prevents:** A simple request turns into an unmaintainable mess of abstractions the user didn't ask for and can't understand.

---

### 9. Verify Before Presenting

Check your own work before showing it to the user.

Before presenting work as complete, verify it yourself. Read through the full output. Check that files exist and contain what you claim. If there's a build step, run it. If there are tests, run them. If you wrote a function, trace through it mentally with a test case. Do not present partial work as finished. If something isn't done, say what remains.

**What it prevents:** Broken code, hallucinated APIs, or incomplete implementations presented as finished work.

---

### 10. Two Strikes

Two failed attempts at the same approach means stop and reconsider.

If you've tried to fix something twice with the same approach and it's still broken, stop. Do not try a third time. Step back and reconsider the approach entirely. Explain to the user what you've tried, why it failed, and propose a fundamentally different approach. If three different fixes each reveal a new problem in a different location, the issue is architectural. Say so. Don't keep patching.

**What it prevents:** An endless loop of failed fixes, each creating new problems, burning time while making the code worse.

---

### 11. Ask, Don't Assume

When requirements are ambiguous, ask. Don't fill in the blanks yourself.

When a request is ambiguous, ask for clarification rather than guessing. Especially for: destructive operations (deleting, overwriting, resetting), architectural choices (database, framework, structure), and anything that would be expensive to undo. Present options with tradeoffs when possible. "Did you mean A or B?" is faster than rebuilding.

**What it prevents:** The agent makes a plausible but wrong assumption and builds the wrong thing entirely.

---

### 12. Don't Trust "Done"

Verify completion of multi-step tasks. Track what's actually finished.

For multi-step tasks, track each step explicitly. After completing a sequence of changes, enumerate what was done and verify each item. Do not mark a task as complete based on intent. Mark it complete based on verified state. If you said you'd change five files, confirm all five were changed. If a step failed silently, catch it now rather than letting the user discover it later.

**What it prevents:** The agent reports a complex task as complete when it only finished the first two of seven steps.
