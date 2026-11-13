local TestKit = require("./TestKit")
local Backpack = require("../src/shared/Backpack")

local describe, it, expect = TestKit.describe, TestKit.it, TestKit.expect

describe("Backpack.add", function()
	it("adds one Scrap when there's space", function()
		local count, added = Backpack.add(0, 10)
		expect(count).toBe(1)
		expect(added).toBe(true)
	end)

	it("fills up to the last space", function()
		local count, added = Backpack.add(9, 10)
		expect(count).toBe(10)
		expect(added).toBe(true)
	end)

	it("refuses when full", function()
		local count, added = Backpack.add(10, 10)
		expect(count).toBe(10)
		expect(added).toBe(false)
	end)
end)

describe("Backpack.isFull", function()
	it("is full at capacity", function()
		expect(Backpack.isFull(10, 10)).toBe(true)
	end)

	it("is not full below capacity", function()
		expect(Backpack.isFull(0, 10)).toBe(false)
		expect(Backpack.isFull(9, 10)).toBe(false)
	end)
end)

describe("Backpack.empty", function()
	it("empties the Backpack and says how much was in it", function()
		local count, removed = Backpack.empty(7)
		expect(count).toBe(0)
		expect(removed).toBe(7)
	end)

	it("works on an already empty Backpack", function()
		local count, removed = Backpack.empty(0)
		expect(count).toBe(0)
		expect(removed).toBe(0)
	end)
end)
