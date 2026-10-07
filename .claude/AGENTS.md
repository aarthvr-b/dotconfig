# Global agent instructions

Cross-repository behavior for coding agents. Loaded by Claude Code via `~/.claude/CLAUDE.md`.

- Never use the em dash "—". Use plain dash "-" instead if you think it's strictly necessary.
- When writing commit messages, NEVER auto-add your agent name as co-author.
- Never manually modify CHANGELOG.md files or any files that are marked as auto-generated.
- When making technical decisions, do not give much weight to development cost;
    Instead, prefer quality, simplicity, robustness, scalability, and long term maintanablity.
- When doing bugfixes, always start with reproducing the bug in an E2E setting as closely aligned with how an end user would experience it as possible;
    this makes sure you find the real problem so your fix will actually solve it.
- When end-to-end testing a product, be picky about the UI you see and be obsessed with pixel perfection.
    If something clearly looks off, even if it is not directly related to what you are doing, try to get it fixed along the way.
- Apply that same high standatd to engineering excellence: lint, test failures, and test flakiness;
    if you see one, even if it is not caused by what you are working onright now, still get it fixed.
- **For file modifications, always prefer Edit/Write tools over Bash.** Never create or modify files via Bash commands (heredocs, redirects, `sed -i`, `tee`, or scripts that write files). Use Edit or Write so diffs are visible in the conversation and you can review changes. Exception: temporary/throwaway files in scratchpad or `/tmp` that won't be part of the codebase. That way I can follow your code changes and review them as they come.
