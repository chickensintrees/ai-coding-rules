#!/bin/bash
# AI Coding Rules — Self-installer
# Usage: curl -fsSL https://raw.githubusercontent.com/livefromhyperspace/ai-coding-rules/main/install.sh | bash
#
# Detects your AI coding tool and installs the right rules file.
# Run from your project root.

set -e

REPO_BASE="https://raw.githubusercontent.com/chickensintrees/ai-coding-rules/main"

echo "AI Coding Rules — Installing..."
echo ""

installed=0

# Cursor (new format — preferred)
if command -v cursor &>/dev/null || [ -d ".cursor" ] || [ -f ".cursorrules" ]; then
    mkdir -p .cursor/rules
    curl -fsSL "$REPO_BASE/quickstart/cursor-rules.mdc" -o .cursor/rules/ai-coding-rules.mdc
    echo "  Cursor:      .cursor/rules/ai-coding-rules.mdc"
    installed=1
fi

# Claude Code
if command -v claude &>/dev/null || [ -f "CLAUDE.md" ]; then
    if [ -f "CLAUDE.md" ]; then
        # Append to existing CLAUDE.md
        echo "" >> CLAUDE.md
        echo "# --- AI Coding Rules (auto-installed) ---" >> CLAUDE.md
        echo "" >> CLAUDE.md
        curl -fsSL "$REPO_BASE/quickstart/claude-code-rules.md" >> CLAUDE.md
        echo "  Claude Code: Appended to existing CLAUDE.md"
    else
        curl -fsSL "$REPO_BASE/quickstart/claude-code-rules.md" -o CLAUDE.md
        echo "  Claude Code: CLAUDE.md"
    fi
    installed=1
fi

# Windsurf
if command -v windsurf &>/dev/null || [ -f ".windsurfrules" ]; then
    curl -fsSL "$REPO_BASE/quickstart/windsurf-rules.md" -o .windsurfrules
    echo "  Windsurf:    .windsurfrules"
    installed=1
fi

# GitHub Copilot
if [ -d ".github" ] || [ -f ".github/copilot-instructions.md" ]; then
    mkdir -p .github
    curl -fsSL "$REPO_BASE/quickstart/copilot-instructions.md" -o .github/copilot-instructions.md
    echo "  Copilot:     .github/copilot-instructions.md"
    installed=1
fi

# If nothing detected, install for the most common tools
if [ $installed -eq 0 ]; then
    echo "  No AI coding tool detected. Installing for Cursor + Claude Code..."
    mkdir -p .cursor/rules
    curl -fsSL "$REPO_BASE/quickstart/cursor-rules.mdc" -o .cursor/rules/ai-coding-rules.mdc
    curl -fsSL "$REPO_BASE/quickstart/claude-code-rules.md" -o CLAUDE.md
    echo "  Cursor:      .cursor/rules/ai-coding-rules.mdc"
    echo "  Claude Code: CLAUDE.md"
fi

echo ""
echo "Done. Start a new AI session to activate the rules."
echo "Full docs: https://github.com/chickensintrees/ai-coding-rules"
