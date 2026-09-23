import Mathlib
import ARC.ARCProp32

set_option autoImplicit false

universe u

namespace ARC

/-!
# Full General ARC — Independent Audit A1
## Independent reconstruction of the odd-subsequence 3-kernel transfer

Audit target:

  (ARCKernel 2 a).Finite
  + a (2*n) = a n
  + a (2*n+1) = a (3*n+2)

implies

  (ARCKernel 3 (fun n => a (2*n+1))).Finite.

Audit discipline:
* DO NOT use the packaged old finite-kernel transfer theorem.
* DO NOT use the packaged old kernel-inclusion theorem.
* DO NOT use the packaged old affine-transfer theorem.
* DO NOT use Cobham.
* DO NOT use any Collatz-convergence assumption.

The only imported arithmetic infrastructure used below is the already verified
low-level ARC2 arithmetic:
* existence of `s,q` with `2^s*c + 1 = q*3^j`,
* even-branch iteration,
* repeated backward odd-branch transport,
* elementary bounds / index identities.

The kernel inclusion itself is reconstructed here from the definition.
-/

/-- Odd-indexed subsequence used in A1. -/
def ARCA1OddSubseq
    {α : Type u}
    (a : ℕ → α) :
    ℕ → α :=
  fun n => a (2 * n + 1)


/-!
============================================================
1. Independent affine transfer
============================================================
-/

/--
Independent A1 affine-transfer lemma.

For `j >= 1` and `c` coprime to 3 in the elementary sense `¬ 3 ∣ c`,
the affine subsequence

    n ↦ a(3^j*n + c)

is a member of the binary kernel.

This theorem deliberately reconstructs the affine transfer at this layer.
-/
theorem arcA1_affine_mem_two_kernel_independent
    {α : Type u}
    (a : ℕ → α)
    (hEven :
      ∀ n : ℕ,
        a (2 * n) = a n)
    (hOdd :
      ∀ n : ℕ,
        a (2 * n + 1) =
        a (3 * n + 2))
    (j c : ℕ)
    (hj :
      1 ≤ j)
    (hc_pos :
      0 < c)
    (hc_lt :
      c < 3 ^ j)
    (hc3 :
      ¬ 3 ∣ c) :
    (fun n : ℕ => a (3 ^ j * n + c))
      ∈
    ARCKernel 2 a := by

  /-
  Pure arithmetic input: because 2 generates the units modulo 3^j,
  choose s,q with

      2^s*c + 1 = q*3^j.
  -/
  rcases
    arc_exists_s_q
      j
      c
      hj
      hc3 with
    ⟨s, q, hsq⟩

  have hq_pos :
      1 ≤ q := by
    by_contra hq
    have hq0 :
        q = 0 := by
      omega
    subst q
    simp at hsq

  have hq_le :
      q ≤ 2 ^ s :=
    arc_q_le_two_pow
      s
      j
      c
      q
      hc_lt
      hsq

  let r : ℕ :=
    2 ^ j * q - 1

  change
    ∃ E R : ℕ,
      R < 2 ^ E
      ∧
      ∀ n : ℕ,
        a (3 ^ j * n + c)
          =
        a (2 ^ E * n + R)

  refine
    ⟨s + j,
     r,
     ?_,
     ?_⟩

  · dsimp [r]

    exact
      arc_remainder_lt
        s
        j
        q
        hq_pos
        hq_le

  · intro n

    have hM :
        1 ≤ 2 ^ s * n + q := by
      omega

    have hindex1 :
        2 ^ s * (3 ^ j * n + c)
          =
        3 ^ j * (2 ^ s * n + q) - 1 :=
      arc_scaled_index_eq
        s
        j
        c
        q
        n
        hsq

    have hindex2 :
        2 ^ j * (2 ^ s * n + q) - 1
          =
        2 ^ (s + j) * n
          + (2 ^ j * q - 1) :=
      arc_final_index_eq
        s
        j
        q
        n
        hq_pos

    calc
      a (3 ^ j * n + c)
          =
        a (2 ^ s * (3 ^ j * n + c)) := by
          symm
          exact
            arc_even_iter
              a
              hEven
              s
              (3 ^ j * n + c)

      _ =
        a (3 ^ j * (2 ^ s * n + q) - 1) := by
          rw [hindex1]

      _ =
        a (2 ^ j * (2 ^ s * n + q) - 1) := by
          exact
            arc_backward_odd_j
              a
              hOdd
              j
              (2 ^ s * n + q)
              hM

      _ =
        a (2 ^ (s + j) * n + r) := by
          rw [hindex2]


