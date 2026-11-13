-- Lowers gravity for the whole game. Setting it on the server copies it to every player.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Balancing = require(ReplicatedStorage.Shared.Balancing)

Workspace.Gravity = Balancing.Gravity
