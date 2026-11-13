-- The server's side of the Magnet. Players only ask to start or stop pulling; this decides
-- whether a pull is allowed and when it's finished, because players can tamper with their own computer.
-- Each player's Backpack is stored as attributes on the player, so the HUD (#13) can show it:
--   Scrap            - how much Scrap is in the Backpack
--   BackpackCapacity - how much it holds
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Backpack = require(ReplicatedStorage.Shared.Backpack)
local Balancing = require(ReplicatedStorage.Shared.Balancing)
local checkPull = require(ReplicatedStorage.Shared.checkPull)
local pullTime = require(ReplicatedStorage.Shared.pullTime)
local ScrapService = require(script.Parent.ScrapService)

local Remotes = ReplicatedStorage.Remotes

-- The server sees each player's position a moment late, so it allows a little extra range.
local RANGE_ALLOWANCE = 5

type Pull = { scrap: BasePart, startedAt: number }

local MagnetService = {}

local pulls: { [Player]: Pull } = {} -- each player who is pulling → what and since when

local function distanceToScrap(player: Player, scrap: BasePart): number
	local character = player.Character
	local rootPart = character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not rootPart then
		return math.huge -- No character, so treat it as out of range.
	end
	return (rootPart.Position - scrap.Position).Magnitude
end

-- Asks checkPull how this player's pull is going.
local function checkPlayersPull(player: Player, pull: Pull, now: number): checkPull.PullResult
	return checkPull(
		now - pull.startedAt,
		pullTime(Balancing.ScrapToughness, Balancing.StarterMagnetStrength),
		distanceToScrap(player, pull.scrap),
		Balancing.MagnetRange + RANGE_ALLOWANCE,
		player:GetAttribute("Scrap") or 0,
		player:GetAttribute("BackpackCapacity") or 0
	)
end

local function onMagnetStart(player: Player, scrap: any)
	-- Never trust what a player sends: check it really is Scrap that's in the world right now.
	if not ScrapService.isScrap(scrap) then
		pulls[player] = nil
		return
	end

	local pull = { scrap = scrap, startedAt = os.clock() }
	if checkPlayersPull(player, pull, pull.startedAt) == "pulling" then
		pulls[player] = pull
	else
		pulls[player] = nil -- Out of range or Backpack full.
	end
end

local function onMagnetStop(player: Player)
	pulls[player] = nil
end

local function onPlayerAdded(player: Player)
	player:SetAttribute("Scrap", 0) -- Saving between visits comes in #14.
	player:SetAttribute("BackpackCapacity", Balancing.StarterBackpackCapacity)
end

function MagnetService.start()
	Remotes.MagnetStart.OnServerEvent:Connect(onMagnetStart)
	Remotes.MagnetStop.OnServerEvent:Connect(onMagnetStop)

	Players.PlayerAdded:Connect(onPlayerAdded)
	for _, player in Players:GetPlayers() do
		onPlayerAdded(player)
	end
	Players.PlayerRemoving:Connect(function(player)
		pulls[player] = nil
	end)

	-- Every frame, referee every pull.
	RunService.Heartbeat:Connect(function()
		local now = os.clock()
		for player, pull in pulls do
			if not ScrapService.isScrap(pull.scrap) then
				pulls[player] = nil -- Someone else finished pulling it first.
				continue
			end

			local result = checkPlayersPull(player, pull, now)
			if result == "done" then
				pulls[player] = nil
				-- collect() only succeeds once per piece, so two players can't both get it.
				if ScrapService.collect(pull.scrap) then
					local newCount = Backpack.add(player:GetAttribute("Scrap"), player:GetAttribute("BackpackCapacity"))
					player:SetAttribute("Scrap", newCount)
				end
			elseif result ~= "pulling" then
				pulls[player] = nil -- Out of range or Backpack full.
			end
		end
	end)
end

return MagnetService
