-- Owns all Scrap in the world. Only the server runs this, so players can't create or remove Scrap.
-- Spawn points are Parts in the map tagged "ScrapSpawn". Each one holds one piece of Scrap,
-- which comes back Balancing.ScrapRespawnTime seconds after it's collected.
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Balancing = require(ReplicatedStorage.Shared.Balancing)
local isReadyToRespawn = require(ReplicatedStorage.Shared.isReadyToRespawn)

local SPAWN_TAG = "ScrapSpawn"
local SCRAP_TAG = "Scrap" -- The Magnet (#9) will look for this tag.

local ScrapService = {}

local scrapFolder: Folder
local spawnPointOf: { [BasePart]: BasePart } = {} -- each piece of Scrap → the spawn point it came from
local collectedAt: { [BasePart]: number } = {} -- each empty spawn point → when its Scrap was collected

-- Placeholder look until the Scrap model is made.
local function spawnScrap(spawnPoint: BasePart)
	local scrap = Instance.new("Part")
	scrap.Name = "Scrap"
	scrap.Size = Vector3.new(2, 2, 2)
	scrap.Material = Enum.Material.CorrodedMetal
	scrap.Color = Color3.fromRGB(150, 140, 125)
	scrap.CFrame = spawnPoint.CFrame
	scrap.Anchored = true -- Scrap stays still.
	scrap.CanCollide = false
	scrap:AddTag(SCRAP_TAG)
	scrap.Parent = scrapFolder

	spawnPointOf[scrap] = spawnPoint
end

-- Is this a piece of Scrap that's in the world right now? Used to check what players send us.
function ScrapService.isScrap(thing: any): boolean
	return spawnPointOf[thing] ~= nil
end

-- Removes a piece of Scrap and starts its respawn timer.
-- Returns false if it was already collected, so when two players pull the same piece,
-- only the first one gets it.
function ScrapService.collect(scrap: BasePart): boolean
	local spawnPoint = spawnPointOf[scrap]
	if not spawnPoint then
		return false
	end

	spawnPointOf[scrap] = nil
	scrap:Destroy()
	collectedAt[spawnPoint] = os.clock()
	return true
end

function ScrapService.start()
	scrapFolder = Instance.new("Folder")
	scrapFolder.Name = "Scrap"
	scrapFolder.Parent = Workspace

	local spawnPoints = CollectionService:GetTagged(SPAWN_TAG)
	if #spawnPoints == 0 then
		warn(`No Scrap spawn points found. Tag some Parts "{SPAWN_TAG}" in Studio.`)
	end
	for _, spawnPoint in spawnPoints do
		if spawnPoint:IsA("BasePart") then
			spawnScrap(spawnPoint)
		end
	end

	-- Every frame, bring back any Scrap whose respawn time has passed.
	RunService.Heartbeat:Connect(function()
		local now = os.clock()
		for spawnPoint, timeCollected in collectedAt do
			if isReadyToRespawn(timeCollected, now, Balancing.ScrapRespawnTime) then
				collectedAt[spawnPoint] = nil
				spawnScrap(spawnPoint)
			end
		end
	end)
end

return ScrapService
