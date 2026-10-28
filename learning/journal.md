# Learning journal

One entry per session: what we did, what concept it taught, and anything that was hard. Newest at the top.

---

## 2026-10-28: Setting up the project structure

**What we did:** Before writing any code, we designed the project's folder structure by working out which roles a game studio needs. Claude interviewed me one question at a time, with a recommended answer for each, and we made these decisions:

- Started with 8 studio roles and cut them to 3 folders (`design`, `code`, `art-audio`). I'm the producer, testing is part of coding, and I've published a game before, so I don't need a release role.
- Rojo, so code lives in files that Git and Claude can work with.
- GitHub Issues for the to-do list, so I learn how real teams track work.
- The map lives in Roblox, and big art files stay out of Git.

**Concepts learned:**
- **Planning before building.** This is the first stage of the software development lifecycle (see `sdlc.md`).
- **YAGNI**: start simple and only add things when you need them.
- **Separating the "what" from the "how"**: design says what to build and why, code decides how.
- **Trade-offs**: every choice has pros and cons (`PLAN.md` vs GitHub Issues, Git LFS vs keeping files out of Git). The skill is picking the right one for *your* situation and writing down why (that's what `docs/adr/` is for).

**What was hard / questions I still have:**
_Add your own notes here._
