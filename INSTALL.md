# How to Install

## Option 1: One-liner (terminal)

**Project-level** (this project only):
```bash
curl -fsSL https://raw.githubusercontent.com/chickensintrees/ai-coding-rules/main/install.sh | bash
```

**Global** (all your projects):
```bash
curl -fsSL https://raw.githubusercontent.com/chickensintrees/ai-coding-rules/main/install.sh | bash -s -- --global
```

Auto-detects your tools (Cursor, Claude Code, Replit, Windsurf, Copilot) and installs the right file.

## Option 2: Tell your AI agent

Paste this into Cursor, Claude Code, Replit, or any AI coding tool:

> Install AI coding rules from https://github.com/chickensintrees/ai-coding-rules -- read the README, download the correct rules file for this tool, and install it into this project. Then help me add these rules to my global rules file so they apply to all my projects.

The agent will read the repo, identify the right file for your tool, and copy it into place.

### Global rules locations

Tell your agent to install the rules to these locations for global coverage:

| Tool | Global location |
|------|----------------|
| Cursor | `~/.cursor/rules/ai-coding-rules.mdc` |
| Claude Code | `~/.claude/CLAUDE.md` (append) |
| Replit | No global option -- install per project via `replit.md` |
| Windsurf | Settings > Rules for AI (paste rules into the settings UI) |
| Copilot | No global option -- install per project |

## Option 3: Manual

See [quickstart/QUICKSTART.md](quickstart/QUICKSTART.md) for copy-paste instructions per tool.

## Project vs Global

**Project rules** live in your repo. They're version-controlled. Everyone on the team gets them. But they only apply to that project.

**Global rules** live in your home directory. They apply to every project you open. But they're not shared with your team.

**Best practice:** Install globally so the rules follow you everywhere. Also install per-project for team repos so everyone gets them.

## Updating

Re-run the install command. It will overwrite the existing rules file with the latest version. For Claude Code, it appends to your existing CLAUDE.md rather than overwriting (and skips if already installed).

## Uninstalling

Delete the rules file:

| Tool | Project file | Global file |
|------|-------------|-------------|
| Cursor | `.cursor/rules/ai-coding-rules.mdc` | `~/.cursor/rules/ai-coding-rules.mdc` |
| Claude Code | Remove "AI Coding Rules" section from `CLAUDE.md` | Remove from `~/.claude/CLAUDE.md` |
| Replit | Remove "AI Coding Rules" section from `replit.md` | -- |
| Windsurf | `.windsurfrules` | Remove from Settings |
| Copilot | `.github/copilot-instructions.md` | -- |
