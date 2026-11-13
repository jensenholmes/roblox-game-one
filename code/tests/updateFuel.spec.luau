local TestKit = require("./TestKit")
local updateFuel = require("../src/shared/updateFuel")

local describe, it, expect = TestKit.describe, TestKit.it, TestKit.expect

-- A full tank is 3 seconds of boosting, and an empty tank refills in 1 second.
local MAX_FUEL = 3
local REFILL_TIME = 1

-- updateFuel(fuel, secondsPassed, isBoosting, isGrounded, maxFuel, refillTime)
describe("updateFuel", function()
	it("drains one second of Fuel per second of boosting", function()
		expect(updateFuel(3, 0.5, true, false, MAX_FUEL, REFILL_TIME)).toBe(2.5)
	end)

	it("never drains below empty", function()
		expect(updateFuel(0.2, 0.5, true, false, MAX_FUEL, REFILL_TIME)).toBe(0)
	end)

	it("refills on the ground, a full tank in one refill time", function()
		expect(updateFuel(0, 0.5, false, true, MAX_FUEL, REFILL_TIME)).toBe(1.5)
		expect(updateFuel(0, 1, false, true, MAX_FUEL, REFILL_TIME)).toBe(3)
	end)

	it("never refills above full", function()
		expect(updateFuel(2.9, 0.5, false, true, MAX_FUEL, REFILL_TIME)).toBe(3)
	end)

	it("stays the same while drifting in the air", function()
		expect(updateFuel(1, 0.5, false, false, MAX_FUEL, REFILL_TIME)).toBe(1)
	end)
end)
