import Mathlib
import ARC.ARC2CobhamRemovalStage0

set_option autoImplicit false

universe u

namespace ARC

/-!
# Full General ARC — Independent Audit A2

Independent reconstruction of the A2 affine-pullback step:

  shortcut invariance of a
    ->
  dyadic nowhere-thickness of the adjacent-change set of
    b(n) = a(2n+1).

Audit discipline:
* Do NOT call the packaged A2 child theorem.
* Do NOT call the packaged A2 nowhere-thick theorem.
* Do NOT call the Stage-1 public handoff.
* Do NOT use automaticity, Cobham, or Collatz convergence.

We reuse the lower local-density theorem
`arc5_naturalInvariantBlock_in_dyadicCylinder` with gap H = 2,
and generic dyadic-cylinder conversion lemmas.

The A2-specific affine pullback x = 2n+1 is reconstructed below.
-/

/-!
============================================================
1. Independent affine pullback of local density
============================================================
-/

/--
Independent A2 affine child theorem.

For every dyadic parent class in the n-variable there is a deeper integer
dyadic child on which

  a(2n+1) = a(2n+3)

identically.
-/
theorem arcA2_affine_gap_two_child_independent
    {α : Type u}
    (a : ℕ → α)
    (hinv :
      ∀ n : ℕ,
        a (arcShortcutNat n) = a n)
    (m r : ℕ) :
    ∃ K : ℕ,
      ∃ q : ℤ,
        (∀ x : ℤ,
          arcDyadicCylinder K q x →
          arcDyadicCylinder m (r : ℤ) x)
        ∧
        (∃ n0 : ℕ,
          0 < n0 ∧
          arcDyadicCylinder K q (n0 : ℤ))
        ∧
        (∀ n : ℕ,
          arcDyadicCylinder K q (n : ℤ) →
          a (2 * n + 1) = a (2 * n + 3)) := by

  /-
  Apply the lower local-density theorem to the odd affine image of the
  prescribed parent:
      x = 2n+1,
      parent exponent m+1,
      parent residue 2r+1,
      gap H = 2.
  -/
  rcases
    arc5_naturalInvariantBlock_in_dyadicCylinder
      a
      hinv
      2
      (m + 1)
      (2 * (r : ℤ) + 1) with
    ⟨M, s, hParent, hPositive, hBlock⟩

  /-
  Choose one positive natural point y0 in the local-density child.
  Since y0 lies in the odd parent class, write it as 2q+1 with q lying
  in the original n-parent.
  -/
  rcases hPositive with
    ⟨y0, hy0pos, hy0Child⟩

  have hy0Parent :
      arcDyadicCylinder
        (m + 1)
        (2 * (r : ℤ) + 1)
        (y0 : ℤ) :=
    hParent
      (y0 : ℤ)
      hy0Child

  rcases hy0Parent with
    ⟨z, hy0eq⟩

  let q : ℤ :=
    (r : ℤ) + (2 : ℤ) ^ m * z

  have hy0form :
      (y0 : ℤ) = 2 * q + 1 := by
    dsimp [q]
    rw [hy0eq, pow_succ]
    ring

  have hqParent :
      arcDyadicCylinder
        m
        (r : ℤ)
        q := by
    refine ⟨z, ?_⟩
    dsimp [q]

  /-
  Refine the n-variable enough that x -> 2x+1 lands wholly inside the
  local-density child.  The extra m+1 bits come from the affine pullback.
  -/
  let K : ℕ :=
    M + m + 1

  have hChildInsideOriginalParent :
      ∀ x : ℤ,
        arcDyadicCylinder K q x →
        arcDyadicCylinder m (r : ℤ) x := by

    intro x hx

    rcases hx with
      ⟨w, hxw⟩

    rcases hqParent with
      ⟨z0, hqeq⟩

    refine
      ⟨z0 + (2 : ℤ) ^ (M + 1) * w, ?_⟩

    rw [hxw, hqeq]
    dsimp [K]
    simp only [pow_add, pow_succ]
    ring

  have hAffineImageInLocalChild :
      ∀ x : ℤ,
        arcDyadicCylinder K q x →
        arcDyadicCylinder M s (2 * x + 1) := by

    intro x hx

    rcases hx with
      ⟨w, hxw⟩

    rcases hy0Child with
      ⟨v, hy0eqChild⟩

    have hBase :
        2 * q + 1
          =
        s + (2 : ℤ) ^ M * v := by
      exact
        hy0form.symm.trans
          hy0eqChild

    refine
      ⟨v + (2 : ℤ) ^ (m + 2) * w, ?_⟩

    rw [hxw]

    have hExp :
        K + 1 = M + (m + 2) := by
      dsimp [K]
      omega

    calc
      2 * (q + (2 : ℤ) ^ K * w) + 1
          =
      (2 * q + 1) + (2 : ℤ) ^ (K + 1) * w := by
        rw [pow_succ]
        ring

      _ =
      (s + (2 : ℤ) ^ M * v)
        + (2 : ℤ) ^ (K + 1) * w := by
          rw [hBase]

      _ =
      s + (2 : ℤ) ^ M *
        (v + (2 : ℤ) ^ (m + 2) * w) := by
          rw [hExp, pow_add]
          ring

  refine
    ⟨K,
     q,
     hChildInsideOriginalParent,
     ?_,
     ?_⟩

  · rcases
      arcDyadicCylinder_has_positive_nat
        K
        q with
      ⟨n0, hn0pos, hn0cyl⟩

    exact
      ⟨n0, hn0pos, hn0cyl⟩

  · intro n hn

    have hOddChild :
        arcDyadicCylinder
          M
          s
          ((2 * n + 1 : ℕ) : ℤ) := by

      have h :=
        hAffineImageInLocalChild
          (n : ℤ)
          hn

      norm_num at h ⊢
      simpa using h

    have hEq :
        a (2 * n + 1)
          =
        a ((2 * n + 1) + 2) :=
      hBlock
        (2 * n + 1)
        hOddChild
        2
        (by norm_num)

    simpa [Nat.add_assoc] using hEq


