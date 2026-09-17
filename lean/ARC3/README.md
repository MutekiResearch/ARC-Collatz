# ARC3 Lean 4 release notes

This directory contains release notes for the ARC3 formalization.

The reproducible ARC3 source is distributed as part of the combined archive:

- [ARC3_ARC5_Lean4_Source.zip](../ARC3_ARC5_Lean4_Source.zip)

Core ARC3 files in that archive include:

- `ARC3KernelTransfer.lean`
- `ARC3Main.lean`
- `ARC3Audit.lean`
- `ARC3Consequences.lean`

## Important dependency note

These files are not standalone. In the verified project they import shared ARC modules, including automaticity bridge files and earlier ARC theorem infrastructure. The combined release archive therefore includes the corresponding shared files and Lean project metadata required for reconstruction.

Cobham's theorem is represented by an explicit external principle in the ARC3 development; it is not reproved internally.
