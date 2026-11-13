-- Keeps falling gentle: if the player is falling faster than topFallSpeed, slow them to it.
-- Going up, standing still, and slow falls are left alone. Down is negative in Roblox.
local function capFallSpeed(velocityY: number, topFallSpeed: number): number
	return math.max(velocityY, -topFallSpeed)
end

return capFallSpeed
