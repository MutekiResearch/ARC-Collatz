# ARC3 Lean 4 source

This directory will contain the ARC3-specific Lean 4 files from the verified local project.

Core ARC3 files currently identified:

- `ARC3KernelTransfer.lean`
- `ARC3Main.lean`
- `ARC3Audit.lean`
- `ARC3Consequences.lean`

## Important dependency note

These files are not standalone. In the verified project they import shared ARC modules, including automaticity bridge files and the earlier ARC theorem infrastructure. The public release must therefore include the corresponding shared files and Lean project metadata required for `lake env lean ...` / `lake build` to reproduce the checks.

Cobham's theorem is represented by an explicit external principle in the ARC3 development; it is not reproved internally.
