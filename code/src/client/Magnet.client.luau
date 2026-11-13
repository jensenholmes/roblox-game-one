-- The player's side of the Magnet: hold the mouse button (or a finger on the screen) near Scrap
-- to pull it. This only shows the progress bar and tells the server what we're pulling;
-- the server (MagnetService) decides when the Scrap actually goes into the Backpack.
local CollectionService = game:GetService("CollectionService")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local Backpack = require(ReplicatedStorage.Shared.Backpack)
local Balancing = require(ReplicatedStorage.Shared.Balancing)
local pullTime = require(ReplicatedStorage.Shared.pullTime)

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local SCRAP_TAG = "Scrap"
local AIM_RADIUS = 80 -- pixels: how close the pointer has to be to a piece of Scrap to aim at it

local player = Players.LocalPlayer

local holdInput: InputObject? = nil -- the mouse button or finger being held, if any
local target: BasePart? = nil -- the Scrap being pulled, if any
local startedAt = 0

-- The progress bar. One is reused, moved onto whichever Scrap is being pulled.
local bar = Instance.new("BillboardGui")
bar.Name = "MagnetProgress"
bar.Size = UDim2.fromOffset(60, 10)
bar.StudsOffset = Vector3.new(0, 2.5, 0)
bar.AlwaysOnTop = true
bar.Enabled = false

local barBackground = Instance.new("Frame")
barBackground.Size = UDim2.fromScale(1, 1)
barBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
barBackground.BorderSizePixel = 0
barBackground.Parent = bar

local barFill = Instance.new("Frame")
barFill.Size = UDim2.fromScale(0, 1)
barFill.BackgroundColor3 = Color3.fromRGB(120, 200, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barBackground

bar.Parent = player:WaitForChild("PlayerGui")

-- Where the pointer is on screen.
local function pointerPosition(): Vector2
	if holdInput and holdInput.UserInputType == Enum.UserInputType.Touch then
		return Vector2.new(holdInput.Position.X, holdInput.Position.Y)
	end
	return UserInputService:GetMouseLocation() - GuiService:GetGuiInset()
end

local function rootPosition(): Vector3?
	local character = player.Character
	local rootPart = character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
	return rootPart and rootPart.Position
end

-- How far a piece of Scrap is from the pointer on screen, in pixels, if it can be pulled.
local function aimDistance(scrap: BasePart, root: Vector3, pointer: Vector2): number?
	if scrap.Parent == nil or (scrap.Position - root).Magnitude > Balancing.MagnetRange then
		return nil -- Collected, or out of range.
	end
	local screenPoint, isOnScreen = Workspace.CurrentCamera:WorldToScreenPoint(scrap.Position)
	if not isOnScreen then
		return nil
	end
	return (Vector2.new(screenPoint.X, screenPoint.Y) - pointer).Magnitude
end

-- Decides what to pull this frame: keep the current Scrap while still aiming near it,
-- otherwise pick the piece closest to the pointer.
local function chooseTarget(): BasePart?
	local root = rootPosition()
	local isFull = Backpack.isFull(player:GetAttribute("Scrap") or 0, player:GetAttribute("BackpackCapacity") or 0)
	if not holdInput or not root or isFull then
		return nil
	end

	local pointer = pointerPosition()
	if target then
		local distance = aimDistance(target, root, pointer)
		if distance and distance <= AIM_RADIUS * 2 then
			return target
		end
	end

	local closest, closestDistance = nil, AIM_RADIUS
	for _, scrap in CollectionService:GetTagged(SCRAP_TAG) do
		local distance = aimDistance(scrap, root, pointer)
		if distance and distance <= closestDistance then
			closest, closestDistance = scrap, distance
		end
	end
	return closest
end

UserInputService.InputBegan:Connect(function(input, isUsedByGame)
	if isUsedByGame then
		return -- e.g. a tap on the jump button or joystick.
	end
	local inputType = input.UserInputType
	if inputType == Enum.UserInputType.MouseButton1 or inputType == Enum.UserInputType.Touch then
		holdInput = input
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input == holdInput then
		holdInput = nil
	end
end)

RunService.RenderStepped:Connect(function()
	local newTarget = chooseTarget()
	if newTarget ~= target then
		target = newTarget
		if target then
			startedAt = os.clock()
			Remotes.MagnetStart:FireServer(target)
		else
			Remotes.MagnetStop:FireServer()
		end
	end

	if target then
		local seconds = pullTime(Balancing.ScrapToughness, Balancing.StarterMagnetStrength)
		local progress = math.clamp((os.clock() - startedAt) / seconds, 0, 1)
		barFill.Size = UDim2.fromScale(progress, 1)
		bar.Adornee = target
		bar.Enabled = true
	else
		bar.Enabled = false
	end
end)
