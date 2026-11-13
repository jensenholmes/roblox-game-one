-- The Jetpack: hold Jump while in the air to rise at a steady speed, using Fuel.
-- Fuel refills when the player stands on something (an Asteroid or the Hub).
-- Runs on the client because each player's computer controls their own character's movement.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Balancing = require(ReplicatedStorage.Shared.Balancing)
local updateFuel = require(ReplicatedStorage.Shared.updateFuel)

local player = Players.LocalPlayer
local fuel = Balancing.MaxFuel

-- A fresh character starts with a full tank.
player.CharacterAdded:Connect(function()
	fuel = Balancing.MaxFuel
end)

RunService.PreSimulation:Connect(function(secondsPassed: number)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local rootPart = character and character:FindFirstChild("HumanoidRootPart")
	if not humanoid or not rootPart or humanoid.Health <= 0 then
		return -- Not spawned yet, respawning, or dead.
	end

	-- Roblox's controls set Humanoid.Jump while the jump input is held:
	-- Space on keyboard, the jump button on phones, A on a controller.
	local isHoldingJump = humanoid.Jump
	local isGrounded = humanoid.FloorMaterial ~= Enum.Material.Air
	local isBoosting = isHoldingJump and not isGrounded and fuel > 0

	if isBoosting then
		-- Rise at a steady speed. A jump that's already rising faster keeps its speed until it slows down.
		local velocity = rootPart.AssemblyLinearVelocity
		local risingSpeed = math.max(velocity.Y, Balancing.JetpackBoostSpeed)
		rootPart.AssemblyLinearVelocity = Vector3.new(velocity.X, risingSpeed, velocity.Z)
	end

	fuel = updateFuel(fuel, secondsPassed, isBoosting, isGrounded, Balancing.MaxFuel, Balancing.FuelRefillTime)

	-- Shared as an attribute so the HUD (#13) can show it. Visible in Studio's Properties panel too.
	player:SetAttribute("Fuel", fuel)
end)
