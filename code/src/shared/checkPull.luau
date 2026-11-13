-- The server's referee for a Magnet pull. Called every frame while a player is pulling.
-- Returns one of:
--   "backpackFull" - no space left, so stop
--   "outOfRange"   - the player is too far from the Scrap, so stop
--   "pulling"      - all fine, keep going
--   "done"         - the pull is finished, so the Scrap goes into the Backpack
export type PullResult = "backpackFull" | "outOfRange" | "pulling" | "done"

local function checkPull(
	secondsPulled: number,
	pullTime: number,
	distance: number,
	range: number,
	scrapInBackpack: number,
	backpackCapacity: number
): PullResult
	if scrapInBackpack >= backpackCapacity then
		return "backpackFull"
	elseif distance > range then
		return "outOfRange"
	elseif secondsPulled < pullTime then
		return "pulling"
	else
		return "done"
	end
end

return checkPull
