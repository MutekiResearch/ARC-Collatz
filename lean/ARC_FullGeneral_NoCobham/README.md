# Full General ARC — Cobham-Free Closure

**First released:** 2026-09-23

This directory documents the Lean 4 Cobham-removal chain for the final all-base ARC theorem.

Active chain:

1. `ARC2CobhamRemovalStage0.lean`
2. `ARC2CobhamRemovalStage1_Thinness_v3.lean`
3. `ARC2CobhamRemovalStage2_Final_v2.lean`
4. `ARC2CobhamRemovalStage3_FullGeneral.lean`
5. `ARCFullGeneralNoCobhamFinalAudit.lean`

Principal endpoints:

- `arc2CobhamRemoval_stage1_thinness`
- `arc2CobhamRemoval_stage2_final`
- `arc_full_general_no_cobham`
- `arcFinalAudit_full_general_no_cobham`

The final audit checks representative bases 2, 3, 4, 5, 6, 7, 10, 15, 64, and 100.

For the final theorems, `#print axioms` reports only:

- `propext`
- `Classical.choice`
- `Quot.sound`

No `sorryAx` is reported. After importing the final audit into the root project, `lake build` completed successfully with **8906 jobs**.

The source ZIP in the parent `lean/` directory contains this Cobham-removal layer. These files import shared ARC modules from the larger development, including the already verified General Odd ARC and base-factor-descent infrastructure.

This result is a rigidity theorem for finite-kernel automatic colorings invariant under the shortcut Collatz map. It is **not** a proof of the Collatz conjecture.


## Independent A1-A4 audit modules (2026-09-24)

The post-release audit now includes four dedicated reconstruction modules under
[`audit/`](audit/):

- `ARCA1IndependentAudit_v2.lean` - base-2 to base-3 odd-subsequence kernel transfer.
- `ARCA2IndependentAudit.lean` - A2-specific affine pullback from the lower local-density theorem.
- `ARCA3IndependentAudit.lean` - direct non-use reconstruction of the packaged Stage 6-10 residue-permutation / child-filling / finite-support conclusions.
- `ARCA4IndependentAudit_v2.lean` - all-base constructive non-vacuity and sharpness at zero.

Each file passed standalone Lean kernel type-checking and its targeted module build in the recorded project state. The audit scope deliberately reuses lower infrastructure; in particular, A2 reuses the lower local-density theorem and A3 is not a complete transitive import-graph isolation.

See also the revised audit note under `papers/ARC_FullGeneral_NoCobham/audit/`.
