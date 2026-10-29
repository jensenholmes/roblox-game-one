-- Turns a number into text with commas, so 1250 shows as "1,250" on the HUD.
local function formatNumber(n: number): string
	local sign = if n < 0 then "-" else ""
	local digits = string.format("%d", math.floor(math.abs(n)))

	-- Peel off three digits at a time from the right.
	local groups = {}
	while #digits > 3 do
		table.insert(groups, 1, string.sub(digits, -3))
		digits = string.sub(digits, 1, -4)
	end
	table.insert(groups, 1, digits)

	return sign .. table.concat(groups, ",")
end

return formatNumber
