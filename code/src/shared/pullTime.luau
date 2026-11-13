-- How many seconds it takes a Magnet to pull in one piece of Scrap.
-- Built as toughness ÷ strength so tougher, rarer Scrap can be added later (see the GDD's Update log).
local function pullTime(scrapToughness: number, magnetStrength: number): number
	return scrapToughness / magnetStrength
end

return pullTime
