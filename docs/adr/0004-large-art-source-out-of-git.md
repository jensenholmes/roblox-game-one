# Large art source files stay out of Git

Original art files (`.blend`, `.fbx`, `.png`, `.wav`, ...) go in `art-audio/source/`, which `.gitignore` excludes. Git stores a full copy of a binary file every time it changes, which bloats the project, and GitHub rejects files over 100 MB. We considered Git LFS but chose the simpler option; the developer backs up `source/` separately. The small `.rbxm` files in `art-audio/models/` are still tracked.
