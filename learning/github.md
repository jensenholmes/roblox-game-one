# How we use GitHub

Our project is on GitHub at `jensenholmes/roblox-game-one`. Git saves the history on your computer; GitHub keeps a copy online and adds teamwork tools.

## Issues: our to-do list

An **issue** is a ticket for one task or bug. Each one has:

- a **title**: short and clear, e.g. "Add a coin counter to the HUD"
- a **description**: what "done" looks like, and a link to the GDD section it comes from
- **comments**: discussion about that one task

Every issue gets one **role label**: 🟣 `design`, 🔵 `code`, or 🟠 `art-audio`. On the Issues page, click a label to see only that role's tasks. GitHub's built-in labels like `bug` can be added as well.

A good issue is small enough to finish in one session. If it feels big, split it into several issues.

## The workflow

1. Pick an issue to work on.
2. Write the test, then the code (see `code/CLAUDE.md`).
3. Commit with a message that mentions the issue, e.g. `Add coin counter (fixes #12)`.
4. Push to GitHub. The word **fixes** closes issue #12 automatically.

## Setup still to do

- [x] Install the GitHub CLI (`gh`) so Claude can create and read issues from the terminal. Done with `winget install --id GitHub.cli`.
- [x] Log in with `gh auth login --web`, then `gh auth setup-git` so Git pushes use the same login.
- [ ] Run `/setup-matt-pocock-skills` to connect the skills to GitHub Issues.
