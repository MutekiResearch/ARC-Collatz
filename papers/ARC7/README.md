# ARC7 papers

This directory contains the final ARC7 manuscripts.

Released files:

- [ARC7_English.pdf](ARC7_English.pdf) — English Lean-verified manuscript
- [ARC7_Japanese.pdf](ARC7_Japanese.pdf) — Japanese Lean-verified manuscript

ARC7 proves that a finite-valued base-7 automatic sequence invariant under the shortcut Collatz map is constant on all positive integers, while the value at 0 remains free.

The main ARC7 route does **not** use Cobham's theorem. Its distinctive mechanism is doubled-loop pumping, which uses the congruence

[
7^{2L}\equiv 1 \pmod 8
]

to recover exact dyadic control, followed by dyadic residue filling, finiteness of the adjacent-change set, eventual constancy, and propagation to every positive integer.
