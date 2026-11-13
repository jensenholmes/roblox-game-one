# Learning journal

One entry per session: what we did, what concept it taught, and anything that was hard. Newest at the top.

---

## 2026-11-13: Jetpack and Fuel (issue #7)

**What we did:**
- Picked **hold Jump to fly** (Space, or the jump button on phones), so there's no new control to learn.
- Added the Jetpack numbers to `Balancing.luau`: rise at 25 studs/s, 3 s of Fuel, 1 s to refill.
- Wrote the Fuel tests first (drain, refill, never below empty or above full), watched them fail, then wrote `updateFuel`. 12 tests pass.
- Wrote the Jetpack script, and stored Fuel as an attribute so I can watch it in Studio (and the HUD can show it later).
- Playtested with a keyboard and with the device emulator: flying works on both, and Fuel refills on landing.
- Fixed my first **merge conflict**: two branches had both added a journal entry at the top of this file.

**Concepts learned:**
- **Same pattern, new feature:** numbers in Balancing → test → pure function → script → playtest. Repeating a pattern makes each feature faster.
- **Merge conflicts** happen when two branches change the same lines. Merging a Pull Request soon after finishing it helps avoid them.
- **Test on every device** players use, not just your own.

**What was hard / questions I still have:**
- Climbing all the way to Layer 1 can't be tested until the Hub and Layer 1 are built (#5).
- _Add your own notes here._

---

## 2026-11-13: Finishing low gravity, and learning Git (issue #6)

