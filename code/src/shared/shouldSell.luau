-- Sell only at the moment a player steps onto the Sell Pad, not every frame they stand on it.
local function shouldSell(wasOnPad: boolean, isOnPad: boolean): boolean
	return isOnPad and not wasOnPad
end

return shouldSell
