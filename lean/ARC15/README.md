# ARC15 Lean 4 release

This directory contains the ARC15-specific Lean 4 source archive.

- [ARC15_Lean4_Source.zip](ARC15_Lean4_Source.zip)

The archive contains the active ARC15 modules from the arithmetic and geometric-sum setup through doubled-loop pumping, dyadic residue filling, topological pumping, change-set finiteness, eventual constancy, positive rigidity, the packaged final theorem, automaticity audit, and sharpness at zero.

Principal endpoints:

- `arc15_final`
- `arc15_main_zero_digit_standard_msd_form`
- `arc15_kernel_iff_zero_digit_standard_msd`
- `arc15_zero_value_is_genuinely_free`

The reported final dependency audit contains only standard Lean/Mathlib dependencies such as `propext`, `Classical.choice`, and `Quot.sound`; no `sorryAx` appears in the successful ARC15 final chain.

The ARC15 main proof does not invoke `ARCCobhamPrinciple`.

The archive is the ARC15-specific source layer and imports shared ARC infrastructure developed earlier in the project. The integrated local project completed a full `lake build` after the ARC15 sharpness stage.
