local TestKit = require("./TestKit")
local shouldSell = require("../src/shared/shouldSell")

local describe, it, expect = TestKit.describe, TestKit.it, TestKit.expect

-- shouldSell(wasOnPadLastFrame, isOnPadNow)
describe("shouldSell", function()
	it("sells when the player steps onto the pad", function()
		expect(shouldSell(false, true)).toBe(true)
	end)

	it("doesn't sell again while the player stands on the pad", function()
		expect(shouldSell(true, true)).toBe(false)
	end)

	it("doesn't sell when the player steps off", function()
		expect(shouldSell(true, false)).toBe(false)
	end)

	it("doesn't sell when the player is nowhere near", function()
		expect(shouldSell(false, false)).toBe(false)
	end)
end)
