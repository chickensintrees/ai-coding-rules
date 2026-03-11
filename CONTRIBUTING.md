# Contributing

## Adding a Rule

Rules must meet three criteria:

1. **Derived from a real failure.** What happened? What went wrong? Rules based on hypotheticals are noise.
2. **Actionable by an AI agent.** The rule must be something an AI coding assistant can follow without human intervention during execution.
3. **Universal.** Works across tools (Cursor, Claude Code, Windsurf, Copilot), languages, and frameworks.

### To propose a rule:

Open an issue with:
- **The disaster:** What happened, in 2-3 sentences.
- **The rule:** What instruction would have prevented it, in 2-4 sentences.
- **The tier:** Survival (data loss), Integrity (wasted work), or Quality (frustration).

If accepted, we'll work with you to write it up and add it to the appropriate preset.

## Improving Existing Rules

If you've found a case where an existing rule doesn't work as written, or where the wording causes an AI agent to misinterpret the intent, open an issue describing:
- Which rule
- What the AI did wrong
- What wording change would fix it

Empirical data (screenshots, session logs, before/after) is extremely helpful.

## Adding Tool Formats

If you use an AI coding tool that reads instruction files in a format we don't cover, open a PR adding:
- A new file in `quickstart/` with the tool-specific format
- An entry in the README's quickstart section
- An entry in the "How It Works" table

## Style

- Rules are written as direct instructions to an AI agent. Second person ("you").
- Short sentences. No jargon. A beginner should understand every rule.
- No theoretical justifications in the rule text. The "why" goes in RULES.md under "What it prevents."
