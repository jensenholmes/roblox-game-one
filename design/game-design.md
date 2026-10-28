# Game Design Document

_Status: Milestone 1 designed (2026-10-28). Title not chosen yet._

## Concept

Jetpack up from a moon base into floating asteroid fields, magnet in Scrap, and trade it for Stardust to collect ever-better Gear.

## Milestones

- **Milestone 1: the first public release.** Basic, but with the core mechanics. Everything below describes Milestone 1 unless marked otherwise.
- **Milestone 2 and beyond: updates.** Not designed yet. Ideas are collected in the [Update log](#update-log) at the bottom.

## Design principles

Every feature has to follow these.

1. **No upgrade levels.** Progress means owning a new, better-looking item, never "Lv 4 → Lv 5". Players should *see* their progress, and so should other players.
2. **Better Gear is sold higher up.** Each Layer can have its own shop with better Gear than the one below. (Starts in Milestone 2, when Layer 2 exists.)
3. **Keep scope small.** New ideas go in the Update log rather than straight into the current milestone.

## Core loop

```
magnet Scrap → Backpack fills → drop down to the Hub → sell for Stardust
      ↑                                                       ↓
      └──────────── buy or equip better Gear ←────────────────┘
```

## Player experience

**Chill progress.** "I'm steadily getting better, and I can see it." The player is always doing something with their hands (pulling in Scrap, jetpacking between Asteroids), and every new piece of Gear feels noticeably faster or bigger. Nothing in the game punishes the player harshly: a slip off an Asteroid just floats them home.

## Features

### The world

- **The Hub** is a large, moon-like ground surface: the social area where everyone sells and shops.
- **Layer 1** floats above the Hub: Asteroids to stand on, with Scrap floating in the same space, both on and between the Asteroids.
- For now, **everything stays still**: no drifting Scrap and no moving Asteroids.
- **Why:** a single, clear "up" gives new players an obvious goal and needs no custom movement code. See `docs/adr/0005-vertical-climb-not-zero-g.md`.

### Movement

- The player uses Roblox's normal character, with **low gravity**.
- Every player has a **Jetpack** from the start. Holding it boosts the player upward and uses up **Fuel**.
- When Fuel runs out, the player drifts back down.
- Fuel **refills quickly** (within a second or two) once the player lands on an Asteroid or the Hub.
- **Falling** starts slow and speeds up, up to a capped top speed that stays fairly gentle, so getting down is never tedious but never a plummet. The cap is a number to tune during playtesting.
- **Falling is free:** the player floats down to the Hub with no damage and keeps their Scrap. Jumping off an Asteroid is a quick way home to sell.
- **Why:** Fuel turns climbing into a small puzzle ("can I reach that rock?") and makes resting on Asteroids part of the rhythm. Free falling keeps the game chill and makes the trip home fun.

### Collecting Scrap

- The player aims their **Magnet** at a piece of Scrap and **holds** the button. A progress bar fills over the Scrap, and when it's full the Scrap goes into the Backpack.
- The Magnet works from anywhere, including mid-air, as long as the Scrap is in range.
- There is **one kind of Scrap**: every piece is worth the same.
- Scrap is **shared by the whole server**. If two players pull the same piece, whoever finishes first gets it and the other's Magnet stops.
- Collected Scrap **respawns within a few seconds**.
- **Why:** holding is comfortable on phones, the progress bar shows exactly how good your Magnet is, and shared Scrap makes the world feel alive.

### Backpack and selling

- The **Backpack** holds a limited amount of Scrap. When it's full, the player can't collect any more.
- The player sells by stepping on the **Sell Pad** on the Hub, which turns all their Scrap into **Stardust**.
- **Why:** the trip home gives the loop its rhythm: "I'm full!", drop down, cash in, then shop since you're already there.

### Gear and the Upgrade Terminal

- **Gear** is any item the player equips. In Milestone 1: **Magnets** (better ones fill the progress bar faster) and **Backpacks** (better ones hold more Scrap).
- The **Upgrade Terminal** on the Hub sells **5 tiers** of each. Each tier looks different.
- A new player joins with **tier 1 Magnet and tier 1 Backpack already owned and equipped**. The first thing they buy is tier 2.
- Tiers must be **bought in order** (you need tier 2 before tier 3). Higher tiers show as locked. _(May change.)_
- Every item is always in one of three **states**, shown on its shop button:

  | State | Meaning | Button |
  |---|---|---|
  | Not owned | not bought yet | `Buy · <price> ✨` |
  | Owned | bought, not in use | `Equip` |
  | Equipped | in use right now | `Equipped` (greyed out) |

  - **Buy**: Not owned → Equipped (buying equips straight away; the previous item becomes Owned).
  - **Equip**: Owned → Equipped (the previous item becomes Owned).
- Players keep every tier they've bought and can switch back to an older one at the Upgrade Terminal.
- **Why:** new-looking Gear is more exciting than a number going up (design principle 1), and the shop doubles as the inventory, so no separate inventory screen is needed.

### Saving

- The game remembers **everything** between visits: Stardust, which Gear is owned and which is equipped, and the Scrap in the Backpack.

## UI/UX

Designed for a phone screen first.

### HUD

- **Stardust** at the top of the screen, e.g. `✨ 1,250`.
- **Backpack** count, e.g. `🎒 7 / 10`. It changes colour and pulses when full.
- **Fuel bar** near the character, shown only while boosting or refuelling.
- **Magnet progress bar** over the Scrap being pulled, shown only while pulling.
- **Control hint**: one line along the bottom, e.g. _"Hold to magnet Scrap · Sell at the Hub"_.
- No shop button (the shop is the Upgrade Terminal on the Hub) and no map.

### Menus

- **Upgrade Terminal menu:** opens when the player walks up to the terminal. It lists Magnets and Backpacks by tier, each with its look, its stat, and a Buy / Equip / Equipped button.

### The first minute

- **No tutorial** in Milestone 1. The one-line control hint covers the basics.
- The player spawns on the Hub already holding a tier 1 Magnet and wearing a tier 1 Backpack, so they can start straight away.

## Update log

Ideas parked for after Milestone 1. Not designed yet, and not promised.

- **Layer 2**, with its own shop selling about 5 more tiers of each Gear (design principle 2)
- **Jetpack tiers**, which gate which Layers a player can reach. Each Layer shows a sign like "Layer 2: needs Jetpack tier 3"
- **Guided-arrow tutorial**: short hints that teach the loop by doing ("Hold to magnet Scrap" → "Backpack full! Drop down to sell" → "Buy new Gear")
- **Scrap rarities**: common / uncommon / rare, with different looks and values
- **Moving Scrap and Asteroids** that drift through space
- **Personal base**: your own station that processes Scrap and earns on its own (the "tycoon half")
- **Ships**, to reach far-off areas. _Open question: how ships fit the vertical world._
- **True zero gravity**: drifting movement in every direction
- **Magnet range** as a Gear stat
- **Multi-Magnet**: pull several pieces of Scrap at once
- **Cooperative pulling**: two players pull the same Scrap faster and both get it
- **Boost charges**: a set number of Jetpack boosts, as an item
- **Cosmetics / inventory**: Gear skins that aren't a straight upgrade
- **Game title**: not chosen yet
