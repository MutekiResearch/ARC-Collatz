# ARC5 Lean 4 source

This directory will contain the ARC5-specific Lean 4 files from the exact local project state that successfully compiled.

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

Because multiple development versions exist for some intermediate files, the public source must not be reconstructed by selecting isolated files from archives. It should be copied from the exact local Lean project tree used for the successful final build, together with the required shared ARC modules and project metadata.

The main ARC5 proof route does not use Cobham's theorem.
