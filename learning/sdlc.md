# The Software Development Life Cycle (SDLC)

The SDLC is the set of stages a piece of software goes through. Real teams don't do each stage once and move on: they go round the loop again and again, a small slice at a time. That's called **iterative** development. Each loop adds one feature and makes the game a bit better.

```
   ┌──► 1. Plan ──► 2. Design ──► 3. Build ──► 4. Test ──► 5. Release ──► 6. Review ──┐
   └──────────────────────────────────────────────────────────────────────────────────┘
```

## The stages, mapped to this project

| Stage | Question it answers | Where it happens here |
|---|---|---|
| **1. Plan** | What should we work on next? | You (the producer), using GitHub Issues |
| **2. Design** | What exactly is it, and why? | `design/game-design.md`, then split into issues |
| **3. Build** | How do we make it? | `code/` (and `art-audio/` for models and sound) |
| **4. Test** | Does it work? Did we break anything? | Automated tests in `code/tests/` + you playtesting in Studio |
| **5. Release** | How do players get it? | Publishing from Roblox Studio |
| **6. Review** | What did we learn? What should change? | `learning/journal.md` and `docs/adr/` |

## Where we are now

**Stage 1: Plan.** We've set up the project structure. Next: decide on the game concept (Design).

## Future level-ups

Things to try once the basics are running:

- **A project board on GitHub**: a visual board of your issues in columns (To do / Doing / Done).
- **Continuous Integration (CI)**: GitHub runs your automated tests every time you push code, so broken code gets caught automatically.
