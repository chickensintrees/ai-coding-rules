#!/bin/bash
# AI Coding Rules — Self-installer
# Usage: curl -fsSL https://raw.githubusercontent.com/chickensintrees/ai-coding-rules/main/install.sh | bash
#
# Detects your AI coding tool and installs the right rules file.
# Run from your project root for project-level install.
# Run with --global for user-level install (applies to all projects).

set -e

REPO_BASE="https://raw.githubusercontent.com/chickensintrees/ai-coding-rules/main"

GLOBAL=0
if [ "${1}" = "--global" ]; then
    GLOBAL=1
fi

if [ $GLOBAL -eq 1 ]; then
    echo "AI Coding Rules — Installing globally..."
else
    echo "AI Coding Rules — Installing for this project..."
fi
echo ""

installed=0

if [ $GLOBAL -eq 1 ]; then
    # Global install — user-level rules that apply to every project

    # Cursor (user-level rules directory)
    if command -v cursor &>/dev/null || [ -d "$HOME/.cursor" ]; then
        mkdir -p "$HOME/.cursor/rules"
        curl -fsSL "$REPO_BASE/quickstart/cursor-rules.mdc" -o "$HOME/.cursor/rules/ai-coding-rules.mdc"
        echo "  Cursor:      ~/.cursor/rules/ai-coding-rules.mdc (global)"
        installed=1
    fi

    # Claude Code (user-level CLAUDE.md)
    if command -v claude &>/dev/null || [ -d "$HOME/.claude" ]; then
        mkdir -p "$HOME/.claude"
        if [ -f "$HOME/.claude/CLAUDE.md" ]; then
            # Check if already installed
            if grep -q "AI Coding Rules" "$HOME/.claude/CLAUDE.md" 2>/dev/null; then
                echo "  Claude Code: Already in ~/.claude/CLAUDE.md (skipped)"
            else
                echo "" >> "$HOME/.claude/CLAUDE.md"
                echo "# --- AI Coding Rules (auto-installed) ---" >> "$HOME/.claude/CLAUDE.md"
                echo "" >> "$HOME/.claude/CLAUDE.md"
                curl -fsSL "$REPO_BASE/quickstart/claude-code-rules.md" >> "$HOME/.claude/CLAUDE.md"
                echo "  Claude Code: Appended to ~/.claude/CLAUDE.md (global)"
            fi
        else
            curl -fsSL "$REPO_BASE/quickstart/claude-code-rules.md" -o "$HOME/.claude/CLAUDE.md"
            echo "  Claude Code: ~/.claude/CLAUDE.md (global)"
        fi
        installed=1
    fi

    if [ $installed -eq 0 ]; then
        echo "  No AI coding tool detected globally."
        echo "  Supported: Cursor (~/.cursor), Claude Code (~/.claude)"
        echo ""
        echo "  For project-level install, run without --global from your project root."
    fi

else
    # Project-level install

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
            if grep -q "AI Coding Rules" "CLAUDE.md" 2>/dev/null; then
                echo "  Claude Code: Already in CLAUDE.md (skipped)"
            else
                echo "" >> CLAUDE.md
                echo "# --- AI Coding Rules (auto-installed) ---" >> CLAUDE.md
                echo "" >> CLAUDE.md
                curl -fsSL "$REPO_BASE/quickstart/claude-code-rules.md" >> CLAUDE.md
                echo "  Claude Code: Appended to existing CLAUDE.md"
            fi
        else
            curl -fsSL "$REPO_BASE/quickstart/claude-code-rules.md" -o CLAUDE.md
            echo "  Claude Code: CLAUDE.md"
        fi
        installed=1
    fi

    # Replit
    if [ -f ".replit" ] || [ -f "replit.nix" ]; then
        if [ -f "replit.md" ]; then
            if grep -q "AI Coding Rules" "replit.md" 2>/dev/null; then
                echo "  Replit:      Already in replit.md (skipped)"
            else
                echo "" >> replit.md
                echo "# --- AI Coding Rules (auto-installed) ---" >> replit.md
                echo "" >> replit.md
                curl -fsSL "$REPO_BASE/quickstart/replit-rules.md" >> replit.md
                echo "  Replit:      Appended to existing replit.md"
            fi
        else
            curl -fsSL "$REPO_BASE/quickstart/replit-rules.md" -o replit.md
            echo "  Replit:      replit.md"
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
fi

echo ""
echo "Done. Start a new AI session to activate the rules."
echo ""
echo "Tip: Run with --global to install rules that apply to ALL your projects."
echo "Full docs: https://github.com/chickensintrees/ai-coding-rules"
