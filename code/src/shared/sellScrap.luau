-- Sells everything in the Backpack: each Scrap becomes stardustPerScrap Stardust.
-- Returns the new Scrap count (always 0) and the player's new Stardust total.
local function sellScrap(scrapInBackpack: number, stardust: number, stardustPerScrap: number): (number, number)
	return 0, stardust + scrapInBackpack * stardustPerScrap
end

return sellScrap
