# Goal Loops

A guide to running AI coding agents in a loop that stops when the work is *done* -- using the tools your agent already ships, not a homegrown framework.

---

## The Problem

An agent that does one turn and hands control back makes you the loop. "Run the tests." *fails.* "Fix it." *fixes one.* "Run them again." You are the `while` condition, retyping the same nudge until it's green.

The obvious fix -- "just repeat the prompt on a timer" -- is worse. A timer repeats whether or not there's anything to do, has no idea when it's finished, and will happily run all night. Repetition is not the hard part. **Knowing when to stop is the hard part.**

A good loop needs two things a bare repeat doesn't have:

1. **A goal** -- a verifiable end state, so the loop knows when it's done.
2. **A ceiling** -- a hard limit on turns/time/cost, so a loop that *can't* reach the goal still stops.

## Use the built-in loop, not a custom one

You do not need to build this. As of 2026 the major agents ship it. In Claude Code it's **`/goal`**:

```text
/goal all tests in test/auth pass and the lint step is clean
```

Claude keeps taking turns until the condition holds. Crucially, **a separate, faster model checks the condition after each turn** -- so "done" is judged by fresh eyes, not by the same model that just wrote the code and wants to believe it. That separation is the whole reason to use the official feature instead of asking the model "are you done yet?" (it will say yes).

Key properties worth knowing:

- **Verifiable conditions win.** Write the goal as something the agent's own output can prove: `"npm test exits 0"`, `"git status is clean"`, `"every file in src/ is under 300 lines"`. The evaluator reads the transcript; it doesn't run commands itself, so the agent has to surface the proof.
- **Bound it.** Add a stop clause to the condition: `... or stop after 20 turns`. This is your seatbelt for a goal that can't quite be reached.
- **It runs headless.** `claude -p "/goal ..."` runs the whole loop in one non-interactive invocation -- which is what makes scheduled and CI use possible.

> **Other tools:** the pattern is the same even where the command differs. Check your agent's docs for a "keep working until a condition is met" mode before writing your own loop.

## Ready-to-paste conditions

These cover the common autonomous-loop workflows. Paste one as your `/goal` condition and add a stop clause.

| Goal | Condition to paste |
|------|--------------------|
| **Speed** | `every page loads under 50ms in the perf report, measured the same way each run, or stop after 40 turns` |
| **Docs sync** | `every module and public API named in the docs exists in the code, and every shipped module is documented, or stop after 15 turns` |
| **Simplify / DRY** | `no duplicated logic remains across modules and every module has one clear responsibility, verified by a fresh read, or stop after 30 turns` |
| **Logging coverage** | `every request/job/external-call boundary logs entry, outcome, and errors with context, with a test asserting each, or stop after 30 turns` |
| **Error sweep** | `the production log query returns zero actionable errors; for each one found, root-cause it, fix it, add a regression test, or stop after 15 turns` |
| **SEO/GEO** | `the crawl report shows zero critical technical issues, re-crawled the same way each run, or stop after 20 turns` |
| **Product eval** | `every scenario in the eval suite passes its pre-defined success criteria on a full re-run; fix root causes, never the criteria, or stop after 30 turns` |

Two rules that keep any of these honest:

- **One bounded unit per turn.** Let the agent make the smallest meaningful change, then re-measure. Small steps keep each diff reviewable and each turn's effect on the metric legible.
- **Never lower the bar to end the loop.** If a goal is stubborn, hit the stop clause and report "not met" -- don't quietly weaken the condition. A loop that edits its own success criteria proves nothing.

## When you need a *hard* ceiling

`/goal`'s stop clause is judged by a model from the conversation -- good enough for interactive work, but it's a soft bound. If you're running unattended and a runaway loop would cost real money, use the **Claude Agent SDK**, whose limits are enforced by the tooling itself, not by a prompt:

```python
from claude_agent_sdk import query, ClaudeAgentOptions, ResultMessage

async for message in query(
    prompt="Refactor the auth module until tests pass",
    options=ClaudeAgentOptions(
        allowed_tools=["Read", "Edit", "Bash", "Glob", "Grep"],
        max_turns=30,          # hard ceiling on turns
        max_budget_usd=5.00,   # hard ceiling on spend
    ),
):
    if isinstance(message, ResultMessage) and message.subtype == "error_max_budget_usd":
        print("Stopped at budget. Nothing ran away.")
```

`max_turns` and `max_budget_usd` stop the loop unconditionally. That is the difference between "the prompt said to stop" and "the runtime stopped it."

## Scheduled loops that open a PR

For nightly work -- docs sweep, error triage -- run the goal headless in CI and let the result land as a **pull request, never a direct merge**. The agent proposes; a human still gates what ships. Sketch:

```yaml
# .github/workflows/nightly-docs.yml
on:
  schedule: [{ cron: "0 7 * * *" }]
  workflow_dispatch: {}
permissions: { contents: write, pull-requests: write }
jobs:
  docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm install -g @anthropic-ai/claude-code
      - run: claude -p "/goal every public API in the docs matches the code, or stop after 10 turns"
        env: { ANTHROPIC_API_KEY: "${{ secrets.ANTHROPIC_API_KEY }}" }
      - uses: peter-evans/create-pull-request@v6
        with: { branch: nightly-docs, title: "docs: nightly sweep", delete-branch: true }
```

The rule that outranks the schedule: **a loop nobody is watching proposes, it never merges.** Reading production logs at 3am is fine; merging your own fix to production at 3am is not.

## The short version

- Don't build a loop framework. Use `/goal` (or your agent's equivalent).
- Make the goal *verifiable* -- something the agent's output can prove.
- Always add a stop clause; use the Agent SDK's `max_budget_usd` when the ceiling has to be real.
- Scheduled loops open a PR. They never self-merge.

---

**Official docs:** [`/goal`](https://code.claude.com/docs/en/goal.md) · [`/loop` & scheduling](https://code.claude.com/docs/en/scheduled-tasks.md) · [Agent SDK loop](https://code.claude.com/docs/en/agent-sdk/agent-loop.md) · [Building Effective Agents](https://www.anthropic.com/research/building-effective-agents)
