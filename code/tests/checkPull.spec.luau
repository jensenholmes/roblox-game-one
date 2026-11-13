local TestKit = require("./TestKit")
local checkPull = require("../src/shared/checkPull")

local describe, it, expect = TestKit.describe, TestKit.it, TestKit.expect

-- checkPull(secondsPulled, pullTime, distance, range, scrapInBackpack, backpackCapacity)
-- The server asks this every frame for every pull. A 4 second pull, 30 stud range, Backpack holds 10.
describe("checkPull", function()
	it("keeps pulling before the time is up", function()
		expect(checkPull(1, 4, 10, 30, 0, 10)).toBe("pulling")
		expect(checkPull(3.9, 4, 10, 30, 0, 10)).toBe("pulling")
	end)

	it("is done once the pull time has passed", function()
		expect(checkPull(4, 4, 10, 30, 0, 10)).toBe("done")
		expect(checkPull(5, 4, 10, 30, 9, 10)).toBe("done")
	end)

	it("stops when the Scrap is out of range", function()
		expect(checkPull(1, 4, 31, 30, 0, 10)).toBe("outOfRange")
		expect(checkPull(4, 4, 31, 30, 0, 10)).toBe("outOfRange")
	end)

	it("works right at the edge of the range", function()
		expect(checkPull(4, 4, 30, 30, 0, 10)).toBe("done")
	end)

	it("stops when the Backpack is full", function()
		expect(checkPull(1, 4, 10, 30, 10, 10)).toBe("backpackFull")
		expect(checkPull(4, 4, 10, 30, 10, 10)).toBe("backpackFull")
	end)
end)
