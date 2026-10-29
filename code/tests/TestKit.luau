-- A tiny test framework: describe() groups tests, it() is one test, expect() checks a value.
local TestKit = {}

local passed = 0
local failures = {}
local groupName = ""

function TestKit.describe(name: string, body: () -> ())
	groupName = name
	body()
	groupName = ""
end

function TestKit.it(name: string, body: () -> ())
	local fullName = groupName .. " " .. name
	local ok, err = pcall(body)
	if ok then
		passed += 1
		print("  PASS  " .. fullName)
	else
		table.insert(failures, fullName)
		print("  FAIL  " .. fullName .. "\n        " .. tostring(err))
	end
end

function TestKit.expect(actual: any)
	return {
		toBe = function(expected: any)
			if actual ~= expected then
				error(`expected {tostring(expected)}, got {tostring(actual)}`, 2)
			end
		end,
	}
end

function TestKit.summary(): (number, number)
	return passed, #failures
end

return TestKit
