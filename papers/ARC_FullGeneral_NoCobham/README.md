# Cobham-Free Full General ARC

**First released: September 23, 2026**

This directory contains the new independent Full General ARC release that removes the final explicit Cobham dependency from the integrated all-base proof.

- [English paper](ARC_FullGeneral_NoCobham_English.pdf)
- [Japanese paper / 日本語版](ARC_FullGeneral_NoCobham_Japanese.pdf)

The earlier ARC papers are intentionally retained and are not superseded or withdrawn. This release records a later strengthening of the proof architecture.

## Main result

For every base \(B\ge2\), every base-\(B\) finite-kernel automatic coloring invariant under the shortcut Collatz map is constant on all positive integers.

The final Lean route requires neither an explicit `ARCCobhamPrinciple` hypothesis nor a `[Finite α]` typeclass assumption.

This is not a proof of the Collatz conjecture.
