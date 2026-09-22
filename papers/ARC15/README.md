# ARC15 — base 15

This directory contains the ARC15 manuscripts.

- [ARC15_English.pdf](ARC15_English.pdf) — English Lean-verified paper
- [ARC15_Japanese.pdf](ARC15_Japanese.pdf) — Japanese version / 日本語版

## Main result

Every finite-valued base-15 automatic sequence invariant under the shortcut Collatz map

\[
T(2n)=n,\qquad T(2n+1)=3n+2
\]

is constant on the positive integers. The value at index zero is genuinely free.

ARC15 is an odd-composite stress test. Since 15-automaticity does not in general imply 3-automaticity or 5-automaticity, the result is not obtained simply by combining ARC3 and ARC5.

The proof uses doubled-loop pumping, exact two-adic control of geometric pumping sums, dyadic residue filling, topological pumping, finiteness of the adjacent-change set, eventual constancy, and doubling invariance.

The ARC15 main route does not use Cobham's theorem.

## Lean endpoints

- `arc15_final` — finite-kernel final theorem
- `arc15_main_zero_digit_standard_msd_form` — usual canonical MSD automaticity form
- `arc15_zero_value_is_genuinely_free` — sharpness at zero

Version 1.0 — September 22, 2026.
