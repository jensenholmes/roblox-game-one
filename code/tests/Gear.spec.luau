local TestKit = require("./TestKit")
local Gear = require("../src/shared/Gear")
local Balancing = require("../src/shared/Balancing")

local describe, it, expect = TestKit.describe, TestKit.it, TestKit.expect

describe("Gear.new", function()
	it("starts with tier 1 Magnet and Backpack owned and equipped", function()
		local gear = Gear.new()
		expect(gear.Magnet.ownedUpTo).toBe(1)
		expect(gear.Magnet.equipped).toBe(1)
		expect(gear.Backpack.ownedUpTo).toBe(1)
		expect(gear.Backpack.equipped).toBe(1)
	end)
end)

describe("Gear.buy", function()
	it("buys the next tier, takes the Stardust and equips it", function()
		local gear = Gear.new()
		local bought, stardustLeft = Gear.buy(gear, "Magnet", 2, 25)
		expect(bought).toBe(true)
		expect(stardustLeft).toBe(15) -- tier 2 costs 10
		expect(gear.Magnet.ownedUpTo).toBe(2)
		expect(gear.Magnet.equipped).toBe(2)
	end)

	it("buys with exactly enough Stardust", function()
		local gear = Gear.new()
		local bought, stardustLeft = Gear.buy(gear, "Backpack", 2, 10)
		expect(bought).toBe(true)
		expect(stardustLeft).toBe(0)
	end)

	it("refuses without enough Stardust and changes nothing", function()
		local gear = Gear.new()
		local bought, stardustLeft = Gear.buy(gear, "Magnet", 2, 9)
		expect(bought).toBe(false)
		expect(stardustLeft).toBe(9)
		expect(gear.Magnet.ownedUpTo).toBe(1)
		expect(gear.Magnet.equipped).toBe(1)
	end)

	it("refuses to skip a tier", function()
		local gear = Gear.new()
		local bought, stardustLeft = Gear.buy(gear, "Magnet", 3, 100)
		expect(bought).toBe(false)
		expect(stardustLeft).toBe(100)
		expect(gear.Magnet.ownedUpTo).toBe(1)
	end)

	it("refuses to buy a tier you already own", function()
		local gear = Gear.new()
		local bought, stardustLeft = Gear.buy(gear, "Magnet", 1, 100)
		expect(bought).toBe(false)
		expect(stardustLeft).toBe(100)
	end)

	it("refuses to buy past the last tier", function()
		local gear = { Magnet = { ownedUpTo = 5, equipped = 5 }, Backpack = { ownedUpTo = 1, equipped = 1 } }
		local bought = Gear.buy(gear, "Magnet", 6, 1000)
		expect(bought).toBe(false)
	end)
end)

describe("Gear.equip", function()
	it("switches back to a tier you own", function()
		local gear = { Magnet = { ownedUpTo = 3, equipped = 3 }, Backpack = { ownedUpTo = 1, equipped = 1 } }
		local equipped = Gear.equip(gear, "Magnet", 1)
		expect(equipped).toBe(true)
		expect(gear.Magnet.equipped).toBe(1)
		expect(gear.Magnet.ownedUpTo).toBe(3) -- still owns everything
	end)

	it("refuses a tier you don't own and changes nothing", function()
		local gear = Gear.new()
		local equipped = Gear.equip(gear, "Magnet", 2)
		expect(equipped).toBe(false)
		expect(gear.Magnet.equipped).toBe(1)
	end)

	it("refuses a tier that doesn't exist", function()
		local gear = Gear.new()
		expect(Gear.equip(gear, "Magnet", 0)).toBe(false)
		expect(gear.Magnet.equipped).toBe(1)
	end)

	it("only changes the kind you asked for", function()
		local gear = { Magnet = { ownedUpTo = 2, equipped = 2 }, Backpack = { ownedUpTo = 2, equipped = 2 } }
		Gear.equip(gear, "Magnet", 1)
		expect(gear.Backpack.equipped).toBe(2)
	end)
end)

describe("Gear.stateOf", function()
	-- Owns Magnet tiers 1 to 3, using tier 2
	local gear = { Magnet = { ownedUpTo = 3, equipped = 2 }, Backpack = { ownedUpTo = 1, equipped = 1 } }

	it("is Equipped for the tier in use", function()
		expect(Gear.stateOf(gear, "Magnet", 2)).toBe("Equipped")
	end)

	it("is Owned for other tiers you've bought", function()
		expect(Gear.stateOf(gear, "Magnet", 1)).toBe("Owned")
		expect(Gear.stateOf(gear, "Magnet", 3)).toBe("Owned")
	end)

	it("is NotOwned for tiers you haven't bought", function()
		expect(Gear.stateOf(gear, "Magnet", 4)).toBe("NotOwned")
		expect(Gear.stateOf(gear, "Magnet", 5)).toBe("NotOwned")
	end)

	it("has exactly one Equipped tier of each kind", function()
		for _, kind in { "Magnet", "Backpack" } do
			local count = 0
			for tier = 1, #Balancing.Gear[kind] do
				if Gear.stateOf(gear, kind, tier) == "Equipped" then
					count += 1
				end
			end
			expect(count).toBe(1)
		end
	end)
end)
