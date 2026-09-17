# ARC5 Lean 4 release notes

This directory contains release notes for the ARC5 formalization.

The reproducible ARC5 source is distributed as part of the combined archive:

- [ARC3_ARC5_Lean4_Source.zip](../ARC3_ARC5_Lean4_Source.zip)

The ARC5 proof has a long dependency chain, including local-density stages and the Stage5 pumping/change-set stages, culminating in:

- `ARC5Stage5W_PositiveRigidity_v2.lean`
- `ARC5Final.lean`

Representative verified components include:

- local-density / dyadic coalescence stages,
- exact-level base-5 kernel and transition-graph stages,
- disagreement and nowhere-thickness stages,
- numerical word-pumping and dyadic child-filling stages,
- MSD topological pumping closure,
- adjacent-change automaticity and finiteness,
- eventual constancy and positive-domain rigidity.

## Important dependency note

Because multiple development versions exist for some intermediate files, the public source is distributed from the cleaned dependency closure of the exact verified local Lean project tree, together with the required shared ARC modules and project metadata. It should not be reconstructed by selecting isolated historical files.

The main ARC5 proof route does not use Cobham's theorem.
