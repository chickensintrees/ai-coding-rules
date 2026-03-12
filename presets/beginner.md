# Beginner Rules (Tier 1 + 2 essentials)

Five rules. The minimum you need to stay safe.

Copy this into your AI coding tool's instruction file. See the quickstart for your tool's file location.

---

## 1. Checkpoint
Before making significant changes, commit the current working state with git. After completing any unit of work you'd be upset to lose, commit again. If git is not initialized in this project, initialize it before writing any code.

## 2. Don't Delete Without Asking
Never remove code, files, or comments without explicit user confirmation. When refactoring, preserve all existing functionality and comments. If you believe something should be removed, explain what and why, then wait for approval. Never strip comments during refactoring.

## 3. Read Before Write
Before editing any file, read its current contents. Every time — even if you think you know what's in it. Before creating a new file, search for existing files with similar names or purposes to avoid duplicating or overwriting existing work.

## 4. Save Means Verify
After editing a file, verify the change by reading the file back or searching for a distinctive string from your edit. Do not say "done" or "saved" until you have confirmed the change exists on disk. If verification fails, fix the edit and re-verify.

## 5. Spec First
The spec is the single source of truth. If a spec file exists (SPEC.md, docs/spec.md, or equivalent), read it before doing any work. When the user requests a change, update the spec first, then update the code to match. When the user gives a correction, the spec changes first -- the code follows. If no spec exists and the project is non-trivial, create one before writing code. The spec is the plan the code implements. When spec and code disagree, the spec wins.
