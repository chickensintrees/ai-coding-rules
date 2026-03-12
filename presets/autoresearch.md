# Autoresearch Rules (Advanced)

For power users building self-improving systems. These rules encode the autoresearch pattern: define a metric, measure a baseline, make one change, measure again, keep or discard based on evidence.

Use these on top of the core 12 rules. The core rules prevent disasters. These rules make the work get measurably better over time.

Inspired by Andrej Karpathy's [autoresearch](https://github.com/karpathy/autoresearch) framework and adapted for general AI-assisted development.

Copy this into your AI coding tool's instruction file alongside the core rules. See the quickstart for your tool's file location.

---

## 13. Define the Metric Before You Start

Before optimizing anything, define what "better" means as a number. Not "faster" -- how many milliseconds. Not "fewer bugs" -- how many issues per audit. Not "better quality" -- what specific score on what specific rubric. Write the metric down in the spec. If you can't define what better means numerically, you're not ready to optimize.

## 14. Measure the Baseline

Before making any change intended to improve something, measure the current state against your metric. Record the number. This is the baseline. Everything after this is measured against it. Without a baseline, you cannot distinguish improvement from noise. "It seems better" is not data.

## 15. One Experiment at a Time

Each improvement attempt is an experiment. Change one thing. Measure the result against the baseline. If the number improves and nothing else gets worse, keep the change. If it doesn't improve, or if it fixes one thing but breaks another, discard it and try a different approach. Do not bundle multiple changes into one experiment -- if the number improves, you won't know which change helped.

## 16. Log Every Experiment

Maintain an experiment log. For each experiment, record: what you changed, why you expected it to help, what the metric was before, what the metric was after, and whether you kept or discarded the change. The log is the product, not just the final result. Failed experiments are data. They map the problem space and prevent repeating approaches that don't work.

## 17. Automate the Measurement

If evaluation requires manual effort, you'll do it for the first few experiments and then stop. Automate the measurement: a script, an audit, a test suite, a scoring function. The measurement should run in seconds, not minutes. This is what makes it possible to run five experiments in a session instead of one. If you can't fully automate the measurement, automate as much as possible and minimize the manual part.

## 18. Failed Experiments Are Data

When an experiment doesn't improve the metric, do not treat it as a failure. Record what you tried and what happened. Two important signals come from failed experiments: (1) the approach was wrong, which narrows the search space, and (2) sometimes the diagnosis was wrong -- the thing you thought was the problem wasn't. Both are valuable. If three consecutive experiments fail to move the metric, question the metric itself or the diagnosis, not just the approach.

## 19. Ship Based on Evidence

Do not ship changes based on intuition about whether they helped. Ship based on measured improvement. If you made a change that "seems obviously right" but the metric didn't move, the change either didn't work or isn't measuring what you think it is. Either way, don't ship it until you understand why.

---

## Setting Up the Loop

The autoresearch pattern works at three levels:

**Project level.** Define quality metrics for what you're building. Bug count, audit score, response time, user satisfaction score, test pass rate. Measure, change, measure again.

**Process level.** Measure how you work. Correction rate (how often does the agent make the same mistake twice?). Rework rate (how much time is spent redoing work?). Sessions to ship (how many sessions does a feature take?). If these numbers aren't going down, your process isn't improving.

**Meta level.** Is the way you work getting better? Are sessions more productive? Are you spending less time on rework and more on new problems? This is the hardest to measure and the most valuable.

### Quick start

1. Pick one thing to improve. Not five. One.
2. Define the metric. Write it in the spec.
3. Measure the baseline. Record the number.
4. Make one change. Measure again.
5. Keep or discard. Log the result.
6. Repeat.

---

*These rules are part of [AI Coding Rules](https://github.com/chickensintrees/ai-coding-rules). Start with the [core 12 rules](../RULES.md) if you haven't already.*
