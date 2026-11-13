-- Caps how fast the local player can fall, every physics step.
-- This runs on the client because each player's computer controls their own character's movement.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Balancing = require(ReplicatedStorage.Shared.Balancing)
local capFallSpeed = require(ReplicatedStorage.Shared.capFallSpeed)

local player = Players.LocalPlayer

RunService.PreSimulation:Connect(function()
	local character = player.Character
	local rootPart = character and character:FindFirstChild("HumanoidRootPart")
	if not rootPart then
		return -- Not spawned yet, or respawning.
	end

	local velocity = rootPart.AssemblyLinearVelocity
	local cappedY = capFallSpeed(velocity.Y, Balancing.TopFallSpeed)
	if cappedY ~= velocity.Y then
		rootPart.AssemblyLinearVelocity = Vector3.new(velocity.X, cappedY, velocity.Z)
	end
end)
