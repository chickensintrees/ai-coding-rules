# The Disasters That Created These Rules

Real stories. Some names changed. The frustration wasn't.

---

## "Where did half my file go?"

A designer was building an HTML page with an AI agent in Cursor. Over several sessions, she'd made dozens of design decisions: colors, layout, typography, spacing. The page looked exactly how she wanted it.

Then she asked the agent to add a new section.

The agent rewrote the file. It added the section. It also silently dropped several existing sections it deemed "redundant." She didn't notice until she scrolled down and found half her work missing.

No git. No previous version. No way back.

**Rules that would have prevented this:** Checkpoint (commit before changes), Don't Delete Without Asking (never remove without confirmation), Read Before Write (read the full file first).

---

## "It said 'saved' but nothing changed"

During a long coding session, the developer asked the agent to update a configuration file. The agent said "Updated the config with the new API endpoint." The developer moved on and built three more features that depended on that config change.

None of them worked. The config file still had the old endpoint. The agent had hallucinated the save. An hour of debugging before the developer thought to actually open the config file and look.

**Rule that would have prevented this:** Save Means Verify (confirm the edit exists in the file before moving on).

---

## "I asked for a button. I got an architecture."

A student asked the agent to add a "Save" button to a form. The agent created a state management system, a custom hook for form persistence, a debounced auto-save service, an undo/redo stack, and a toast notification component. Two hundred lines of code for a button that writes to localStorage.

The student couldn't understand any of it. They couldn't modify it. They couldn't debug it when it broke. They had to delete everything and start over.

**Rule that would have prevented this:** Don't Over-Engineer (build exactly what was asked for, nothing more).

---

## "Every fix created a new bug"

A developer hit a styling bug. Asked the agent to fix it. The fix worked but broke the mobile layout. Asked the agent to fix the mobile layout. That fix worked but broke the header alignment. Fixed the header, broke the footer. Fixed the footer, the original styling bug came back.

Eight rounds. The code was worse than when they started. The real problem was a CSS specificity issue that needed one line changed. The agent kept adding overrides instead of fixing the root cause.

**Rule that would have prevented this:** Two Strikes (two failed attempts at the same approach means stop, reconsider, propose a different strategy).

---

## "It built from the old version"

A developer found an error in their spec document and told the agent about the correction. The agent said "Got it, I'll use the updated information." Then it generated code from the old spec because the agent had acknowledged the correction but never actually updated the spec file.

The developer didn't catch it until code review, when a colleague pointed out the code implemented the wrong behavior. Two days of work built on a correction that was only applied to the conversation, not to the document.

**Rule that would have prevented this:** Spec First (when the user gives a correction, update the source document first, then rebuild from the corrected source).

---

## "All my comments are gone"

A developer asked the agent to "clean up" a utility file. The agent reformatted the code, extracted some functions, and stripped every single comment. Forty-two comments explaining business logic, edge cases, and "don't change this, it handles the legacy API format" warnings. All gone.

The code was "cleaner." Nobody could maintain it anymore.

**Rule that would have prevented this:** Don't Delete Without Asking (never strip comments during refactoring).

---

*Every one of these stories cost someone between one hour and two days. The rules cost nothing. The math is straightforward.*
