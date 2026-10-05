---
name: code-review
description: Review the changes since a fixed point (commit, branch, tag, or merge-base) along three axes — Standards (does the code follow this repo's documented coding standards?), Spec (does the code match what the originating issue/PRD asked for?), and Complexity (what could be deleted or shrunk — ponytail-style over-engineering hunt). Runs all three reviews in parallel sub-agents and reports them side by side. Use when the user wants to review a branch, a PR, work-in-progress changes, or asks to "review since X".
---

Three-axis review of the diff between `HEAD` and a fixed point the user supplies:

- **Standards** — does the code conform to this repo's documented coding standards?
- **Spec** — does the code faithfully implement the originating issue / PRD / spec?
- **Complexity** — is any of it useless? What could be deleted, reused, or replaced by stdlib / platform / an installed dependency? (After [ponytail](https://github.com/DietrichGebert/ponytail): the best code is the code never written.)

All axes run as **parallel sub-agents** so they don't pollute each other's context, then this skill aggregates their findings.

The issue tracker should have been provided to you — run `/setup-matt-pocock-skills` if `docs/agents/issue-tracker.md` is missing.

## Process

### 1. Pin the fixed point

Whatever the user said is the fixed point — a commit SHA, branch name, tag, `main`, `HEAD~5`, etc. If they didn't specify one, ask for it.

Capture the diff command once: `git diff <fixed-point>...HEAD` (three-dot, so the comparison is against the merge-base). Also note the list of commits via `git log <fixed-point>..HEAD --oneline`.

If the user wants the uncommitted working tree reviewed, use `git diff <fixed-point>` (two-arg, no `...HEAD`) plus `git status --porcelain` for untracked/staged-new files, and pass that instead.

Before going further, confirm the fixed point resolves (`git rev-parse <fixed-point>`) and the diff is non-empty. A bad ref or empty diff should fail here — not inside three parallel sub-agents.

### 2. Identify the spec source

Look for the originating spec, in this order:

1. Issue references in the commit messages (`#123`, `Closes #45`, GitLab `!67`, etc.) — fetch via the workflow in `docs/agents/issue-tracker.md`.
2. A path the user passed as an argument.
3. A PRD/spec file under `docs/`, `specs/`, or `.scratch/` matching the branch name or feature.
4. If nothing is found, ask the user where the spec is. If they say there isn't one, the **Spec** sub-agent will skip and report "no spec available".

### 3. Identify the standards sources

Anything in the repo that documents how code should be written, such as `CODING_STANDARDS.md` or `CONTRIBUTING.md`.

On top of whatever the repo documents, the Standards axis always carries the **smell baseline** below — a fixed set of Fowler code smells (_Refactoring_, ch.3) that applies even when a repo documents nothing. Two rules bind it:

- **The repo overrides.** A documented repo standard always wins; where it endorses something the baseline would flag, suppress the smell.
- **Always a judgement call.** Each smell is a labelled heuristic ("possible Feature Envy"), never a hard violation — and, like any standard here, skip anything tooling already enforces.

Each smell reads *what it is* → *how to fix*; match it against the diff:

- **Mysterious Name** — a function, variable, or type whose name doesn't reveal what it does or holds. → rename it; if no honest name comes, the design's murky.
- **Duplicated Code** — the same logic shape appears in more than one hunk or file in the change. → extract the shared shape, call it from both.
- **Feature Envy** — a method that reaches into another object's data more than its own. → move the method onto the data it envies.
- **Data Clumps** — the same few fields or params keep travelling together (a type wanting to be born). → bundle them into one type, pass that.
- **Primitive Obsession** — a primitive or string standing in for a domain concept that deserves its own type. → give the concept its own small type.
- **Repeated Switches** — the same `switch`/`if`-cascade on the same type recurs across the change. → replace with polymorphism, or one map both sites share.
- **Shotgun Surgery** — one logical change forces scattered edits across many files in the diff. → gather what changes together into one module.
- **Divergent Change** — one file or module is edited for several unrelated reasons. → split so each module changes for one reason.
- **Message Chains** — long `a.b().c().d()` navigation the caller shouldn't depend on. → hide the walk behind one method on the first object.
- **Refused Bequest** — a subclass or implementer that ignores or overrides most of what it inherits. → drop the inheritance, use composition.

(Speculative Generality and Middle Man belong to the **Complexity** axis — don't report them here.)

### 3b. The complexity ladder

The Complexity axis judges every added piece of the diff against the ponytail ladder — the first rung that holds is what the code *should* have been:

1. **Does this need to exist at all?** Not required by the spec or a real caller → delete it. (YAGNI)
2. **Already in this codebase?** A helper, util, type, or pattern a few files over → reuse it. Re-implementing what already lives here is the most common slop.
3. **Stdlib does it?** → use it.
4. **Native platform feature covers it?** `<input type="date">` over a picker lib, CSS over JS, DB constraint over app code, framework built-in over hand-rolled.
5. **Already-installed dependency solves it?** → use it. A new dependency for what a few lines can do is a finding.
6. **Can it be one line?** → one line.
7. **Only then:** the minimum code that works.

Tags for findings:

- `delete:` dead code, unused flexibility, speculative feature, config nobody sets. Replacement: nothing.
- `reuse:` re-implements something already in this repo. Name the existing symbol and its path.
- `stdlib:` hand-rolled thing the standard library ships. Name the function.
- `native:` dependency or code doing what the platform/framework already does. Name the feature.
- `yagni:` abstraction with one implementation, factory for one product, layer with one caller, wrapper that only delegates (Middle Man).
- `shrink:` same logic, fewer lines. Show the shorter form.

**Never on the chopping block** — do not flag for removal: input validation at trust boundaries, error handling that prevents data loss, security measures (auth, tenant isolation, escaping), accessibility basics, anything the spec explicitly requires, and one small test per non-trivial logic path. A documented repo standard that mandates a structure also wins over the ladder.
### 4. Spawn the sub-agents in parallel

Send a single message with three `Agent` tool calls (two if Spec is skipped). Use the `general-purpose` subagent for all of them.

**Standards sub-agent prompt** — include:

- The full diff command and commit list.
- The list of standards-source files you found in step 3, **plus the smell baseline from step 3** pasted in full — the sub-agent has no other access to it.
- The brief: "Report — per file/hunk where relevant — (a) every place the diff violates a documented standard: cite the standard (file + the rule); and (b) any baseline smell you spot: name it and quote the hunk. Distinguish hard violations from judgement calls — documented-standard breaches can be hard, but baseline smells are always judgement calls, and a documented repo standard overrides the baseline. Skip anything tooling enforces. Under 400 words."

**Spec sub-agent prompt** — include:

- The diff command and commit list.
- The path or fetched contents of the spec.
- The brief: "Report: (a) requirements the spec asked for that are missing or partial; (b) behaviour in the diff that wasn't asked for (scope creep); (c) requirements that look implemented but where the implementation looks wrong. Quote the spec line for each finding. Under 400 words."

**Complexity sub-agent prompt** — include:

- The diff command and commit list.
- The spec path/contents if one was found (so it can tell required from speculative).
- **The complexity ladder, tags, and never-on-the-chopping-block list from step 3b**, pasted in full.
- The brief: "You are the laziest senior dev in the room: find what this diff could delete. Read the changed files and grep the rest of the repo (and `package.json`/lockfile for installed deps) before claiming something is reinvented. For each added piece, climb the ladder; if a higher rung holds, report it. One line per finding: `<file>:L<line>: <tag> <what>. <replacement>.` — e.g. `src/lib/money.ts:L4-30: stdlib: hand-rolled currency formatter. Intl.NumberFormat, 1 line.` No hedging prose. Correctness, security, and performance are out of scope — leave them to the other axes. End with `net: -<N> lines possible.`, or `Lean already. Ship.` if nothing to cut. Under 400 words."

If the spec is missing, skip the Spec sub-agent and note this in the final report.

### 5. Aggregate

Present the reports under `## Standards`, `## Spec`, and `## Complexity` headings, verbatim or lightly cleaned. Keep the Complexity report in its one-line-per-finding format, ending with its `net:` line. Do **not** merge or rerank findings — the axes are deliberately separate (see _Why three axes_).

Before presenting, drop any Complexity finding that would cut something on the never-on-the-chopping-block list, or that contradicts a Spec requirement.

End with a one-line summary: total findings per axis, the worst issue _within each axis_ (if any), and the Complexity `net:` figure. Don't pick a single winner across axes — that's the reranking the separation exists to prevent.

## Why three axes

A change can pass one axis and fail another:

- Code that follows every standard but implements the wrong thing → **Standards pass, Spec fail.**
- Code that does exactly what the issue asked but breaks the project's conventions → **Spec pass, Standards fail.**
- Code that is correct and conventional but twice the size it needs to be → **Standards and Spec pass, Complexity fail.**

Reporting them separately stops one axis from masking another — in particular, "it works and it's tidy" must not hide "half of it didn't need to exist".
