local TestKit = require("./TestKit")
local pullTime = require("../src/shared/pullTime")

local describe, it, expect = TestKit.describe, TestKit.it, TestKit.expect

-- pullTime(scrapToughness, magnetStrength)
describe("pullTime", function()
	it("takes 4 seconds with the starter Magnet", function()
		expect(pullTime(4, 1)).toBe(4)
	end)

	it("is faster with a stronger Magnet", function()
		expect(pullTime(4, 2)).toBe(2)
	end)

	it("is slower for tougher Scrap", function()
		expect(pullTime(8, 1)).toBe(8)
	end)
end)
