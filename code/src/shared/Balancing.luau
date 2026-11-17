-- Every tunable number in one place. The values come from the Balancing section of
-- design/game-design.md: change them there first, then here.

local SCRAP_TOUGHNESS = 4 -- pull time = toughness ÷ Magnet strength

local Balancing = {
	-- Movement
	Gravity = 65, -- studs/s², about 1/3 of Roblox's normal 196.2
	TopFallSpeed = 40, -- studs/s, the fastest a player can fall

	-- Jetpack
	JetpackBoostSpeed = 25, -- studs/s, the steady speed the player rises at while boosting
	MaxFuel = 3, -- seconds of boosting in a full tank (about 75 studs of climb)
	FuelRefillTime = 1, -- seconds to refill an empty tank after landing

	-- Scrap
	ScrapRespawnTime = 5, -- seconds before collected Scrap comes back
	ScrapToughness = SCRAP_TOUGHNESS,
	StardustPerScrap = 1, -- what each piece of Scrap sells for at the Sell Pad

	-- Magnet and Backpack
	MagnetRange = 30, -- studs, the same for every Magnet
	StarterMagnetStrength = 1, -- 4 ÷ 1 = 4 seconds to pull one piece of Scrap
	StarterBackpackCapacity = 10, -- pieces of Scrap

	-- The Gear catalogue: 5 tiers of each kind, bought in order at the Upgrade Terminal.
	-- Tier 1 is owned from the start, so its price is 0.
	-- Strength is written as toughness ÷ the pull time in the design doc, so the
	-- design doc's pull times (4.0, 3.0, 2.3, 1.7, 1.3 seconds) come out exactly.
	Gear = {
		Magnet = {
			{ price = 0, strength = SCRAP_TOUGHNESS / 4.0 },
			{ price = 10, strength = SCRAP_TOUGHNESS / 3.0 },
			{ price = 20, strength = SCRAP_TOUGHNESS / 2.3 },
			{ price = 40, strength = SCRAP_TOUGHNESS / 1.7 },
			{ price = 70, strength = SCRAP_TOUGHNESS / 1.3 },
		},
		Backpack = {
			{ price = 0, capacity = 10 },
			{ price = 10, capacity = 15 },
			{ price = 20, capacity = 25 },
			{ price = 40, capacity = 40 },
			{ price = 70, capacity = 60 },
		},
	},
}

return Balancing
