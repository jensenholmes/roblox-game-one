# Jargon

Technical words, in plain English. Alphabetical. Game-specific words (like the name of an in-game currency) go in `/GLOSSARY.md` instead.

**ADR (Architecture Decision Record)**: a short note that says "we decided X, because Y". It means you (or a future teammate) can find out *why* something is the way it is. Ours live in `docs/adr/`.

**Asset ID**: the number Roblox gives anything you upload (a mesh, image, or sound), written like `rbxassetid://123456`. Code uses it to load the asset.

**Automated test**: a small piece of code that checks other code works, e.g. "a player with 10 coins who buys a 5-coin item has 5 left". It runs by itself every time, so you find out straight away if a change broke something.

**Balancing**: tuning a game's numbers (prices, earnings, speeds) so progress feels steady, not too slow or too fast.

**Binary file**: a file that isn't readable text, e.g. `.blend`, `.png` or `.wav`. Git can't store just the changed parts of a binary file, so each version is a full copy.

**CLAUDE.md**: an instructions file Claude reads automatically. The one at the top of the project applies everywhere; the one in a folder adds rules for that folder.

**CLI (Command-Line Interface)**: a program you use by typing commands in a terminal instead of clicking, e.g. `git` or `gh`.

**Commit**: a saved snapshot of the project in Git, with a message explaining what changed and why.

**Core loop**: the main thing a player does over and over in a game, e.g. *collect → upgrade → collect faster*.

**DataStore**: Roblox's service for saving player data between visits, e.g. how much currency a player has.

**Design principle**: a rule every feature has to follow, e.g. "no upgrade levels". It keeps lots of separate decisions consistent.

**Design tree**: a map of decisions where each answer opens the next ones. Some questions can't be asked until the ones before them are settled.

**Flag**: an option added to a command, starting with `--`. For example, `--web` in `gh auth login --web` means "log in through the browser".

**GDD (Game Design Document)**: the document describing what the game is: concept, core loop, features, UI. Ours is `design/game-design.md`.

**Genre**: a category of game that shares common rules, e.g. obby, tycoon, simulator.

**Git LFS (Large File Storage)**: an add-on for Git that stores big files separately. We decided not to use it (see `docs/adr/0004-large-art-source-out-of-git.md`).

**Git**: a version control tool. It records every change to the project, so you can see history and undo mistakes.

**GitHub Issue**: a ticket on GitHub describing one task or bug, with its own discussion. Our to-do list.

**GitHub**: a website that hosts Git projects online and adds teamwork tools like Issues.

**`.gitignore`**: a file listing things Git should ignore and never save.

**Hook**: the thing that makes a player pick your game out of thousands, e.g. a theme they haven't seen before.

**HUD (Heads-Up Display)**: the info on screen while you play: health, coins, timer.

**Incremental game**: a game where the fun is numbers growing and each upgrade making you a bit faster. Also called a "chill progress" game.

**Inventory**: a menu listing everything a player owns.

**Luau**: Roblox's programming language, based on Lua.

**Mechanic**: a single rule of how a game works, e.g. "the Jetpack uses Fuel".

**Merge conflict**: when two people change the same part of a file at the same time and Git can't tell which version to keep.

**Milestone**: a checkpoint on the way to a goal, e.g. "Milestone 1: first public release".

**MVP (Minimum Viable Product)**: the smallest version of a product that's still useful (or fun). You ship it first, then improve it.

**Parking lot**: a list of ideas written down on purpose so they aren't lost, but that don't block today's work. Ours is the Update log in the GDD.

**PATH**: the list of folders your computer searches when you type a program's name. A terminal reads it once when it opens, so newly installed programs need a fresh terminal (or their full path).

**Player experience**: the feeling a game aims to give the player, e.g. "chill progress". Every feature gets judged against it.

**Playtest**: playing your own game (or watching others play it) to find out if it's fun and find problems.

**`.rbxm`**: Roblox's saved-model file format. Rojo can sync these into the game.

**Respawn**: to reappear after dying or falling, or (for objects) to come back after being collected.

**Rojo**: a tool that syncs code and model files from your computer into Roblox Studio, so they can live in Git.

**Sandbox**: an open-ended game where you roam and do what you like, rather than following a set path.

**Scope creep**: when a plan keeps growing until it never gets finished. The classic first-project trap.

**SDLC (Software Development Life Cycle)**: the stages a software project goes through. See `sdlc.md`.

**Server**: the computer that runs a game for everyone in it. On Roblox, each running copy of a game is one server.

**Source of truth**: the one place where a piece of information officially lives, so there's no confusion about which copy is right.

**States and transitions**: a way to describe something that's always in exactly one *state* (e.g. Not owned, Owned, Equipped), with *transitions* (e.g. Buy, Equip) moving it between states. Makes code easy to reason about and test.

**TDD (Test-Driven Development)**: write the test first, watch it fail, then write the code that makes it pass.

**Terminal velocity**: the fastest a falling thing can go. In a game it's a number you choose.

**Token**: a long secret string that proves you're logged in, used instead of a password. Treat it like a password: never paste it anywhere public.

**UX / UI**: UX (user experience) is how using something *feels*; UI (user interface) is the actual buttons, menus, and screens.

**Validate**: prove an idea works, ideally with the smallest thing you can build.

**winget**: Windows' built-in package manager. It installs programs from the terminal, e.g. `winget install --id GitHub.cli`.

**YAGNI ("You Aren't Gonna Need It")**: don't build something until you actually need it. Start simple.
