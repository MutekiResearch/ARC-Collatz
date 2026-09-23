import Mathlib
import ARC.ARCBaseFactorDescentStage2

set_option autoImplicit false

universe u

namespace ARC

/-!
# Full General ARC — Independent Audit A4

Independent constructive non-vacuity / sharpness audit.

For every base `base >= 2` and arbitrary values `x,y`, define

    a(0) = x,
    a(n) = y  for n > 0.

We prove directly, without using any ARC rigidity theorem or prior sharpness
package, that:

1. the full base-`base` kernel is finite (indeed, it has at most two states);
2. the sequence is invariant under the shortcut Collatz map;
3. if `x != y`, then the sequence is genuinely nonconstant because
   `a(0) != a(1)`.

Thus the hypotheses of Full General ARC are nonempty for every base >= 2,
and the exclusion of zero from the rigidity conclusion is genuinely sharp.
-/

/-!
============================================================
1. The universal sharpness witness
============================================================
-/

def ARCA4SharpSequence
    {α : Type u}
    (x y : α) :
    ℕ → α :=
  fun n =>
    if n = 0 then x else y


theorem arcA4_sharp_at_zero
    {α : Type u}
    (x y : α) :
    ARCA4SharpSequence x y 0 = x := by
  simp [ARCA4SharpSequence]


theorem arcA4_sharp_on_positive
    {α : Type u}
    (x y : α)
    (n : ℕ)
    (hn : 0 < n) :
    ARCA4SharpSequence x y n = y := by

  have hn0 :
      n ≠ 0 :=
    Nat.ne_of_gt hn

  simp [ARCA4SharpSequence, hn0]


/-!
============================================================
2. Full finite-kernel proof for every base >= 2
============================================================
-/

theorem arcA4_sharp_kernel_finite
    {α : Type u}
    (base : ℕ)
    (hbase2 : 2 ≤ base)
    (x y : α) :
    (ARCKernel
      base
      (ARCA4SharpSequence x y)).Finite := by

  have hfinite :
      ({ARCA4SharpSequence x y,
        (fun _ : ℕ => y)} :
        Set (ℕ → α)).Finite := by

    exact
      (Set.finite_singleton
        (fun _ : ℕ => y)).insert
        (ARCA4SharpSequence x y)

  refine
    hfinite.subset ?_

  intro v hv

  have hv' :
      ∃ e r : ℕ,
        r < base ^ e
          ∧
        ∀ n : ℕ,
          v n =
            ARCA4SharpSequence x y
              (base ^ e * n + r) := by

    simpa [ARCKernel] using hv

  rcases hv' with
    ⟨e, r, hr, hvEq⟩

  by_cases hr0 :
      r = 0

  · have hvSharp :
        v = ARCA4SharpSequence x y := by

      funext n
      rw [hvEq n]

      by_cases hn :
          n = 0

      · subst n
        simp [ARCA4SharpSequence, hr0]

      · have hnpos :
            0 < n :=
          Nat.pos_of_ne_zero hn

        have hbasepos :
            0 < base := by
          omega

        have hpowpos :
            0 < base ^ e :=
          pow_pos hbasepos e

        have hidxpos :
            0 < base ^ e * n := by
          exact
            Nat.mul_pos
              hpowpos
              hnpos

        have hidx :
            base ^ e * n ≠ 0 :=
          Nat.ne_of_gt hidxpos

        simp
          [ARCA4SharpSequence,
           hr0,
           hn,
           hidx]

    simp [hvSharp]

  · have hrpos :
        0 < r :=
      Nat.pos_of_ne_zero hr0

    have hvConst :
        v = (fun _ : ℕ => y) := by

      funext n
      rw [hvEq n]

      have hidxpos :
          0 < base ^ e * n + r := by
        omega

      exact
        arcA4_sharp_on_positive
          x
          y
          (base ^ e * n + r)
          hidxpos

    simp [hvConst]


