# How to Install

## Option 1: One-liner (terminal)

```bash
curl -fsSL https://raw.githubusercontent.com/chickensintrees/ai-coding-rules/main/install.sh | bash
```

Auto-detects your tools (Cursor, Claude Code, Windsurf, Copilot) and installs the right file.

## Option 2: Tell your AI agent

Paste this into Cursor, Claude Code, or any AI coding tool:

> Install AI coding rules from https://github.com/chickensintrees/ai-coding-rules — read the README, download the correct rules file for this tool, and install it into this project.

The agent will read the repo, identify the right file for your tool, and copy it into place.

## Option 3: Manual

See [quickstart/QUICKSTART.md](quickstart/QUICKSTART.md) for copy-paste instructions per tool.

## Updating

Re-run the install command. It will overwrite the existing rules file with the latest version. For Claude Code, it appends to your existing CLAUDE.md rather than overwriting.

## Uninstalling

Delete the rules file:

| Tool | File to delete |
|------|---------------|
| Cursor | `.cursor/rules/ai-coding-rules.mdc` |
| Claude Code | Remove the "AI Coding Rules" section from `CLAUDE.md` |
| Windsurf | `.windsurfrules` |
| Copilot | `.github/copilot-instructions.md` |
