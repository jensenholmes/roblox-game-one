# Code in files via Rojo; tasks in GitHub Issues

Code lives as `.luau` files in `code/src/`, synced into Studio by Rojo, instead of only inside Studio. This lets Git track every change, lets Claude read and edit the code, and lets tests run from the terminal, which the TDD and code-review skills need.

Tasks are tracked in GitHub Issues instead of a `PLAN.md` file. A single file would have been simpler to start with, but the developer chose Issues specifically to learn the tool real teams use, and the code-review skill can check code against the issue it was meant to solve.