theorem arcA4_sharp_automatic
    {α : Type u}
    (base : ℕ)
    (hbase2 : 2 ≤ base)
    (x y : α) :
    ARCAutomaticByKernel
      base
      (ARCA4SharpSequence x y) := by

  unfold ARCAutomaticByKernel

  exact
    arcA4_sharp_kernel_finite
      base
      hbase2
      x
      y


/-!
============================================================
3. Shortcut invariance, proved directly
============================================================
-/

theorem arcA4_shortcut_pos
    (n : ℕ)
    (hn : 0 < n) :
    0 < arcShortcutNat n := by

  unfold arcShortcutNat

  by_cases he :
      n % 2 = 0

  · rw [if_pos he]

    have hmoddiv :=
      Nat.mod_add_div n 2

    omega

  · rw [if_neg he]

    have hnumpos :
        0 < 3 * n + 1 := by
      omega

    have hmodlt :
        (3 * n + 1) % 2 < 2 :=
      Nat.mod_lt
        (3 * n + 1)
        (by norm_num)

    have hmoddiv :=
      Nat.mod_add_div
        (3 * n + 1)
        2

    omega


theorem arcA4_sharp_shortcut_invariant
    {α : Type u}
    (x y : α) :
    ∀ n : ℕ,
      ARCA4SharpSequence x y (arcShortcutNat n)
        =
      ARCA4SharpSequence x y n := by

  intro n

  by_cases hn :
      n = 0

  · subst n
    simp [ARCA4SharpSequence, arcShortcutNat]

  · have hnpos :
        0 < n :=
      Nat.pos_of_ne_zero hn

    have hTpos :
        0 < arcShortcutNat n :=
      arcA4_shortcut_pos
        n
        hnpos

    have hTne :
        arcShortcutNat n ≠ 0 :=
      Nat.ne_of_gt hTpos

    simp
      [ARCA4SharpSequence,
       hn,
       hTne]


/-!
============================================================
4. Genuine nonconstancy when x != y
============================================================
-/

theorem arcA4_sharp_zero_ne_one
    {α : Type u}
    (x y : α)
    (hxy : x ≠ y) :
    ARCA4SharpSequence x y 0
      ≠
    ARCA4SharpSequence x y 1 := by

  simpa [ARCA4SharpSequence] using hxy


/-!
============================================================
5. Strong non-vacuity / sharpness package
============================================================
-/

/--
For every base >= 2 and every pair x != y, there exists an explicit sequence
satisfying all hypotheses of Full General ARC while remaining nonconstant at
zero.

This simultaneously proves:
* the hypothesis class is nonempty;
* the theorem is not vacuous;
* zero cannot be added to the positive-domain rigidity conclusion.
-/
theorem arcA4_target
    {α : Type u}
    (base : ℕ)
    (hbase2 : 2 ≤ base)
    (x y : α)
    (hxy : x ≠ y) :
    ∃ a : ℕ → α,
      ARCAutomaticByKernel base a
        ∧
      (∀ n : ℕ,
        a (arcShortcutNat n) = a n)
        ∧
      a 0 ≠ a 1 := by

  refine
    ⟨ARCA4SharpSequence x y,
     arcA4_sharp_automatic
       base hbase2 x y,
     arcA4_sharp_shortcut_invariant
       x y,
     arcA4_sharp_zero_ne_one
       x y hxy⟩


/-!
============================================================
6. Concrete Boolean witness for every base >= 2
============================================================
-/

theorem arcA4_bool_witness
    (base : ℕ)
    (hbase2 : 2 ≤ base) :
    ∃ a : ℕ → Bool,
      ARCAutomaticByKernel base a
        ∧
      (∀ n : ℕ,
        a (arcShortcutNat n) = a n)
        ∧
      a 0 ≠ a 1 := by

  exact
    arcA4_target
      base
      hbase2
      false
      true
      (by decide)


/-!
============================================================
7. Axiom audit
============================================================
-/

#print axioms arcA4_sharp_kernel_finite
#print axioms arcA4_sharp_automatic
#print axioms arcA4_shortcut_pos
#print axioms arcA4_sharp_shortcut_invariant
#print axioms arcA4_sharp_zero_ne_one
#print axioms arcA4_target
#print axioms arcA4_bool_witness

end ARC