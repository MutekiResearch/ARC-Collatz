# ARC7 Lean 4 source

This directory contains the public ARC7 Lean 4 source archive.

- [ARC7_Lean4_Source.zip](ARC7_Lean4_Source.zip)

The archive contains the ARC7-specific verified source chain:

- Stage 1–14
- `ARC7Final.lean`
- `ARC7Audit_v2.lean`
- `ARC7Sharpness_v3.lean`
- a convenience `ARC7Release.lean` import file

The source retains imports of shared ARC project modules (including automaticity bridges and earlier pumping infrastructure), so this archive is intended to accompany the larger ARC project rather than vendor every shared dependency.

The principal public endpoints are:

- `arc7_final`
- `arc7_main_zero_digit_standard_msd_form`
- `arc7_zero_value_is_genuinely_free`

The successful final axiom audits reported only standard Lean/Mathlib dependencies such as `propext`, `Classical.choice`, and `Quot.sound`; no `sorryAx` appears in the verified final chain.

The active ARC7 main proof does **not** use `ARCCobhamPrinciple`.
