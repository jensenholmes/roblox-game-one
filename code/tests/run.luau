-- Runs every *.spec.luau file in this folder. From the repo root: lune run code/tests/run.luau
local fs = require("@lune/fs")
local process = require("@lune/process")
local TestKit = require("./TestKit")

for _, fileName in fs.readDir("code/tests") do
	local specName = string.match(fileName, "^(.+)%.spec%.luau$")
	if specName then
		print(fileName)
		require("./" .. specName .. ".spec")
	end
end

local passed, failed = TestKit.summary()
print(`\n{passed} passed, {failed} failed`)
process.exit(if failed > 0 then 1 else 0)
