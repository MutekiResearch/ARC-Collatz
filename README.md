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

The current public development focuses on the base-3 and base-5 cases.

**Important:** this project does **not** claim to prove the Collatz conjecture.

---

## Releases

### ARC3 — base 3

- [English paper (PDF)](papers/ARC3/ARC3_English.pdf)
- [Japanese paper / 日本語版 (PDF)](papers/ARC3/ARC3_Japanese.pdf)
- [ARC3 paper directory](papers/ARC3/)

For a finite-alphabet sequence \(a : \mathbb{N} \to A\), assume

\[
a_{2n}=a_n, \qquad a_{2n+1}=a_{3n+2},
\]

and assume that \(a\) is 3-automatic. ARC3 proves that \(a\) is constant on all positive integers; the value at \(0\) remains free.

The proof route uses a kernel-transfer argument from base 3 to base 2, followed by Cobham's theorem and period elimination.

**Formalization note:** Cobham's theorem is used as an explicit external mathematical principle rather than reproved inside the project.

### ARC5 — base 5

- [English paper (PDF)](papers/ARC5/ARC5_English.pdf)
- [Japanese paper / 日本語版 (PDF)](papers/ARC5/ARC5_Japanese.pdf)
- [ARC5 paper directory](papers/ARC5/)

For a finite-alphabet sequence invariant under the shortcut Collatz map and automatic in base 5, ARC5 again proves constancy on all positive integers.

Its proof is structurally different from ARC3:

1. finite Collatz local synchronization,
2. dyadic thinness of disagreement/change sets,
3. base-5 finite-state pumping,
4. finiteness of the adjacent-change set,
5. eventual constancy,
6. propagation from the constant tail to every positive integer by doubling invariance.

The main ARC5 route does **not** use Cobham's theorem.

---

## Lean 4 formalization

- [ARC3 + ARC5 Lean 4 source archive](lean/ARC3_ARC5_Lean4_Source.zip)
- [Lean release notes](lean/README.md)

The public source archive was prepared from the verified local Lean project tree rather than reconstructed from isolated theorem files. This is important because ARC3 uses shared automaticity bridge modules and ARC5 has a long staged dependency chain.

The cleaned release archive contains the project metadata required for reconstruction (`lean-toolchain`, `lakefile.toml`, `lake-manifest.json`) together with the ARC source tree and a source-file manifest.

Representative ARC3 files include:

- `ARC3KernelTransfer.lean`
- `ARC3Main.lean`
- `ARC3Audit.lean`
- `ARC3Consequences.lean`

Representative ARC5 files culminate in:

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

## Repository structure

```text
ARC-Collatz/
├─ README.md
├─ papers/
│  ├─ ARC3/
│  │  ├─ README.md
│  │  ├─ ARC3_English.pdf
│  │  └─ ARC3_Japanese.pdf
│  └─ ARC5/
│     ├─ README.md
│     ├─ ARC5_English.pdf
│     └─ ARC5_Japanese.pdf
├─ lean/
│  ├─ README.md
│  ├─ ARC3/
│  ├─ ARC5/
│  └─ ARC3_ARC5_Lean4_Source.zip
└─ original public-release files at repository root
```

The `lean/ARC3/` and `lean/ARC5/` directories contain release notes; the reproducible combined Lean tree is distributed in the source archive above.

---

## Relationship to the Collatz conjecture

ARC3 and ARC5 are rigidity results for automatic sequences constrained by Collatz invariance.

They should be viewed as structural results around the Collatz problem rather than as proofs of the Collatz conjecture itself.

One consequence considered in the papers is that characteristic sequences of certain Collatz-invariant sets would be severely constrained if they were automatic in the relevant base. Such reformulations help identify where automaticity can and cannot occur, but they do not settle the global Collatz conjecture.

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

- ARC3: English and Japanese Lean-verified manuscripts released on this branch.
- ARC5: English and Japanese manuscripts released on this branch.
- Lean 4: cleaned ARC3 + ARC5 source archive released on this branch.
- Further bases and a more general ARC framework are planned as later investigations.

Before treating the mathematical program as closed, the project continues to emphasize adversarial review of the Lean dependency chain, explicit axiom/dependency audits, definition-level checking, and separate literature/novelty auditing.

---

## Authorship and AI disclosure

**Author:** Muteki  
Independent Researcher (Japan)

Generative AI, including OpenAI ChatGPT, was used as a research and drafting aid for mathematical exploration, Lean development, proof checking, manuscript preparation, and repository organization.

The AI system is not listed as an author or bibliographic source. Responsibility for the released material remains with the human author.

---

## Existing public-release files

The repository also retains the earlier public-release files at the root:

- `ARC_Automatic_Rigidity_Collatz_Muteki_EN.pdf`
- `ARC_Automatic_Rigidity_Collatz_Muteki_JA.pdf`
- `ARC_Lean4_Source.zip`

These are retained for continuity with the earlier release.

---

## License / reuse

No explicit open-source or document license is asserted here unless a separate `LICENSE` file is added to the repository.

If you wish to reuse substantial portions of the manuscript or Lean source, please check the repository license status first and cite the project appropriately.

---

## Disclaimer

This repository is an independent mathematical research project. It is not an official publication of a university, company, or other institution.

The results should be evaluated from the definitions, proofs, Lean sources, stated assumptions, and cited literature contained in each release.
