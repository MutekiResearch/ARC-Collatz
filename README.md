# ARC-Collatz

Automatic Rigidity for Collatz-Invariant Automatic Sequences

## Overview

This repository collects mathematical investigations on automatic sequences and the shortcut Collatz map

\[
T(n)=
\begin{cases}
n/2, & n \equiv 0 \pmod 2,\\
(3n+1)/2, & n \equiv 1 \pmod 2.
\end{cases}
\]

The central question is how strongly Collatz invariance constrains sequences that are automatic in a fixed base.

> If a finite-alphabet sequence is automatic in base \(b\) and is invariant under the shortcut Collatz map, must it be constant on the positive integers?

The repository contains ARC2, ARC3, ARC5, ARC7, and the all-even-base base-factor-descent development.

**Important:** this project does **not** claim to prove the Collatz conjecture.

---

## Releases

### ARC2 — base 2 / earlier release

- [English paper (PDF)](papers/ARC2/ARC2_English.pdf)
- [Japanese paper / 日本語版 (PDF)](papers/ARC2/ARC2_Japanese.pdf)
- [ARC2 paper directory](papers/ARC2/)
- [ARC2 Lean 4 source archive](lean/ARC2/ARC2_Lean4_Source.zip)

### ARC3 — base 3

- [English paper (PDF)](papers/ARC3/ARC3_English.pdf)
- [Japanese paper / 日本語版 (PDF)](papers/ARC3/ARC3_Japanese.pdf)
- [ARC3 paper directory](papers/ARC3/)

ARC3 proves positive-domain constancy for 3-automatic shortcut-Collatz-invariant sequences. The proof uses kernel transfer to base 2, Cobham's theorem, and period elimination. Cobham's theorem is used as an explicit external mathematical principle.

### ARC5 — base 5

- [English paper (PDF)](papers/ARC5/ARC5_English.pdf)
- [Japanese paper / 日本語版 (PDF)](papers/ARC5/ARC5_Japanese.pdf)
- [ARC5 paper directory](papers/ARC5/)

ARC5 proves positive-domain constancy for 5-automatic shortcut-Collatz-invariant sequences. The proof proceeds through local synchronization, dyadic thinness, base-5 pumping, finiteness of the adjacent-change set, eventual constancy, and propagation by doubling invariance.

The main ARC5 route does **not** use Cobham's theorem.

### ARC7 — base 7

- [English paper (PDF)](papers/ARC7/ARC7_English.pdf)
- [Japanese paper / 日本語版 (PDF)](papers/ARC7/ARC7_Japanese.pdf)
- [ARC7 paper directory](papers/ARC7/)
- [ARC7 Lean 4 source archive](lean/ARC7/ARC7_Lean4_Source.zip)

ARC7 proves positive-domain constancy for 7-automatic shortcut-Collatz-invariant sequences.

Its characteristic mechanism is a doubled-loop pumping construction. For a loop of length \(L\),

\[
7^{2L}\equiv1\pmod 8,
\]

which restores exact dyadic control. The proof then passes through dyadic residue permutation and child filling, topological pumping, finiteness of the change set, eventual constancy, and propagation to all positive integers.

The ARC7 main proof does **not** use Cobham's theorem. The value at zero remains genuinely free, and this sharpness is formalized in Lean.

### All even bases — base-factor descent

- [English paper (PDF)](papers/ARC_EvenBase/ARC_EvenBase_English.pdf)
- [Japanese paper / 日本語版 (PDF)](papers/ARC_EvenBase/ARC_EvenBase_Japanese.pdf)
- [All-even-base paper directory](papers/ARC_EvenBase/)
- [All-even-base Lean 4 source archive](lean/ARC_EvenBase/ARC_EvenBase_Lean4_Source.zip)

For every even base \(B\ge2\), the development proves that a finite-valued \(B\)-automatic sequence invariant under the shortcut Collatz map is constant on all positive integers.

The structural ingredient is base-factor descent:

\[
(2^s m)\text{-automatic}\Longrightarrow m\text{-automatic}
\]

under doubling invariance, where \(m\) is the odd part of \(B\).

If \(m=1\), the proof descends to ARC2. If \(m>1\), the bases \(B\) and \(m\) are multiplicatively independent, so Cobham's theorem gives ultimate periodicity; a base-independent period-collapse argument then gives positive-domain constancy.

