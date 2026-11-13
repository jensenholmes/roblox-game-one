local TestKit = require("./TestKit")
local capFallSpeed = require("../src/shared/capFallSpeed")

local describe, it, expect = TestKit.describe, TestKit.it, TestKit.expect

-- Remember: in Roblox, down is negative. Falling at 50 studs/s is a Y velocity of -50.
describe("capFallSpeed", function()
	it("slows a fast fall down to the top speed", function()
		expect(capFallSpeed(-50, 40)).toBe(-40)
		expect(capFallSpeed(-1000, 40)).toBe(-40)
	end)

	it("leaves a slow fall alone", function()
		expect(capFallSpeed(-10, 40)).toBe(-10)
		expect(capFallSpeed(-40, 40)).toBe(-40)
	end)

	it("leaves going up alone", function()
		expect(capFallSpeed(30, 40)).toBe(30)
		expect(capFallSpeed(100, 40)).toBe(100)
	end)

	it("leaves standing still alone", function()
		expect(capFallSpeed(0, 40)).toBe(0)
	end)
end)
