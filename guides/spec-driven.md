# Spec-Driven Development

A guide to using specifications as the primary artifact in AI-assisted coding.

---

## The Problem

AI coding agents default to building. You describe what you want, they start writing code. This works for small, one-shot tasks. It falls apart for anything with multiple parts, evolving requirements, or more than one session.

The failure mode: you iterate on the code directly. Each change is a conversation message. The agent builds from its understanding of the conversation, not from a durable document. Corrections get acknowledged but not recorded. After three sessions, nobody knows what the system is supposed to do -- not you, not the agent, not anyone who joins the project later.

This is sometimes called "vibe coding." It works until it doesn't.

## The Alternative

Spec-driven development treats the specification as the primary artifact. The code is a product of the spec. Changes go to the spec first, then to code.

The difference:

- **Vibe coding:** "Add a login page" -> agent writes code -> you iterate on the code
- **Spec-driven:** "Add a login page" -> agent writes/updates the spec -> you approve the spec -> agent writes code that matches the spec

The spec is not documentation. It is not a readme. It is the contract between you and the agent about what gets built and how it behaves.

---

## The Workflow

### Starting a new project

1. Before any code, create a spec file. `SPEC.md` in the project root, or `docs/spec.md` for larger projects.
2. The spec answers: What does this do? What are the inputs and outputs? What does each screen/endpoint/component do? What does "done" look like?
3. You don't need to write the spec yourself. Tell the agent: "Interview me about what I want to build. Ask me questions one at a time. When you have enough, write a complete spec to SPEC.md."
4. Review the spec. Edit it. The spec is yours. Approve it. Then start building.

### Making changes

When the user asks for a change (new feature, bug fix, behavior change):

1. Agent reads the current spec
2. Agent updates the spec to reflect the change
3. User confirms the spec update
4. Agent updates the code to match the spec

The spec changes first. Always. If the agent makes a code change without updating the spec, the spec and code are now out of sync. That sync is the whole point.

### Giving corrections

When you tell the agent "that's wrong, it should do X instead":

1. The agent updates the spec (the requirement changes)
2. Then updates the code (the implementation changes)

Never: agent says "got it" and only changes the code. The next session, or the next agent, will read the spec and build from the old requirement.

### Multiple sessions

This is where spec-driven development pays off. Every new session starts by reading the spec. The agent knows what the system is supposed to do because it's written down. No conversation history needed. No context loss.

---

## What Goes in the Spec

A spec is not a novel. Keep it scannable. For most projects:

- **Overview:** One paragraph. What this is and who it's for.
- **Features:** What the system does, as a list. Not how -- what.
- **Behavior:** For each feature, what happens when the user does X? What are the edge cases? What errors are possible?
- **Technical decisions:** Framework, database, key architectural choices and why.
- **Status:** What's built, what's not, what's next.

The format doesn't matter much. Markdown is fine. Numbered lists are fine. The point is: it exists, it's current, and the agent reads it before building.

---

## Getting Started

### The interview method

The fastest way to create a spec from scratch. Tell your AI agent:

> Interview me about what I want to build. Ask me one question at a time. When you have enough information, write a complete spec to SPEC.md.

The agent asks questions. You answer. The agent synthesizes your answers into a structured document. You review and edit. This takes 5-15 minutes and saves hours of building the wrong thing.

### The retrofit method

Already have code but no spec? Tell your agent:

> Read the codebase and write a spec that describes what this project currently does. Put it in SPEC.md. Include what's built, what's working, and what's incomplete.

Now you have a baseline. Future changes flow through the spec.

---

## Platform-Specific Setup

The spec-first principle is the same everywhere. The enforcement mechanism differs.

### Cursor

Create `.cursor/rules/spec-first.md` with `alwaysApply: true` in the frontmatter:

```yaml
---
description: Enforce spec-driven development workflow
alwaysApply: true
---

Before implementing any change, read SPEC.md (or docs/spec.md). When the user
requests a change, update the spec first, then implement. If SPEC.md doesn't
exist for a non-trivial project, create it before writing code. The spec is the
single source of truth.
```

### Claude Code

Add to your `CLAUDE.md`:

```
## Spec-Driven Development
The spec file (SPEC.md) is the single source of truth for this project.
Read it before implementing any feature. Update it before changing code.
When I give a correction, update the spec first, then the code.
```

Claude Code also supports Plan Mode (Shift+Tab) for exploring and refining specs before implementation.

### Replit Agent

Add to your `replit.md`:

```
## Spec-Driven Development
Before implementing changes, read SPEC.md for the current project specification.
When changes are requested, update SPEC.md first to reflect the new requirements,
then implement code to match. Use Plan mode for complex changes.
```

Replit Agent also has Plan Mode -- use it to review and refine specs before the agent starts building.

### Windsurf

Add to your `.windsurfrules`:

```
Before implementing any change, read SPEC.md. When the user requests a change,
update the spec first, then implement. The spec is the single source of truth.
```

### GitHub Copilot

Add to your `.github/copilot-instructions.md`:

```
Before implementing changes, read SPEC.md for project specifications.
When changes are requested, update the spec first, then implement code to match.
```

---

## Why This Works

1. **Durability.** Conversation context disappears between sessions. Spec files persist.
2. **Alignment.** When you review a spec update, you catch misunderstandings before they become code.
3. **Continuity.** New sessions, new agents, new team members -- they all read the same spec.
4. **Accountability.** "Does the code match the spec?" is a testable question. "Does the code match what I described in a chat three days ago?" is not.

The spec is the new design document. You iterate on the spec. The code is the output.

---

## Common Objections

**"This adds overhead."**
Creating a spec takes 5-15 minutes. Rebuilding something the agent misunderstood takes hours. The spec is the faster path, not the slower one.

**"My project is too small for a spec."**
If the project fits in one file and one session, skip the spec. The moment it spans multiple files or sessions, you need one.

**"The agent doesn't follow the spec anyway."**
That's what the other 11 rules are for. Checkpoint, Save Means Verify, and Don't Trust "Done" catch the drift. The spec gives you something to verify against.

**"I don't know what I want yet."**
Perfect. The interview method helps you figure it out. The spec is not a commitment. It's a snapshot of your current best understanding. It changes as you learn.

---

*This guide is part of [AI Coding Rules](https://github.com/chickensintrees/ai-coding-rules). The spec-first principle is Rule 5.*
