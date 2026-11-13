local TestKit = require("./TestKit")
local sellScrap = require("../src/shared/sellScrap")

local describe, it, expect = TestKit.describe, TestKit.it, TestKit.expect

-- sellScrap(scrapInBackpack, stardust, stardustPerScrap) → (new Scrap count, new Stardust)
describe("sellScrap", function()
	it("turns every Scrap into Stardust and empties the Backpack", function()
		local scrap, stardust = sellScrap(7, 0, 1)
		expect(scrap).toBe(0)
		expect(stardust).toBe(7)
	end)

	it("adds to the Stardust the player already has", function()
		local scrap, stardust = sellScrap(10, 25, 1)
		expect(scrap).toBe(0)
		expect(stardust).toBe(35)
	end)

	it("uses the value of each Scrap", function()
		local _, stardust = sellScrap(10, 0, 3)
		expect(stardust).toBe(30)
	end)

	it("does nothing with an empty Backpack", function()
		local scrap, stardust = sellScrap(0, 25, 1)
		expect(scrap).toBe(0)
		expect(stardust).toBe(25)
	end)
end)
