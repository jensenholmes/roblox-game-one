# The map lives in Roblox, not in Git

The map (terrain, buildings, spawn points) is built in Studio and saved/published to Roblox, which keeps its own version history. It is not exported into the Rojo project. Exporting it would mean remembering to re-export after every change, and forgetting would let the next Rojo sync overwrite the map with an old version. Rojo manages files (code and `.rbxm` models); Studio manages the map.