**What we did:**
- Wrote the test first (`capFallSpeed.spec.luau`), watched it fail, then wrote `capFallSpeed` to make it pass. All 7 tests pass.
- Hooked it into the game: a server script lowers gravity for everyone, and a client script caps each player's fall speed.
- Playtested in Studio: jumps are floaty and the big fall is gentle. I might tune the gravity later (it's one number in `Balancing.luau`).
- Started using **GitHub Desktop** to learn Git: branches, the Changes and History tabs, commits, pushing and Pull Requests.

**Concepts learned:**
- **Git is save points for code.** A commit is a snapshot with a note saying why. GitHub keeps a copy online as a backup.
- **Branches** let you work without breaking the main version. A **Pull Request** is the final check before merging.
- **Changes vs History:** Changes shows unsaved work. Once you commit, it moves into History.
- **Client vs server:** the server is the boss copy of the game, and each player's client controls their own character.
- **The code and the map live in different places.** Rojo copies code into any Studio world, but the map only lives in the world you build it in, so keep one published world for the game.

**What was hard / questions I still have:**
- At first my changes weren't in the Changes tab, because Claude had already committed them. From now on Claude writes the files and I do the commits and Pull Requests.
- _Add your own notes here._

---

## 2026-10-29: Starting low gravity (issue #6, in progress)

**What we did:**
- Picked #6 as the next task, because it unblocks the Jetpack (#7) and is the first real gameplay code.
- Added `code/src/shared/Balancing.luau`, which holds the gravity (65) and top falling speed (40) from the GDD's Balancing table.
- Found out Roblox has no fall damage by default, so "no fall damage" needs no code.

**Concepts learned:**
- **Single source of truth / DRY**: every script reads its numbers from one file, so tuning means changing one number in one place.
- **Pure functions**: the fall-speed cap will be a function that only uses its inputs, which makes it easy to test.
- **Velocity**: in Roblox, down is negative, so falling at 50 studs/s is `-50`.

**Next time:** write `code/tests/capFallSpeed.spec.luau` first (fast fall gets capped, slow fall is left alone, going up is left alone), watch it fail, then write `capFallSpeed`.

**What was hard / questions I still have:**
_Add your own notes here._

---

## 2026-10-29: Choosing the balancing numbers (issue #3)

**What we did:** Picked first-guess numbers for everything the code needs, one question at a time, and wrote them into a new **Balancing** section in `design/game-design.md`:
- Two anchors: the first run takes **about a minute**, and owning every tier takes **about 20 minutes** (I cut this from 30–45 because 5 tiers stretched over 45 minutes would feel like a grind).
- Gear: prices 10 / 20 / 40 / 70 ✨, Backpacks 10 / 15 / 25 / 40 / 60, Magnet pull time 4.0 → 1.3 seconds.
- 1 Stardust per Scrap, Scrap respawns after 5 s.
- Movement: gravity 65, top falling speed 40, Jetpack boost 25 studs/s, 3 s of Fuel, 1 s refill, Magnet range 30 studs.
- My idea, saved for a later update: rarer Scrap worth more but **tougher** to pull, so upgrading the Magnet keeps mattering. Pull time will be built as toughness ÷ strength so it's easy to add.

**Concepts learned:**
- **Anchors**: pick a few numbers about time and feel, then work the rest out from them.
- **Trade-offs in balancing**: a bigger Backpack earns more per trip but makes runs longer; a slower Magnet makes upgrades feel bigger but makes the first run longer.
- **Exponential curves**: prices that roughly double each tier.
- **Gating** and **designing for change**: leave room for a future feature without building it yet.
- **Pushing back on a recommendation** is part of the job. I changed Stardust per Scrap, the tier 2 price, the Magnet curve and the total time.

**What was hard / questions I still have:**
- The movement numbers are hard to judge on paper; we'll find out in Studio.
- _Add your own notes here._

---

## 2026-10-29: Setting up Rojo and the test runner (issue #2)

**What we did:**
- Installed **Rokit**, which then installed the exact versions of **Rojo** (7.7.1) and **Lune** (0.11.1) listed in `rokit.toml`.
- Wrote `default.project.json`, which tells Rojo where each code folder goes in Studio and leaves the map out (ADR 0003).
- Set up a tiny test framework (`code/tests/TestKit.luau`) and a runner. The first test, for `formatNumber`, passed 3 out of 3.
- Installed the Rojo plugin in Studio, connected it to `rojo serve`, and saw "Hello from Rojo!" in the Output window.

**Concepts learned:**
- **Tool versions are part of the project.** A manifest (`rokit.toml`) pins exact versions, so the setup works the same on any computer.
- **Silence means success.** Many command-line tools print nothing when everything worked.
- **Automated tests** run in seconds with `lune run code/tests/run.luau`, which is what makes test first (TDD) practical.

**What was hard / questions I still have:**
- `rokit` wasn't found at first, because a terminal only reads PATH when it opens.
- `rojo` only works from inside the project folder, because it looks for `rokit.toml` there.
- The Rojo button took a few tries to appear in Studio.
- _Add your own notes here._

---

## 2026-10-28: Designing the game (grilling session)

**What we did:** Claude "grilled" me on the game design, one question at a time, each with a recommended answer. We went from a blank design doc to a full plan for Milestone 1 (the first public release):

- The feeling: **chill progress** (an incremental game).
- Shape: a **simulator** core loop first, with a personal base, ships and more Layers saved for later updates.
- Theme: **space**, because I haven't seen it done much on Roblox.
- World: a **vertical climb**. A moon-like Hub on the ground, a Layer of floating Asteroids and Scrap above, reached with a Jetpack in low gravity. I was torn between this and zero-g open space, and chose vertical because it's buildable and new players know where to go (`docs/adr/0005-vertical-climb-not-zero-g.md`).
- Loop: hold the Magnet on Scrap → Backpack fills → fall back to the Hub → sell for Stardust → buy better Gear.
- My own design principle: **no upgrade levels**. You buy new, better-looking Gear, and the shop has Buy / Equip / Equipped buttons so you can switch back.
- Named everything in `GLOSSARY.md` (Scrap, Magnet, Backpack, Stardust, ...).

**Concepts learned:**
- **Player experience first:** decide the feeling, then pick features that serve it.
- **Design tree:** each decision opens the next ones, so some questions have to wait for others.
- **MVP, milestones and scope creep:** ship the smallest fun version first. New ideas go in a **parking lot** (our Update log) instead of growing the plan.
- **Validation:** build the smallest thing that proves a mechanic works.
- **States and transitions:** an item is always Not owned, Owned or Equipped, and buttons move it between them. Programmers use this idea constantly.
- **Changing your mind is cheap on paper:** I reopened several decisions (field count, tutorial, upgrades), and that cost nothing because nothing was built yet.

**What was hard / questions I still have:**
- Choosing between zero-g and vertical. I liked both.
- Where ships fit in a vertical world is still open.
- _Add your own notes here._

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