/-!
============================================================
2. Independent conversion to natural dyadic nowhere-thickness
============================================================
-/

/--
Independent A2 conclusion:
the adjacent-change set of b(n)=a(2n+1) is dyadically nowhere thick.
-/
theorem arcA2_changeSet_nowhereThick_independent
    {α : Type u}
    (a : ℕ → α)
    (hinv :
      ∀ n : ℕ,
        a (arcShortcutNat n) = a n) :
    ARCGeneralDyadicallyNowhereThick
      (ARCGeneralChangeSet
        (ARC2OddSubseq a)) := by

  intro m r

  rcases
    arcA2_affine_gap_two_child_independent
      a
      hinv
      m
      r with
    ⟨K,
     q,
     hParent,
     _hPositive,
     hAdjacent⟩

  /-
  Convert the integer cylinder C(q,K) to an equivalent natural residue class
  modulo 2^K.  At exponent 0 the "pow5 preimage" helper is simply the generic
  integer-to-natural dyadic-cylinder bridge; no base-5 automaticity enters.
  -/
  rcases
    arc5_pow5_preimage_dyadicCylinder
      0
      K
      q with
    ⟨t, hPreimage⟩

  refine
    ⟨K,
     t,
     ?_,
     ?_,
     ?_⟩

  /- The natural child lies inside the requested natural parent. -/
  · intro n hn

    have hChild :
        arcDyadicCylinder
          K
          q
          (n : ℤ) := by

      have h :=
        hPreimage
          n
          hn

      simpa using h

    have hParentCyl :
        arcDyadicCylinder
          m
          (r : ℤ)
          (n : ℤ) :=
      hParent
        (n : ℤ)
        hChild

    have hIntModeq :
        (n : ℤ)
          ≡
        (r : ℤ)
          [ZMOD ((2 : ℤ) ^ m)] :=
      (arc5_dyadicCylinder_iff_modEq
        m
        (r : ℤ)
        (n : ℤ)).1
        hParentCyl

    apply
      Nat.ModEq.of_natCast
        (M := ℤ)

    simpa
      [AddCommGroup.modEq_iff_intModEq,
       Nat.cast_pow]
      using hIntModeq

  /- Every natural residue class modulo 2^K has a positive representative. -/
  · refine
      ⟨t + 2 ^ K,
       ?_,
       ?_⟩

    · positivity

    · exact
        Nat.add_modEq_right

  /- The whole child is free of adjacent changes of the odd subsequence. -/
  · intro n hn

    have hChild :
        arcDyadicCylinder
          K
          q
          (n : ℤ) := by

      have h :=
        hPreimage
          n
          hn

      simpa using h

    have hEq :
        a (2 * n + 1)
          =
        a (2 * n + 3) :=
      hAdjacent
        n
        hChild

    change
      ¬
      (ARC2OddSubseq a n
        ≠
       ARC2OddSubseq a (n + 1))

    intro hne
    apply hne

    unfold ARC2OddSubseq

    simpa
      [Nat.mul_add, Nat.add_assoc]
      using hEq


/-!
============================================================
3. Public A2 audit target
============================================================
-/

theorem arcA2_target
    {α : Type u}
    (a : ℕ → α)
    (hinv :
      ∀ n : ℕ,
        a (arcShortcutNat n) = a n) :
    ARCGeneralDyadicallyNowhereThick
      (ARCGeneralChangeSet
        (ARC2OddSubseq a)) := by

  exact
    arcA2_changeSet_nowhereThick_independent
      a
      hinv


/-!
============================================================
4. Axiom audit
============================================================
-/

#print axioms arcA2_affine_gap_two_child_independent
#print axioms arcA2_changeSet_nowhereThick_independent
#print axioms arcA2_target

end ARC