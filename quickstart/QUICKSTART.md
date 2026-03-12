# Get Protected in 60 Seconds

Pick your tool. Copy one file. Done.

---

## Cursor (new format, recommended)

```
mkdir -p .cursor/rules
cp cursor-rules.mdc .cursor/rules/ai-coding-rules.mdc
```

Or copy the contents of `cursor-rules.mdc` into a new file at `.cursor/rules/ai-coding-rules.mdc` in your project.

Start a new Cursor session. The rules are active.

---

## Cursor (legacy format)

Copy the contents of `cursorrules.txt` into a file called `.cursorrules` at the root of your project.

---

## Claude Code

Copy the contents of `claude-code-rules.md` into the `CLAUDE.md` file at the root of your project. If you don't have one, create it.

---

## Windsurf

Copy the contents of `windsurf-rules.md` into a file called `.windsurfrules` at the root of your project.

---

## Replit

Copy the contents of `replit-rules.md` into the `replit.md` file at the root of your project. If you have an existing `replit.md`, append the rules to it.

---

## GitHub Copilot

Copy the contents of `copilot-instructions.md` into `.github/copilot-instructions.md` in your project.

---

## Global Rules (all projects, Cursor)

Go to Cursor Settings > General > Rules for AI. Paste the contents of `cursor-rules.mdc` (without the YAML frontmatter) into the text box. These rules will apply to every project.

---

## Global Rules (all projects)

To apply these rules to every project you open, install them globally:

| Tool | Global location |
|------|----------------|
| Cursor | `~/.cursor/rules/ai-coding-rules.mdc` |
| Claude Code | Append to `~/.claude/CLAUDE.md` |
| Replit | No global option -- install per project |
| Windsurf | Paste into Settings > Rules for AI |
| Copilot | No global option -- install per project |

Or run: `curl -fsSL https://raw.githubusercontent.com/chickensintrees/ai-coding-rules/main/install.sh | bash -s -- --global`

---

## What did I just install?

12 rules that prevent the most common AI coding disasters: deleted work, phantom saves, over-engineering, fix-break loops. Read [RULES.md](../RULES.md) for the full list with explanations.

**The short version:** Your AI assistant will now read before it writes, commit before it changes, verify before it claims "done," and ask before it deletes. The spec is the source of truth -- the agent updates the spec before it updates the code. That's the floor. Everything above that is quality of life.