In Lean, Cobham's theorem is supplied as the explicit theorem parameter ARCCobhamPrinciple; it is not registered as a custom global axiom.

---

## Lean 4 formalization

- [ARC2 Lean 4 source archive](lean/ARC2/ARC2_Lean4_Source.zip)
- [ARC3 + ARC5 Lean 4 source archive](lean/ARC3_ARC5_Lean4_Source.zip)
- [ARC7 Lean 4 source archive](lean/ARC7/ARC7_Lean4_Source.zip)
- [All-even-base Lean 4 source archive](lean/ARC_EvenBase/ARC_EvenBase_Lean4_Source.zip)
- [Lean release notes](lean/README.md)

The ARC7 archive contains the active Stage 1-14 chain together with ARC7Final.lean, ARC7Audit_v2.lean, and ARC7Sharpness_v3.lean.

The all-even-base archive contains the base-factor-descent Stage 1-9 chain together with ARCBaseFactorDescentFinalAudit.lean.

Principal endpoints include arc7_final and arc_evenBase_final_of_cobham.

Lean verification checks the formal proof as encoded. It does not by itself establish literature novelty, nor does it replace mathematical scrutiny of definitions, imported assumptions, and model choices.

---

## Repository structure

    ARC-Collatz/
    ├─ README.md
    ├─ papers/
    │  ├─ ARC2/
    │  ├─ ARC3/
    │  ├─ ARC5/
    │  ├─ ARC7/
    │  └─ ARC_EvenBase/
    └─ lean/
       ├─ README.md
       ├─ ARC2/
       ├─ ARC3/
       ├─ ARC5/
       ├─ ARC7/
       ├─ ARC_EvenBase/
       └─ ARC3_ARC5_Lean4_Source.zip

---

## Relationship to the Collatz conjecture

ARC2, ARC3, ARC5, ARC7, and the all-even-base theorem are rigidity results for automatic sequences constrained by shortcut-Collatz invariance.

They should be viewed as structural results around the Collatz problem rather than as proofs of the Collatz conjecture itself.

---

## Results at a glance

| Result | Automatic base(s) | Main mechanism | Cobham in main route | Conclusion |
|---|---|---|---|---|
| ARC2 | 2 | base-2 rigidity | explicit external principle | constant on positive integers |
| ARC3 | 3 | kernel transfer to base 2 | explicit external principle | constant on positive integers |
| ARC5 | 5 | local synchronization + dyadic pumping | no | constant on positive integers |
| ARC7 | 7 | doubled-loop pumping + dyadic filling | no | constant on positive integers |
| Even-base ARC | every even \(B\ge2\) | base-factor descent + odd-part split | yes for the non-pure branch | constant on positive integers |

---

## Current status

- ARC2: public release organized.
- ARC3: English/Japanese manuscripts and Lean development released.
- ARC5: English/Japanese manuscripts and Lean development released.
- ARC7: English/Japanese manuscripts, Lean Stage 1-14 chain, final theorem, audit, and sharpness prepared for release.
- All-even-base ARC: English/Japanese submission-style manuscripts, Lean Stage 1-9 chain, and independent final audit prepared for release.
- Next planned stress test: odd composite bases, beginning with ARC15.

The project continues to emphasize adversarial review of the Lean dependency chain, explicit axiom/dependency audits, definition-level checking, and separate literature/novelty auditing.

---

## Authorship and AI disclosure

**Author:** Muteki  
Independent Researcher (Japan)

Generative AI, including OpenAI ChatGPT, was used as a research and drafting aid for mathematical exploration, Lean development, proof checking, manuscript preparation, literature-search assistance, and repository organization.

The AI system is not listed as an author or bibliographic source. Responsibility for the released material remains with the human author.

---

## License / reuse

No explicit open-source or document license is asserted here unless a separate LICENSE file is added to the repository.

If you wish to reuse substantial portions of the manuscript or Lean source, please check the repository license status first and cite the project appropriately.

---

## Disclaimer

This repository is an independent mathematical research project. It is not an official publication of a university, company, or other institution.

The results should be evaluated from the definitions, proofs, Lean sources, stated assumptions, and cited literature contained in each release.
