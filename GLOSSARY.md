# Glossary

The game's own vocabulary. Design docs and code use these exact names, so "Scrap" in the design is `Scrap` in the code, never "junk" or "salvage".

Technical jargon (Rojo, TDD, and so on) goes in `learning/jargon.md` instead.

**Asteroid**: a floating rock in a Layer that the player can stand on. Landing on one refills Fuel.

**Backpack**: Gear that holds the player's Scrap, up to a limit. Better tiers hold more. _Avoid: cargo pack, bag._

**Equipped / Owned / Not owned**: the three states an item of Gear can be in. Not owned = not bought yet; Owned = bought but not in use; Equipped = in use right now.

**Fuel**: what the Jetpack uses while boosting. Refills quickly when the player lands.

**Gear**: any item the player equips: Magnets and Backpacks (and Jetpacks in a later update). _Avoid: equipment, tools, items._

**Hub**: the large, moon-like ground surface where players sell and shop. The social area. _Avoid: lobby, base, station._

**Jetpack**: boosts the player upward, using Fuel. Every player has one from the start.

**Layer**: a band of floating Asteroids and Scrap above the Hub. Milestone 1 has Layer 1. _Avoid: field, zone, world._

**Magnet**: Gear the player holds and aims at Scrap to pull it into their Backpack. Better tiers pull faster. _Avoid: beam, salvage beam, tractor beam._

**Scrap**: the thing players collect. You "magnet" Scrap or "pull" it in. _Avoid: junk, salvage (as a noun), loot._

**Sell Pad**: the spot on the Hub where stepping on it turns all your Scrap into Stardust.

**Stardust**: the game's currency, earned by selling Scrap. Same word for one or many: "1 Stardust", "5,000 Stardust". _Avoid: credits, coins, money._

**Tier**: one step in a line of Gear, e.g. "Magnet tier 3". Each tier looks different. _Avoid: level._

**Upgrade Terminal**: the shop booth on the Hub where players buy and equip Gear. _Avoid: shop (in code and docs)._
