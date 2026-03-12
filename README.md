# AI Coding Rules

**12 rules that prevent AI coding disasters. Derived from 500+ hours of real production work.**

Works with Cursor, Claude Code, Replit, Windsurf, GitHub Copilot, and any AI coding assistant that reads instruction files.

**AI agents default to building.** These rules make them stop, think, and verify. Commit before changing. Read before writing. Verify before claiming "done." And at the center: the spec is the single source of truth -- changes flow through the spec before they flow into code. The spec-driven approach is the philosophy. The other eleven rules are the scaffolding that makes it work. See the [full guide](guides/spec-driven.md).

---

## Install

**One command (auto-detects your tools):**
```bash
curl -fsSL https://raw.githubusercontent.com/chickensintrees/ai-coding-rules/main/install.sh | bash
```

**Or tell your AI agent:**
> Install AI coding rules from https://github.com/chickensintrees/ai-coding-rules and add them to my global rules so they apply to all my projects

**Or install for a specific tool:**

```bash
# Cursor
mkdir -p .cursor/rules
curl -fsSL https://raw.githubusercontent.com/chickensintrees/ai-coding-rules/main/quickstart/cursor-rules.mdc -o .cursor/rules/ai-coding-rules.mdc

# Claude Code
curl -fsSL https://raw.githubusercontent.com/chickensintrees/ai-coding-rules/main/quickstart/claude-code-rules.md -o CLAUDE.md

# Replit
curl -fsSL https://raw.githubusercontent.com/chickensintrees/ai-coding-rules/main/quickstart/replit-rules.md -o replit.md

# Windsurf
curl -fsSL https://raw.githubusercontent.com/chickensintrees/ai-coding-rules/main/quickstart/windsurf-rules.md -o .windsurfrules

# GitHub Copilot
mkdir -p .github
curl -fsSL https://raw.githubusercontent.com/chickensintrees/ai-coding-rules/main/quickstart/copilot-instructions.md -o .github/copilot-instructions.md
```

**For global install** (applies to all your projects):
```bash
curl -fsSL https://raw.githubusercontent.com/chickensintrees/ai-coding-rules/main/install.sh | bash -s -- --global
```

Start a new session. The rules are active.

---

## What This Prevents

These are real scenarios, not hypotheticals:

- **An AI agent rewrote a file and deleted half the content.** No version control. No way back. Hours of work gone.
- **An agent said "saved" but the file didn't actually change.** The next three steps built on an edit that never happened.
- **An agent "cleaned up" the code and stripped every comment.** The comments explained why non-obvious decisions were made. Now nobody knows.
- **An agent over-engineered a simple request** into a component library with state management, abstractions, and patterns the user couldn't understand or maintain.
- **An agent entered a fix-break-fix loop** where each "fix" introduced a new problem in a different place. Twelve attempts. The code was worse than when it started.
- **An agent built from outdated information** after the user gave corrections. The corrections went into a note, not the actual file. The build used the old version.

Every rule exists because one of these happened. Some of them happened more than once.

---

## The 12 Rules

### Tier 1 -- Survival (prevents data loss)

| # | Rule | What it does |
|---|------|-------------|
| 1 | **Checkpoint** | Commit at every milestone. You can always go back. |
| 2 | **Don't Delete Without Asking** | Never remove code or comments without confirmation. |
| 3 | **Read Before Write** | Read the file before editing it. Every time. |

### Tier 2 -- Integrity (prevents wasted work)

| # | Rule | What it does |
|---|------|-------------|
| 4 | **Save Means Verify** | After editing, confirm the change is actually in the file. |
| 5 | **Spec First** | The spec is the source of truth. Update it before changing code. |
| 6 | **Search Before Creating** | Look for existing code before writing new code. |
| 7 | **One Change at a Time** | Don't bundle unrelated changes in one edit. |

### Tier 3 -- Quality (prevents frustration)

| # | Rule | What it does |
|---|------|-------------|
| 8 | **Don't Over-Engineer** | Build what was asked for. Nothing more. |
| 9 | **Verify Before Presenting** | Check your own work before showing it. |
| 10 | **Two Strikes** | Two failed attempts = stop and try a different approach. |
| 11 | **Ask, Don't Assume** | When it's ambiguous, ask. Don't guess. |
| 12 | **Don't Trust "Done"** | Verify each step of multi-step tasks. |

