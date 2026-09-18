# Lean 4 formalization

This directory contains the public Lean 4 release material for ARC2, ARC3, ARC5, ARC7, and the all-even-base base-factor-descent development.

## ARC2 source archive

- [ARC2/ARC2_Lean4_Source.zip](ARC2/ARC2_Lean4_Source.zip)

This is the earlier ARC2 Lean 4 archive, reorganized without altering its binary content.

## ARC3 + ARC5 source archive

- [ARC3_ARC5_Lean4_Source.zip](ARC3_ARC5_Lean4_Source.zip)

The ARC3/ARC5 archive was prepared from the verified local project tree and cleaned to retain the ARC3/ARC5 dependency closure together with project metadata needed for reconstruction.

ARC3 uses Cobham's theorem as an explicit external principle. The main ARC5 proof route does not use Cobham's theorem.

## ARC7 source archive

- [ARC7/ARC7_Lean4_Source.zip](ARC7/ARC7_Lean4_Source.zip)
- [ARC7 release notes](ARC7/README.md)

The ARC7 archive contains the active verified Stage 1-14 chain together with:

- ARC7Final.lean
- ARC7Audit_v2.lean
- ARC7Sharpness_v3.lean
- ARC7Release.lean

Principal endpoints include arc7_final, arc7_main_zero_digit_standard_msd_form, and arc7_zero_value_is_genuinely_free.

The ARC7 main proof does not invoke ARCCobhamPrinciple.

## All-even-base source archive

- [ARC_EvenBase/ARC_EvenBase_Lean4_Source.zip](ARC_EvenBase/ARC_EvenBase_Lean4_Source.zip)
- [All-even-base release notes](ARC_EvenBase/README.md)

This archive contains the base-factor-descent Stage 1-9 development together with ARCBaseFactorDescentFinalAudit.lean.

The main endpoint is arc_evenBase_final_of_cobham.

The final audit independently re-derives the all-even conclusion without trusting the packaged Stage 8/9 final wrappers and includes smoke tests for bases 4, 18, 64, and 100.

ARCCobhamPrinciple is an explicit theorem parameter, not a custom global axiom.

## Verification note

The active developments were checked stage by stage by standalone lake env lean runs followed by project-level lake build integration.

For the principal final endpoints and audits, the reported dependencies are standard Lean/Mathlib axioms such as propext, Classical.choice, and Quot.sound.

No sorryAx occurs in the successful final ARC7 or all-even-base chains.
