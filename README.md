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

## Releases

### ARC3 — base 3

- [ARC3 paper directory](papers/ARC3/)
- Planned files:
  - `ARC3_English.pdf`
  - `ARC3_Japanese.pdf`

For a finite-alphabet sequence \(a : \mathbb{N} \to A\), assume

\[
a_{2n}=a_n, \qquad a_{2n+1}=a_{3n+2},
\]

and assume that \(a\) is 3-automatic. ARC3 proves that \(a\) is constant on all positive integers; the value at \(0\) remains free.

The proof route uses a kernel-transfer argument from base 3 to base 2, followed by Cobham's theorem and period elimination.

**Formalization note:** Cobham's theorem is used as an explicit external mathematical principle rather than reproved inside the project.

### ARC5 — base 5

- [ARC5 paper directory](papers/ARC5/)
- Planned files:
  - `ARC5_English.pdf`
  - `ARC5_Japanese.pdf`

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
│  └─ shared/
└─ archive/
   └─ earlier public-release files
```

The paper directories and Lean-release guidance have now been created on the release-preparation branch. The four final PDFs are prepared separately and will be inserted into the corresponding paper directories. The reproducible Lean tree will be copied from the exact local project state that successfully compiled, including shared bridge files and project metadata.

---

## Formal verification

The project uses Lean 4 to audit proof structure and theorem dependencies.

Representative ARC3 files include:

- `ARC3KernelTransfer.lean`
- `ARC3Main.lean`
- `ARC3Audit.lean`
- `ARC3Consequences.lean`

These files also import shared ARC automaticity bridge modules, so the public Lean release must include the relevant shared dependency files rather than only the ARC3-specific files.

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

See [lean/README.md](lean/README.md) for the release strategy.

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

- ARC3: final English and Japanese Lean-verified manuscripts prepared.
- ARC5: final English manuscript prepared; final Japanese manuscript rebuilt from the completed ARC5 proof route and prepared for release.
- ARC3 Lean: theorem chain identified, including required shared bridge dependencies.
- ARC5 Lean: final theorem chain completed locally; public source should be copied from the exact verified project tree rather than reconstructed from isolated archived files.
- Public repository reorganization: active in a draft pull request.
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

The repository currently also contains the original release files at the root:

- `ARC_Automatic_Rigidity_Collatz_Muteki_EN.pdf`
- `ARC_Automatic_Rigidity_Collatz_Muteki_JA.pdf`
- `ARC_Lean4_Source.zip`

These are retained during the transition to the ARC3/ARC5 directory structure.

---

## License / reuse

No explicit open-source or document license is asserted here unless a separate `LICENSE` file is added to the repository.

If you wish to reuse substantial portions of the manuscript or Lean source, please check the repository license status first and cite the project appropriately.

---

## Disclaimer

This repository is an independent mathematical research project. It is not an official publication of a university, company, or other institution.

The results should be evaluated from the definitions, proofs, Lean sources, stated assumptions, and cited literature contained in each release.
