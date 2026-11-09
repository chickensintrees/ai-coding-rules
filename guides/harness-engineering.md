# Harness Engineering

A guide to building the setup around an AI coding agent -- the rules, specs, skills, tools and checks that turn raw capability into useful work under your control.

---

## The Problem

A capable agent with no direction is a strong horse in an open field. It has plenty of power. It goes wherever it likes. It does not pull your cart.

You see this the first time you hand an agent a real project. It writes a lot of code fast. It picks its own conventions. It forgets yesterday's decisions. It says "done" when the tests have never run. The next session, or the next agent, starts from zero and does it differently.

The model is not the problem. The missing piece is everything around the model: what it reads first, what it is allowed to do, how its work gets checked, and when it stops. That is the harness.

## The Word

"Harness" comes from Old French *harneis*, "equipment" -- the gear of a man-at-arms, and the fittings for a draft animal. In English, the sense of fittings for a horse or other beast of burden dates to the early 14th century. ([Etymonline](https://www.etymonline.com/word/harness), [Merriam-Webster](https://www.merriam-webster.com/dictionary/harness))

A harness does one job. It connects a source of power to a load, under a driver's control. The horse supplies the pull. The harness transfers it to the cart. The reins let the driver steer, slow and stop. Without the harness, the power goes nowhere useful. Without the reins, it goes somewhere you didn't choose.

## The Analogy

| Horse and cart | AI coding |
|----------------|-----------|
| The horse | The model. Raw power. |
| The harness | Rules, skills, tools, specs and checks. |
| The cart | The work: the product, the repo, the shipped change. |
| The driver | You. You decide where it goes and when it stops. |

Two things follow. A better horse does not fix a bad harness. And the same horse pulls very differently in a good one. OpenAI's Codex team found that slow early progress came from an underspecified environment, not from the model. ([OpenAI](https://openai.com/index/harness-engineering/))

"Harness engineering" is the name that settled on this work in 2025-2026. OpenAI's Codex team describes building a large product where agents wrote the code and the engineers' main job became designing the environment: the repo map, the `AGENTS.md`, the architectural rules and the checks. ([OpenAI, "Harness engineering: leveraging Codex in an agent-first world"](https://openai.com/index/harness-engineering/)) Anthropic describes the same idea for long-running work: each session starts with no memory, so the harness has to leave a durable trail -- a feature list, a progress file, git commits -- that the next session reads first. ([Anthropic, "Effective harnesses for long-running agents"](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents))

---

## Anatomy of a Harness

A harness has five parts. Most of them are plain files in your repo.

### 1. The instruction file (the rules)

What the agent reads at the start of every session. How to behave, what to check, when to ask. The 12 rules in this repo are a ready-made instruction file.

| Tool | Project file | Global file |
|------|-------------|-------------|
| Codex (and other AGENTS.md readers) | `AGENTS.md` | `~/.codex/AGENTS.md` |
| Claude Code | `CLAUDE.md` | `~/.claude/CLAUDE.md` |
| Cursor | `.cursor/rules/*.mdc` | `~/.cursor/rules/*.mdc` |
| Replit | `replit.md` | -- |
| Windsurf | `.windsurfrules` | Settings > Rules for AI |
| GitHub Copilot | `.github/copilot-instructions.md` | -- |

**One file, many tools.** `AGENTS.md` is an open format read by Codex, Cursor, GitHub Copilot's coding agent, Zed and others. ([agents.md](https://agents.md/)) Codex reads the global file first, then each `AGENTS.md` from the repo root down to the directory you're working in. ([Codex docs](https://developers.openai.com/codex/guides/agents-md)) Claude Code reads `CLAUDE.md`. Recent versions fall back to `AGENTS.md` only when no `CLAUDE.md` exists. The safe pattern is a `CLAUDE.md` that contains one line:

```
@AGENTS.md
```

That imports the shared file. ([Claude Code memory docs](https://code.claude.com/docs/en/memory)) Write the rules once in `AGENTS.md`. Point every other tool's file at it, or keep the other files short.

### 2. The spec (the source of truth)

`SPEC.md`. What the product does and what "done" looks like. The agent reads it before building and updates it before changing code. See [Spec-Driven Development](spec-driven.md).

### 3. Skills (repeatable procedures)

A skill is a folder with a `SKILL.md` file: a name, a description of when to use it, and step-by-step instructions. The agent loads it when the task matches. Use skills for the jobs people do over and over -- "add a new data record", "open a pull request the right way".

| Tool | Repo-level skills directory |
|------|----------------------------|
| Codex | `.agents/skills/` |
| Claude Code | `.claude/skills/` |
| Cursor | Reads `.agents/skills/`, `.cursor/skills/`, `.claude/skills/` |

The `SKILL.md` format is shared across these tools ([agentskills.io](https://agentskills.io/), [Codex skills](https://developers.openai.com/codex/skills), [Claude Code skills](https://code.claude.com/docs/en/skills)). If your team uses more than one tool, keep identical copies in `.agents/skills/` and `.claude/skills/`. Check your tool's docs: skills directories are still changing.

### 4. Tools (what the agent can reach)

The terminal, the test runner, the browser, and -- most important for teams -- GitHub. What the agent can touch defines what it can do. Give it what the job needs. Nothing more.

### 5. Checks (the safeguards)

Tests, lint, type checks, and CI. One command that answers "is this done?" -- for example `npm run check`. See the next section.

---

## Instructions Explain, Safeguards Enforce

A rule in `AGENTS.md` is a request. The agent usually follows it. Sometimes it doesn't -- a long session, a complex request, a confident mistake.

A test is different. It runs. It passes or it fails. It does not care how confident the agent is.

So every rule that matters gets two forms:

| The instruction (explains) | The safeguard (enforces) |
|----------------------------|--------------------------|
| "Run the tests before saying done." | CI runs the tests on every pull request. Red blocks the merge. |
| "Every data record needs a source." | A data-integrity test fails if any record has no source. |
| "Match the code style." | A linter fails the build on style errors. |
| "Never push to main." | Branch protection rejects direct pushes to main. |
| "Don't say done until it's verified." (Rule 12) | One command -- `npm run check` -- is the definition of done. |

Instructions tell the agent what you want and why. Safeguards catch it when it doesn't. You need both. Instructions alone drift. Safeguards alone are confusing -- the agent fails a check without knowing what it was for.

**What it prevents:** An agent reports success on work that was never checked, and the mistake reaches everyone else on the repo.

---

## Harnesses for Teams of Agents and People

One person with one agent is the easy case. The real shift is many people and many agents working on one repo at the same time. A student's agent in one city. A reviewer's agent somewhere else. A nightly agent cleaning up docs. A human approving merges.

They never share a conversation. They share the repo. So the repo has to carry everything they need to agree on.

| What the team needs | Where it lives |
|---------------------|----------------|
| **A shared contract** -- how every agent behaves | `AGENTS.md` (and `CLAUDE.md` importing it) |
| **A shared truth** -- what the product is | `SPEC.md` |
| **A unit of work** | An issue. One chunk of work, one issue. |
| **A workspace** | One branch per issue. Never main. |
| **A conversation** | Issue comments, PR comments, review comments, and agent-to-agent messages |
| **An integration point** | The pull request. Every change enters through one. |
| **A referee** | CI and tests. They run on every PR, the same way, for everyone. |
| **A decision-maker** | A human. A person approves what merges. |

The flow looks the same for every contributor, human or agent:

1. Pick an issue. Read `AGENTS.md` and `SPEC.md`.
2. Create a branch for that issue.
3. If the change alters what the product does, update `SPEC.md` first.
4. Make the change. Run the check command locally.
5. Open a pull request. Describe what changed and how it was verified.
6. CI runs. Reviewers -- people and agents -- comment on the PR.
7. Fix what the comments and CI ask for, on the same branch.
8. A human approves and merges.

Nobody needs to be online at the same time. Nobody needs to remember what anyone said. The issue says what to do. The spec says what's true. The PR shows what changed. CI says whether it works.

### Connect the agent to GitHub

This is the step that makes the whole flow work. Once the agent can reach GitHub, it can do the git for you: create the branch, commit, push, open the pull request, read the review comments, and fix what CI flags. You decide and approve. The agent does the mechanics.

There are three common ways to connect it:

- **The GitHub CLI.** Run `gh auth login` and sign in through the browser. The agent then uses `gh` from the terminal. ([GitHub CLI](https://cli.github.com/manual/gh_auth_login))
- **GitHub's MCP server.** Gives agents that support MCP direct access to issues, branches and pull requests. ([github/github-mcp-server](https://github.com/github/github-mcp-server))
- **The tool's own GitHub connection.** Many agents -- Codex, Claude Code on the web, Copilot, Replit -- connect to GitHub from their own settings.

An agent that can push can also push the wrong thing. The harness is what makes this safe. Put these in your `AGENTS.md`:

- **Never push to main.** Work on a branch. Open a PR.
- **Ask before any public action.** Opening a PR, commenting on an issue, or merging is visible to other people. Confirm first.
- **Never ask for tokens or passwords in chat.** Sign in through the browser or the tool's settings. Secrets never go in a message or a file.
- **A human merges.** The agent proposes. A person approves.

Then back them with safeguards: branch protection on main, required CI checks, and required review.

**What it prevents:** Two agents overwrite each other's work on main. A token gets pasted into a chat log. An unreviewed change ships because nobody had to approve it.

---

## How This Repo's Pieces Compose

This repo gives you three parts of a harness. Each answers a different question.

| Piece | Question it answers | Where |
|-------|---------------------|-------|
| **The 12 rules** | How should the agent behave? | [RULES.md](../RULES.md), installed as `AGENTS.md` / `CLAUDE.md` / etc. |
| **Spec-driven development** | What is the source of truth? | [spec-driven.md](spec-driven.md), `SPEC.md` in your project |
| **Goal loops** | When does the agent stop? | [goal-loops.md](goal-loops.md), `/goal` with a verifiable condition |

The rules govern behavior: commit, read before writing, verify, ask. The spec keeps everyone -- every session, every agent, every person -- building the same thing. Goal loops give the work a verifiable end state and a ceiling, so the agent keeps going until it's done and no further.

Add your checks -- tests, lint, CI -- and you have the whole harness: behavior, truth, stopping condition, and enforcement.

---

## A Worked Example

[Agentic Marketing Toolkit](https://github.com/chickensintrees/agentic-marketing-toolkit) is a class-built suite of marketing and strategy tools. Each tool is a self-contained folder under `src/tools/<id>/` with its own spec. Five Forces Explorer is the first tool. Many students, each with their own agent, contribute to one repo.

Its harness:

| Part | In the repo |
|------|-------------|
| Shared contract | `AGENTS.md` -- the agent playbook and a student onboarding protocol. Links back here for the full rules. |
| Claude Code entry point | `CLAUDE.md` containing `@AGENTS.md` |
| Replit entry point | `replit.md` |
| Source of truth | A root `SPEC.md` for the suite, plus a `SPEC.md` per tool |
| Skills | Identical copies in `.agents/skills/` and `.claude/skills/`: `connect-github`, `start-contribution`, `add-industry`, `add-tool`, `propose-feature`, `verify-and-open-pr`, `respond-to-review` |
| Safeguards | Registry-integrity and data-integrity tests that check every student PR, and `npm run check` (lint, typecheck, tests, build) as the definition of done |
| Referee | CI on every pull request |
| Integration point | A pull request template that asks what changed and how it was verified |

A student's first contribution goes like this. They connect their agent to GitHub. The agent reads `AGENTS.md`, runs the onboarding steps, and picks up an issue. It creates a branch, makes the change, runs the check, and opens a PR using the template. CI runs the integrity tests. A reviewer comments. The agent fixes the comments on the same branch. A human merges.

The student never types a git command. They never break main. They do make every decision that matters.

---

## Build Your Own Harness in 30 Minutes

Work through this in order. Each step takes a few minutes.

- [ ] **Initialize git and push to GitHub.** Rule 1 needs something to commit to. (2 min)
- [ ] **Install the rules.** Run the [installer](../INSTALL.md) from your project root, or copy `quickstart/AGENTS.md` to `AGENTS.md`. (2 min)
- [ ] **Point every tool at one file.** If you use Claude Code, create `CLAUDE.md` containing `@AGENTS.md`. Keep other tools' files short or pointing to `AGENTS.md`. (2 min)
- [ ] **Write the spec.** Tell your agent: "Interview me about what I want to build. Ask one question at a time. Then write SPEC.md." Review it. (10 min)
- [ ] **Add project notes to `AGENTS.md`.** How to install, run and test. Where things live. What never to touch. (3 min)
- [ ] **Define "done" as one command.** For example `npm run check` that runs tests, lint and type checks. Write it in `AGENTS.md`. (3 min)
- [ ] **Add one safeguard for the rule you care most about.** One test that fails when it's broken. (3 min)
- [ ] **Turn on CI.** Run the check command on every pull request. (3 min)
- [ ] **Protect main.** Require a pull request and a passing check to merge. (1 min)
- [ ] **Add a PR template.** Ask: what changed, which spec section, how was it verified. (1 min)
- [ ] **Connect your agent to GitHub.** `gh auth login`, GitHub's MCP server, or the tool's own connection. Add the team rules above to `AGENTS.md`. (2 min)
- [ ] **Add one skill** for the task you repeat most. Optional on day one. Worth it by week two.

Then test it. Start a fresh session and ask the agent to make a small change and open a PR. Watch where it goes wrong. Each mistake is a missing rule, a missing check, or a gap in the spec. Fix the harness, not just the output.

---

## The Short Version

- The model is the power. The harness is everything that turns it into useful work. You are the driver.
- Put the rules in `AGENTS.md`. Put the truth in `SPEC.md`. Put "done" in one check command.
- Instructions explain. Safeguards enforce. Every rule that matters gets a test or a CI check.
- For teams: one issue, one branch, one PR. CI is the referee. A human merges.
- Connect the agent to GitHub so it does the git. Keep the harness rules that make that safe.

---

**Sources:** [OpenAI -- Harness engineering: leveraging Codex in an agent-first world (Feb 2026)](https://openai.com/index/harness-engineering/) · [Anthropic -- Effective harnesses for long-running agents (Nov 2025)](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) · [agents.md](https://agents.md/) · [Codex: AGENTS.md](https://developers.openai.com/codex/guides/agents-md) · [Codex: skills](https://developers.openai.com/codex/skills) · [Claude Code: memory and imports](https://code.claude.com/docs/en/memory) · [Etymonline: harness](https://www.etymonline.com/word/harness)

*This guide is part of [AI Coding Rules](https://github.com/chickensintrees/ai-coding-rules).*
