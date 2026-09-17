# ARC-Collatz

Automatic Rigidity for Collatz-Invariant Automatic Sequences

## Overview

This repository collects a series of mathematical investigations on automatic sequences and the shortcut Collatz map

\[
T(n)=
\begin{cases}
n/2, & n \equiv 0 \pmod 2,\\
(3n+1)/2, & n \equiv 1 \pmod 2.
\end{cases}
\]

The central question is how strongly Collatz invariance constrains sequences that are automatic in a fixed base.

The ARC project studies statements of the form:

> If a finite-alphabet sequence is automatic in base \(b\) and is invariant under the shortcut Collatz map, must it be constant on the positive integers?

The current public development focuses on the base-3 and base-5 cases.

**Important:** this project does **not** claim to prove the Collatz conjecture.

---

## Main results

### ARC3 — base 3

For a finite-alphabet sequence \(a : \mathbb{N} \to A\), assume

\[
a_{2n}=a_n, \qquad a_{2n+1}=a_{3n+2},
\]

and assume that \(a\) is 3-automatic.

The ARC3 result shows that \(a\) is constant on all positive integers. The value at \(0\) is not forced by the theorem.

The proof route is based on a kernel-transfer argument from base 3 to base 2, followed by Cobham's theorem and a period-elimination argument.

**Formalization note:** the Lean 4 development formalizes the ARC3 argument, while Cobham's theorem is used as an external mathematical assumption rather than reproved inside the project.

### ARC5 — base 5

For a finite-alphabet sequence invariant under the shortcut Collatz map and automatic in base 5, the ARC5 development again proves constancy on all positive integers.

The ARC5 proof is structurally different from ARC3. Its main route is:

1. finite Collatz local synchronization,
2. dyadic thinness of disagreement/change sets,
3. base-5 finite-state pumping,
4. finiteness of the adjacent-change set,
5. eventual constancy,
6. propagation from the constant tail to every positive integer using doubling invariance.

The main ARC5 route does **not** rely on Cobham's theorem.

---

## Project structure

The repository is being reorganized into the following layout:

```text
ARC-Collatz/
├─ README.md
├─ papers/
│  ├─ ARC3/
│  │  ├─ ARC3_English.pdf
│  │  └─ ARC3_Japanese.pdf
│  └─ ARC5/
│     ├─ ARC5_English.pdf
│     └─ ARC5_Japanese.pdf
├─ lean/
│  ├─ ARC3/
│  └─ ARC5/
└─ archive/
   └─ earlier public release files
```

Until that reorganization is complete, the original public-release files remain at the repository root.

---

## Formal verification

The project uses Lean 4 to audit the proof structure and theorem dependencies.

Representative ARC3 files include:

- `ARC3KernelTransfer.lean`
- `ARC3Main.lean`
- `ARC3Audit.lean`

Representative ARC5 files include the local-density and Stage5 chains, culminating in:

- `ARC5Stage5W_PositiveRigidity_v2.lean`
- `ARC5Final.lean`

The final ARC5 theorem has the form

```lean
theorem arc5_final
    {α : Type u}
    (a : ℕ → α)
    (hinv : ∀ n : ℕ, a (arcShortcutNat n) = a n)
    (ha5 : ARCAutomaticByKernel 5 a) :
    ∃ c : α, ∀ n : ℕ, 0 < n → a n = c
```

Lean verification checks the formal proof as encoded. It does not by itself establish literature novelty, nor does it replace mathematical scrutiny of definitions, imported assumptions, and model choices.

---

## Relationship to the Collatz conjecture

ARC3 and ARC5 are rigidity results for automatic sequences constrained by Collatz invariance.

They should be viewed as structural results around the Collatz problem rather than a proof of the Collatz conjecture itself.

One consequence considered in the papers is that the characteristic sequence of certain Collatz-invariant sets would be severely constrained if it were automatic in the relevant base. Such reformulations are useful for studying where automaticity can and cannot occur, but they do not by themselves settle the global Collatz conjecture.

---

## ARC3 and ARC5 at a glance

| Item | ARC3 | ARC5 |
|---|---|---|
| Automatic base | 3 | 5 |
| Main bridge | 3-kernel to 2-kernel | Local synchronization to dyadic thinness |
| Finite-state step | Cobham / eventual periodicity | Base-5 pumping / finite support |
| Endgame | Period elimination | Finite change set to eventual constancy |
| Cobham theorem | External assumption | Not used in the main route |
| Conclusion | Constant on positive integers | Constant on positive integers |

---

## Current status

- ARC3: mathematical paper prepared; Lean formalization completed for the project theorem, with Cobham used externally.
- ARC5: mathematical paper prepared; Lean formalization reaches the packaged final positive-rigidity theorem.
- Public repository reorganization: in progress.
- Further bases and a more general ARC framework are planned as later investigations.

Before treating any release as final, the project continues to emphasize:

- adversarial review of the Lean dependency chain,
- explicit axiom/dependency audits,
- definition-level checking,
- and a separate literature/novelty audit.

---

## Authorship and AI disclosure

**Author:** Muteki  
Independent Researcher (Japan)

Generative AI, including OpenAI ChatGPT, was used as a research and drafting aid for mathematical exploration, Lean development, proof checking, manuscript preparation, and repository organization.

The AI system is not listed as an author or bibliographic source. Responsibility for the released material remains with the human author.

---

## Existing public-release files

The repository currently also contains the original release files:

- `ARC_Automatic_Rigidity_Collatz_Muteki_EN.pdf`
- `ARC_Automatic_Rigidity_Collatz_Muteki_JA.pdf`
- `ARC_Lean4_Source.zip`

These are retained during the transition to the ARC3/ARC5 folder structure.

---

## License / reuse

No explicit open-source or document license is asserted here unless a separate `LICENSE` file is added to the repository.

If you wish to reuse substantial portions of the manuscript or Lean source, please check the repository license status first and cite the project appropriately.

---

## Disclaimer

This repository is an independent mathematical research project. It is not an official publication of a university, company, or other institution.

The results should be evaluated from the definitions, proofs, Lean sources, stated assumptions, and cited literature contained in each release.
