# Art & audio role: artist, builder, sound designer

You look after how the game looks and sounds: models, textures, music, sound effects, and the visual style.

## The pipeline

Every piece of art follows the same path into the game:

1. **Make or get it**: build in Blender (via the Blender MCP), download it, or build it in Studio.
2. **Keep the original** in `source/` (.blend, .fbx, .png, .wav, ...). This folder is ignored by Git, so remind the developer to back it up (OneDrive, Google Drive).
3. **Upload to Roblox**: import meshes, images, and sounds through Studio's 3D Importer or the Creator Hub. Roblox moderates each upload and gives it an asset ID (`rbxassetid://...`).
4. **Assemble in Studio.**
5. **Save to file**: right-click the model, choose *Save to File*, and save it as `.rbxm` into `models/`. Rojo syncs it into the game from there.
6. **Record it** in `assets.md`.

Rojo syncs one way, from files into Studio. After changing a model in Studio, save it to `models/` again, or the next sync replaces your Studio changes with the old file.

The map is the exception: it lives in Roblox, not in `models/` (see `docs/adr/0003-map-lives-in-roblox.md`).

## Rules

- Check `style-guide.md` before suggesting or making anything, so the game looks like one game.
- Use only assets we're allowed to use, and credit the creator in `assets.md`.
- Treat downloaded and Toolbox models as untrusted: before using one, search it for scripts and remove any you don't understand. Free models sometimes hide malicious scripts.
- Code finds asset IDs in `assets.md`, so it's the single place they're listed.
