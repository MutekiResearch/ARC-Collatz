# ARC Even-Base papers

This directory contains the manuscript for the all-even-base ARC theorem based on base-factor descent.

Released files:

- [ARC_EvenBase_English.pdf](ARC_EvenBase_English.pdf) — English submission-style manuscript
- [ARC_EvenBase_Japanese.pdf](ARC_EvenBase_Japanese.pdf) — Japanese companion manuscript

The main result states that for every even base \(B\ge 2\), a finite-valued \(B\)-automatic sequence invariant under the shortcut Collatz map is constant on all positive integers.

The proof factors

\[
B=2^s m
\]

with \(m\) odd, descends automaticity from \(B\) to \(m\), and then splits into:

- the pure power-of-two branch \(m=1\), reduced to ARC2;
- the non-pure branch \(m\ge 3\), using multiplicative independence, Cobham's theorem, and a base-independent period-collapse argument.

In the Lean development, Cobham's theorem is supplied as the explicit hypothesis \`ARCCobhamPrinciple\`; it is not registered as a custom global axiom.
