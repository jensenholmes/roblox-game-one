-- Turns Scrap into Stardust when a player steps onto a Sell Pad. Decided on the server.
-- Sell Pads are Parts in the map tagged "SellPad". Stardust is stored as an attribute on the
-- player, so the HUD (#13) can show it.
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Balancing = require(ReplicatedStorage.Shared.Balancing)
local sellScrap = require(ReplicatedStorage.Shared.sellScrap)
local shouldSell = require(ReplicatedStorage.Shared.shouldSell)

local PAD_TAG = "SellPad"
local PAD_HEIGHT = 6 -- studs above the pad's top that still count as standing on it

local SellService = {}

local wasOnPad: { [Player]: boolean } = {}

-- Is this position standing on (just above) the pad?
local function isAbovePad(position: Vector3, pad: BasePart): boolean
	local relative = pad.CFrame:PointToObjectSpace(position) -- position as seen from the pad's centre
	local half = pad.Size / 2
	local heightAboveTop = relative.Y - half.Y
	return math.abs(relative.X) <= half.X
		and math.abs(relative.Z) <= half.Z
		and heightAboveTop >= 0
		and heightAboveTop <= PAD_HEIGHT
end

local function isOnAnyPad(player: Player, pads: { BasePart }): boolean
	local character = player.Character
	local rootPart = character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not rootPart then
		return false
	end
	for _, pad in pads do
		if isAbovePad(rootPart.Position, pad) then
			return true
		end
	end
	return false
end

local function sell(player: Player)
	local scrap, stardust = sellScrap(
		player:GetAttribute("Scrap") or 0,
		player:GetAttribute("Stardust") or 0,
		Balancing.StardustPerScrap
	)
	player:SetAttribute("Scrap", scrap)
	player:SetAttribute("Stardust", stardust)
end

local function onPlayerAdded(player: Player)
	player:SetAttribute("Stardust", 0) -- Saving between visits comes in #14.
end

function SellService.start()
	local pads = {}
	for _, pad in CollectionService:GetTagged(PAD_TAG) do
		if pad:IsA("BasePart") then
			table.insert(pads, pad)
		end
	end
	if #pads == 0 then
		warn(`No Sell Pad found. Tag a Part "{PAD_TAG}" in Studio.`)
	end

	Players.PlayerAdded:Connect(onPlayerAdded)
	for _, player in Players:GetPlayers() do
		onPlayerAdded(player)
	end
	Players.PlayerRemoving:Connect(function(player)
		wasOnPad[player] = nil
	end)

	RunService.Heartbeat:Connect(function()
		for _, player in Players:GetPlayers() do
			local isOnPad = isOnAnyPad(player, pads)
			if shouldSell(wasOnPad[player] == true, isOnPad) then
				sell(player)
			end
			wasOnPad[player] = isOnPad
		end
	end)
end

return SellService
