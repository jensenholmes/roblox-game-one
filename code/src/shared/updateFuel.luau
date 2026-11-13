-- Works out the Jetpack's new Fuel after some time has passed.
-- Boosting drains 1 second of Fuel per second. Standing on the ground refills a full tank
-- in refillTime seconds. Drifting in the air leaves it alone. Fuel stays between 0 and maxFuel.
local function updateFuel(
	fuel: number,
	secondsPassed: number,
	isBoosting: boolean,
	isGrounded: boolean,
	maxFuel: number,
	refillTime: number
): number
	if isBoosting then
		fuel -= secondsPassed
	elseif isGrounded then
		fuel += secondsPassed * maxFuel / refillTime
	end

	return math.clamp(fuel, 0, maxFuel)
end

return updateFuel
