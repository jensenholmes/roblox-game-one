-- The rules for how much Scrap a Backpack holds. Pure functions: numbers in, numbers out.
local Backpack = {}

function Backpack.isFull(count: number, capacity: number): boolean
	return count >= capacity
end

-- Adds one Scrap. Returns the new count, and whether it fit.
function Backpack.add(count: number, capacity: number): (number, boolean)
	if Backpack.isFull(count, capacity) then
		return count, false
	end
	return count + 1, true
end

-- Empties the Backpack (when selling). Returns the new count (0), and how much was in it.
function Backpack.empty(count: number): (number, number)
	return 0, count
end

return Backpack
