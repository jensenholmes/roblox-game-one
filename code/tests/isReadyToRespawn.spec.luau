local TestKit = require("./TestKit")
local isReadyToRespawn = require("../src/shared/isReadyToRespawn")

local describe, it, expect = TestKit.describe, TestKit.it, TestKit.expect

-- Times are in seconds. Scrap collected at time 100, with a 5 second respawn time,
-- should come back at time 105.
local RESPAWN_TIME = 5

-- isReadyToRespawn(collectedAt, now, respawnTime)
describe("isReadyToRespawn", function()
	it("is not ready straight after being collected", function()
		expect(isReadyToRespawn(100, 100, RESPAWN_TIME)).toBe(false)
		expect(isReadyToRespawn(100, 104.9, RESPAWN_TIME)).toBe(false)
	end)

	it("is ready once the respawn time has passed", function()
		expect(isReadyToRespawn(100, 105, RESPAWN_TIME)).toBe(true)
		expect(isReadyToRespawn(100, 200, RESPAWN_TIME)).toBe(true)
	end)
end)
