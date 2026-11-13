-- Every tunable number in one place. The values come from the Balancing section of
-- design/game-design.md: change them there first, then here.
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
	ScrapToughness = 4, -- pull time = toughness ÷ Magnet strength

	-- Magnet and Backpack (starter Gear; the Gear catalogue in #11 adds the other tiers)
	MagnetRange = 30, -- studs, the same for every Magnet
	StarterMagnetStrength = 1, -- 4 ÷ 1 = 4 seconds to pull one piece of Scrap
	StarterBackpackCapacity = 10, -- pieces of Scrap
}

return Balancing