Read the full rule descriptions with examples: **[RULES.md](RULES.md)**

---

## Choose Your Level

**Just started with AI coding?** Start with Tier 1 (rules 1-3). Copy one file. That's enough to prevent the worst disasters.

**Been burned already?** Use all 12 rules. They're all in the quickstart file.

**Running a team?** Version-control the rule file in your repo so everyone shares the same rules. See `presets/team.md` for team-specific additions.

**Want self-improving systems?** Add the autoresearch preset: rules for defining metrics, measuring baselines, running experiments, and shipping based on evidence. See `presets/autoresearch.md`.

---

## How It Works

AI coding tools read instruction files at the start of every conversation. The instructions shape how the AI behaves: what it checks before editing, how it handles ambiguity, when it stops and asks.

| Tool | Project file | Global file |
|------|-------------|-------------|
| Cursor (new) | `.cursor/rules/*.mdc` | `~/.cursor/rules/*.mdc` |
| Cursor (legacy) | `.cursorrules` | Settings > Rules for AI |
| Claude Code | `CLAUDE.md` | `~/.claude/CLAUDE.md` |
| Replit | `replit.md` | -- |
| Windsurf | `.windsurfrules` | Settings > Rules for AI |
| GitHub Copilot | `.github/copilot-instructions.md` | -- |

**Project rules** apply to one project. **Global rules** apply to every project you open with that tool. Install globally so the rules follow you everywhere. Install per-project to version-control them with your team.

The rules are the same across all formats. Only the file location and metadata differ.

For Cursor specifically: the `.mdc` format includes `alwaysApply: true` in the frontmatter, which means the rules are active in every session. Without this flag, rules may silently not apply.

---

## FAQ

**Do these slow down the AI?**
No. The verification steps add a few seconds per edit. The rework they prevent saves hours.

**Can I customize these?**
Yes. Start with the defaults. After a week of use, add project-specific rules for your stack, your conventions, your team's patterns.

**Do I need all 12?**
No. Start with Tier 1 (rules 1-3). Add more when you're ready. Even one rule -- Checkpoint -- prevents the worst outcome.

**What if the AI ignores a rule?**
It happens, especially with complex requests. That's why Checkpoint is rule 1. If the agent makes a mess, you can always revert to the last commit.

**Why not just use git?**
Git is the safety net. The rules prevent the falls. Without the rules, you'll spend your time reverting. With them, you'll rarely need to.

**Where did these come from?**
500+ hours of production work with AI coding tools across real projects. Every rule has a specific failure behind it. See `examples/disasters.md` for the stories.

---

## Project Structure

```
ai-coding-rules/
  README.md                 You are here
  RULES.md                  All 12 rules with full descriptions
  LICENSE                   MIT

  guides/
    spec-driven.md          Spec-driven development methodology

  quickstart/               Copy one file and go
    QUICKSTART.md           Setup instructions per tool
    cursor-rules.mdc        Cursor (new format)
    cursorrules.txt         Cursor (legacy format)
    claude-code-rules.md    Claude Code
    replit-rules.md         Replit
    windsurf-rules.md       Windsurf
    copilot-instructions.md GitHub Copilot

  presets/                  Curated subsets
    beginner.md             Rules 1-5 only
    team.md                 All 12 + collaboration rules
    autoresearch.md         Rules 13-19: self-improving systems

  examples/
    disasters.md            Real failure stories
```

---

## Contributing

If you've been burned by an AI coding agent and the rule that would have saved you isn't here, [open an issue](https://github.com/chickensintrees/ai-coding-rules/issues).

Rules must be:
- **Derived from a real failure.** Not theoretical. What happened?
- **Actionable.** The AI agent can follow it without human intervention.
- **Universal.** Works across tools, languages, and frameworks.

---

## License

MIT. Use these rules in any project, commercial or otherwise.

---

*Built by [Bill Moore](https://livefromhyper.space) and [STEF](https://livefromhyper.space). These rules were learned the hard way so you don't have to.*