/-!
============================================================
2. Reconstruct K3(odd subsequence) ⊆ K2(a)
============================================================
-/

/--
Every base-3 residual of the odd subsequence is a base-2 residual of `a`.

This is the central A1 inclusion, reconstructed from `ARCKernel` membership.
-/
theorem arcA1_three_kernel_odd_subset_independent
    {α : Type u}
    (a : ℕ → α)
    (hEven :
      ∀ n : ℕ,
        a (2 * n) = a n)
    (hOdd :
      ∀ n : ℕ,
        a (2 * n + 1) =
        a (3 * n + 2)) :
    ARCKernel 3 (ARCA1OddSubseq a)
      ⊆
    ARCKernel 2 a := by

  intro u hu

  have hu' :
      ∃ e r : ℕ,
        r < 3 ^ e
        ∧
        ∀ n : ℕ,
          u n
            =
          a (2 * (3 ^ e * n + r) + 1) := by
    simpa [ARCKernel, ARCA1OddSubseq] using hu

  rcases hu' with
    ⟨e, r, hr, hu_eq⟩

  let c : ℕ :=
    3 * r + 2

  have hc_pos :
      0 < c := by
    dsimp [c]
    omega

  have hc_lt :
      c < 3 ^ (e + 1) := by
    dsimp [c]
    rw [pow_succ]
    omega

  have hc3 :
      ¬ 3 ∣ c := by
    dsimp [c]
    intro h
    rcases h with
      ⟨d, hd⟩
    omega

  have hAffine :
      (fun n : ℕ =>
        a (3 ^ (e + 1) * n + c))
        ∈
      ARCKernel 2 a :=
    arcA1_affine_mem_two_kernel_independent
      a
      hEven
      hOdd
      (e + 1)
      c
      (by omega)
      hc_pos
      hc_lt
      hc3

  have hAffine' :
      ∃ E R : ℕ,
        R < 2 ^ E
        ∧
        ∀ n : ℕ,
          a (3 ^ (e + 1) * n + c)
            =
          a (2 ^ E * n + R) := by
    simpa [ARCKernel] using hAffine

  rcases hAffine' with
    ⟨E, R, hR, hEq⟩

  change
    ∃ E R : ℕ,
      R < 2 ^ E
      ∧
      ∀ n : ℕ,
        u n =
        a (2 ^ E * n + R)

  refine
    ⟨E, R, hR, ?_⟩

  intro n

  calc
    u n
        =
      a (2 * (3 ^ e * n + r) + 1) :=
        hu_eq n

    _ =
      a (3 * (3 ^ e * n + r) + 2) :=
        hOdd (3 ^ e * n + r)

    _ =
      a (3 ^ (e + 1) * n + c) := by
        congr 1
        dsimp [c]
        rw [pow_succ]
        ring

    _ =
      a (2 ^ E * n + R) :=
        hEq n


/-!
============================================================
3. Finite-kernel conclusion
============================================================
-/

/--
Independent A1 finite-kernel theorem.

This is the independent A1 finite-kernel endpoint.
-/
theorem arcA1_three_kernel_odd_finite_independent
    {α : Type u}
    (a : ℕ → α)
    (hEven :
      ∀ n : ℕ,
        a (2 * n) = a n)
    (hOdd :
      ∀ n : ℕ,
        a (2 * n + 1) =
        a (3 * n + 2))
    (hK2 :
      (ARCKernel 2 a).Finite) :
    (ARCKernel 3 (ARCA1OddSubseq a)).Finite := by

  exact
    hK2.subset
      (arcA1_three_kernel_odd_subset_independent
        a
        hEven
        hOdd)


/--
Exact target form requested by Audit A1.
-/
theorem arcA1_target
    {α : Type u}
    (a : ℕ → α)
    (hEven :
      ∀ n : ℕ,
        a (2 * n) = a n)
    (hOdd :
      ∀ n : ℕ,
        a (2 * n + 1) =
        a (3 * n + 2))
    (hK2 :
      (ARCKernel 2 a).Finite) :
    (ARCKernel
      3
      (fun n : ℕ => a (2 * n + 1))).Finite := by

  change
    (ARCKernel 3 (ARCA1OddSubseq a)).Finite

  exact
    arcA1_three_kernel_odd_finite_independent
      a
      hEven
      hOdd
      hK2


/-!
============================================================
4. Axiom / dependency audit
============================================================
-/

#print axioms arcA1_affine_mem_two_kernel_independent
#print axioms arcA1_three_kernel_odd_subset_independent
#print axioms arcA1_three_kernel_odd_finite_independent
#print axioms arcA1_target

end ARC