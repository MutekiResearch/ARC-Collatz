# ARC Even-Base Lean 4 source

This directory contains the public Lean 4 source archive for the base-factor descent / all-even-base ARC development.

- [ARC_EvenBase_Lean4_Source.zip](ARC_EvenBase_Lean4_Source.zip)

The packaged development contains Stage 1–9 and \`ARCBaseFactorDescentFinalAudit.lean\`.

Principal endpoint:

- \`arc_evenBase_final_of_cobham\`

The proof covers every even base \(B\ge2\). The final audit independently re-derives the all-even conclusion without relying on the packaged Stage 8/9 final wrappers and includes concrete smoke tests for bases 4, 18, 64, and 100.

The successful axiom audits report only standard Lean/Mathlib dependencies such as \`propext\`, \`Classical.choice\`, and \`Quot.sound\`. \`ARCCobhamPrinciple\` is an explicit theorem parameter rather than a declared global axiom.
