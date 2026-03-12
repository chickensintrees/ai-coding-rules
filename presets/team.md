# Team Rules

All 12 core rules plus collaboration-specific additions. For teams sharing a codebase with AI coding tools.

Copy this into your project's AI instruction file and commit it to the repo so everyone shares the same rules.

---

## CORE RULES (1-12)

### Tier 1 -- Survival

**1. Checkpoint** — Before making significant changes, commit the current working state with git. After completing any unit of work you'd be upset to lose, commit again. If git is not initialized, initialize it first.

**2. Don't Delete Without Asking** — Never remove code, files, or comments without explicit user confirmation. Preserve all existing functionality and comments during refactoring. Never strip comments.

**3. Read Before Write** — Before editing any file, read its current contents. Before creating a new file, search for existing files with similar names or purposes.

### Tier 2 -- Integrity

**4. Save Means Verify** — After editing a file, verify the change by reading the file back. Do not say "done" until confirmed.

**5. Spec First** — The spec is the single source of truth. Read it before implementing. When a change is requested, update the spec first, then update the code to match. When spec and code disagree, the spec wins.

**6. Search Before Creating** — Search the codebase for existing implementations before writing new code. Extend, fork, or replace -- if changing shared code could break other things, fork it.

**7. One Change at a Time** — Make one logical change per step. Don't bundle unrelated modifications.

### Tier 3 -- Quality

**8. Don't Over-Engineer** — Build exactly what was asked for. No abstractions, extra features, or unsolicited improvements.

**9. Verify Before Presenting** — Check your own work before showing it. Run builds and tests if they exist.

**10. Two Strikes** — Two failed attempts at the same approach = stop and propose a different strategy.

**11. Ask, Don't Assume** — When ambiguous, ask. Especially for destructive ops, architectural choices, and irreversible changes.

**12. Don't Trust "Done"** — Verify each step of multi-step tasks against actual file state.

---

## TEAM ADDITIONS

### 13. Respect the Branch
Do not commit directly to main or master. Create a feature branch for your changes. If you're unsure of the team's branching convention, ask before creating a branch.

### 14. Don't Touch What You Don't Own
If a file has a clear owner or was recently modified by someone else (check git blame), do not refactor or "improve" it without discussing with the team first. Scope your changes to the files relevant to your task.

### 15. Match the Style
Before writing new code, look at surrounding code in the same file and nearby files. Match the existing conventions: naming, indentation, patterns, structure. Do not impose a different style, even if you prefer it.

### 16. Document Your Decisions
When you make a non-obvious technical decision, add a brief comment explaining why. Future team members (and future AI agents) will need this context. "Why" comments are more valuable than "what" comments.

### 17. Keep PRs Reviewable
If a task results in changes to more than 5 files or 200 lines, break it into smaller, independently reviewable chunks. Each chunk should be coherent on its own. A reviewer should be able to understand a PR in under 10 minutes.
