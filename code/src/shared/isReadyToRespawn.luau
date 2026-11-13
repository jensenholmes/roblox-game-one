-- Has enough time passed since a piece of Scrap was collected for it to come back?
-- Times are in seconds, from the same clock.
local function isReadyToRespawn(collectedAt: number, now: number, respawnTime: number): boolean
	return now - collectedAt >= respawnTime
end

return isReadyToRespawn
