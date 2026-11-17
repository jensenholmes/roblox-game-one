-- The rules for a player's Gear: which tiers they own and which one is equipped.
-- Tiers are bought in order, so "owned" is one number: every tier from 1 up to ownedUpTo.
local Balancing = require("./Balancing")

local Gear = {}

-- A new player's Gear: tier 1 of each kind, owned and equipped.
function Gear.new()
	return {
		Magnet = { ownedUpTo = 1, equipped = 1 },
		Backpack = { ownedUpTo = 1, equipped = 1 },
	}
end

-- Tries to buy a tier of Gear. kind is "Magnet" or "Backpack".
-- Returns whether it was bought, and how much Stardust the player has left.
-- If it can't be bought, nothing changes.
function Gear.buy(gear, kind: string, tier: number, stardust: number): (boolean, number)
	local item = Balancing.Gear[kind][tier]
	local isNextTier = tier == gear[kind].ownedUpTo + 1

	if item == nil or not isNextTier or stardust < item.price then
		return false, stardust
	end

	gear[kind].ownedUpTo = tier
	gear[kind].equipped = tier -- buying equips it straight away
	return true, stardust - item.price
end

-- Switches to a tier the player already owns. Returns whether it worked.
function Gear.equip(gear, kind: string, tier: number): boolean
	if tier < 1 or tier > gear[kind].ownedUpTo then
		return false
	end

	gear[kind].equipped = tier
	return true
end

-- Works out an item's state for its shop button: "NotOwned", "Owned" or "Equipped".
function Gear.stateOf(gear, kind: string, tier: number): string
	if tier == gear[kind].equipped then
		return "Equipped"
	elseif tier <= gear[kind].ownedUpTo then
		return "Owned"
	else
		return "NotOwned"
	end
end

return Gear
