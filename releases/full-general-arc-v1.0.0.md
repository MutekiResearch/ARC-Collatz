# Full General ARC — Cobham-Free Closure v1.0.0

**Release date:** September 23, 2026  
**Tag:** `full-general-arc-v1.0.0`

This release fixes a reproducible snapshot of the Cobham-free Full General ARC development.

## Main theorem

For every base (B \ge 2), every base-(B) finite-kernel automatic coloring invariant under the shortcut Collatz map is constant on all positive integers.

The final formal route has:

- no explicit `ARCCobhamPrinciple` hypothesis,
- no `[Finite α]` typeclass assumption in the final theorem,
- no `sorryAx`,
- final axiom audit reporting only `propext`, `Classical.choice`, and `Quot.sound`,
- successful project-wide `lake build` with **8906 jobs**.

## Release contents

- expanded English paper (9-page PDF),
- English LaTeX source,
- Japanese paper,
- Lean 4 Cobham-removal source archive,
- SHA-256 checksums for the attached release artifacts.

The earlier ARC papers remain available as historical stages of the development and are not withdrawn or superseded.

## Scope

This is a rigidity theorem for automatic / finite-kernel shortcut-Collatz-invariant colorings. It is **not** a proof of the Collatz conjecture.
