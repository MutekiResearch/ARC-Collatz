import Mathlib
import Mathlib.Data.Nat.ModEq
import Mathlib.Data.Fintype.Card
import ARC.ARCAutomaticBridge2
import ARC.ARCGeneralStage9_InfiniteSupportLongWord

set_option autoImplicit false

namespace ARC

/-!
# Full General ARC — Independent Audit A3

Independent reconstruction of the odd-base topological-pumping implication

  odd base >= 3
  + finite base-k kernel
  + dyadically nowhere-thick Boolean support
    ->
  finite support.

Audit discipline:
* DO NOT call the packaged Stage-6 residue-permutation theorem.
* DO NOT call the packaged Stage-7 child-filling theorem.
* DO NOT call the packaged Stage-8 nowhere-thick collision theorem.
* DO NOT call the packaged Stage-9 topological-pumping theorem.
* DO NOT call the packaged Stage-10 kernel theorem.
* DO NOT use Cobham.

We reuse only lower-level infrastructure:
* finite-kernel -> MSD-DFAO conversion;
* generic "infinite support gives a long canonical word";
* Stage-5 exact doubled-loop pumping arithmetic.

The dyadic residue permutation, child filling, collision, and the final
finite-support implication are reconstructed below.
-/

/-!
============================================================
1. Independent dyadic residue permutation
============================================================
-/

def ARCA3OddPumpResidueMap
    (base v L M : ℕ) :
    Fin (2 ^ M) → Fin (2 ^ M) :=
  fun k =>
    ⟨
      ARCGeneralEvenLoopPumpedFamily
          base 0 (2 * v + 1) L k.val
        % (2 ^ M),
      Nat.mod_lt _ (Nat.two_pow_pos M)
    ⟩

theorem arcA3_oddPumpResidues_ne_of_lt
    (base v L M : ℕ)
    (hbaseOdd : base % 2 = 1)
    {i j : Fin (2 ^ M)}
    (hij : i.val < j.val) :
    ARCA3OddPumpResidueMap base v L M i
      ≠
    ARCA3OddPumpResidueMap base v L M j := by

  have hdiffPos : 0 < j.val - i.val := by
    omega

  rcases
    arcGeneral_exists_twoPow_mul_odd
      (j.val - i.val)
      hdiffPos with
    ⟨t, u, hdiffFactor⟩

  have hj :
      j.val = i.val + 2 ^ t * (2 * u + 1) := by
    have hbase :
        j.val = i.val + (j.val - i.val) := by
      omega
    rw [hdiffFactor] at hbase
    exact hbase

  have hdiffLt :
      j.val - i.val < 2 ^ M := by
    omega

  have htwoLe :
      2 ^ t ≤ j.val - i.val := by
    rw [hdiffFactor]
    calc
      2 ^ t = 2 ^ t * 1 := by simp
      _ ≤ 2 ^ t * (2 * u + 1) := by
        exact
          Nat.mul_le_mul_left
            (2 ^ t)
            (by omega)

  have htwoLt :
      2 ^ t < 2 ^ M := by
    omega

  have htM :
      t < M := by
    exact
      (Nat.pow_lt_pow_iff_right
        (by norm_num : 1 < (2 : ℕ))).mp
        htwoLt

  have hfactorOdd :
      (2 * v + 1)
        =
      2 ^ 0 * (2 * v + 1) := by
    simp

  rcases
    arcGeneral_evenLoop_pumpedFamily_exact_two_factor
      base
      0
      (2 * v + 1)
      L
      i.val
      0
      v
      t
      u
      hbaseOdd
      hfactorOdd with
    ⟨w, hdisp⟩

  have hdisp' :
      ARCGeneralEvenLoopPumpedFamily
          base 0 (2 * v + 1) L j.val
        =
      ARCGeneralEvenLoopPumpedFamily
          base 0 (2 * v + 1) L i.val
        +
      2 ^ t * (2 * w + 1) := by
    simpa [hj] using hdisp

  intro hEq

  have hrem :
      ARCGeneralEvenLoopPumpedFamily
          base 0 (2 * v + 1) L i.val % (2 ^ M)
        =
      ARCGeneralEvenLoopPumpedFamily
          base 0 (2 * v + 1) L j.val % (2 ^ M) := by
    have hval :=
      congrArg Fin.val hEq
    simpa [ARCA3OddPumpResidueMap] using hval

  have hmod :
      ARCGeneralEvenLoopPumpedFamily
          base 0 (2 * v + 1) L i.val
        ≡
      ARCGeneralEvenLoopPumpedFamily
          base 0 (2 * v + 1) L j.val
        [MOD 2 ^ M] := by
    exact hrem

  have hdvd :
      2 ^ M ∣ 2 ^ t * (2 * w + 1) := by
    have hdvdRaw := hmod.dvd'
    rw [hdisp'] at hdvdRaw
    simpa using hdvdRaw

  have hMsplit :
      M = t + (M - t) := by
    omega

  have hdvdFactored :
      2 ^ t * 2 ^ (M - t)
        ∣
      2 ^ t * (2 * w + 1) := by
    rw [hMsplit] at hdvd
    simpa [pow_add] using hdvd

  have htailDvd :
      2 ^ (M - t) ∣ 2 * w + 1 := by
    exact
      Nat.dvd_of_mul_dvd_mul_left
        (Nat.two_pow_pos t)
        hdvdFactored

  have honeLe :
      1 ≤ M - t := by
    omega

  have htwoDvdTailPow :
      2 ∣ 2 ^ (M - t) := by
    have hpowDvd :
        2 ^ 1 ∣ 2 ^ (M - t) :=
      Nat.pow_dvd_pow 2 honeLe
    simpa using hpowDvd

  have htwoDvdOdd :
      2 ∣ 2 * w + 1 :=
    Nat.dvd_trans
      htwoDvdTailPow
      htailDvd

  exact
    (Nat.not_two_dvd_bit1 w)
      htwoDvdOdd


theorem arcA3_oddPumpResidueMap_injective
    (base v L M : ℕ)
    (hbaseOdd : base % 2 = 1) :
    Function.Injective
      (ARCA3OddPumpResidueMap base v L M) := by

  intro i j hijMap
  apply Fin.ext
  by_contra hne
  rcases lt_or_gt_of_ne hne with hij | hji
  · exact
      (arcA3_oddPumpResidues_ne_of_lt
        base v L M hbaseOdd hij)
        hijMap
  · exact
      (arcA3_oddPumpResidues_ne_of_lt
        base v L M hbaseOdd hji)
        hijMap.symm


theorem arcA3_oddPumpResidueMap_surjective
    (base v L M : ℕ)
    (hbaseOdd : base % 2 = 1) :
    Function.Surjective
      (ARCA3OddPumpResidueMap base v L M) := by

  have hinj :
      Function.Injective
        (ARCA3OddPumpResidueMap base v L M) :=
    arcA3_oddPumpResidueMap_injective
      base v L M hbaseOdd

  have hbij :
      Function.Bijective
        (ARCA3OddPumpResidueMap base v L M) :=
    Function.Injective.bijective_of_finite
      hinj

  exact hbij.2


theorem arcA3_oddPumpResidueMap_hits_every_residue
    (base v L M : ℕ)
    (hbaseOdd : base % 2 = 1)
    (r : Fin (2 ^ M)) :
    ∃ k : Fin (2 ^ M),
      ARCGeneralEvenLoopPumpedFamily
          base 0 (2 * v + 1) L k.val
        % (2 ^ M)
      =
      r.val := by

  rcases
    arcA3_oddPumpResidueMap_surjective
      base v L M hbaseOdd r with
    ⟨k, hk⟩

  refine ⟨k, ?_⟩

  have hval :=
    congrArg Fin.val hk

  simpa [ARCA3OddPumpResidueMap] using hval


/-!
============================================================
2. Independent dyadic child filling
============================================================
-/

def ARCA3DyadicChildRepresentative
    (N0 s R : ℕ)
    (r : Fin (2 ^ R)) :
    ℕ :=
  N0 + 2 ^ s * r.val


theorem arcA3_evenLoopPumpedFamily_scaled_odd
    (base N0 s v L k : ℕ) :
    ARCGeneralEvenLoopPumpedFamily
        base
        N0
        (2 ^ s * (2 * v + 1))
        L
        k
      =
    N0
      +
    2 ^ s *
      ARCGeneralEvenLoopPumpedFamily
        base
        0
        (2 * v + 1)
        L
        k := by

  unfold ARCGeneralEvenLoopPumpedFamily
  ring


theorem arcA3_dyadicChildRepresentative_in_parent
    (N0 s R : ℕ)
    (r : Fin (2 ^ R)) :
    ARCA3DyadicChildRepresentative N0 s R r
      ≡
    N0
      [MOD 2 ^ s] := by

  unfold ARCA3DyadicChildRepresentative

  have h :
      2 ^ s * r.val + N0
        ≡
      N0
        [MOD 2 ^ s] :=
    Nat.ModEq.modulus_mul_add

  simpa [Nat.add_comm] using h


theorem arcA3_lift_oddPump_residue_hit
    (base N0 s v L R k : ℕ)
    (r : Fin (2 ^ R))
    (hres :
      ARCGeneralEvenLoopPumpedFamily
          base 0 (2 * v + 1) L k
        % (2 ^ R)
      =
      r.val) :
    ARCGeneralEvenLoopPumpedFamily
        base
        N0
        (2 ^ s * (2 * v + 1))
        L
        k
      ≡
    ARCA3DyadicChildRepresentative
        N0 s R r
      [MOD 2 ^ (s + R)] := by

  have hnorm :
      ARCGeneralEvenLoopPumpedFamily
          base 0 (2 * v + 1) L k
        ≡
      r.val
        [MOD 2 ^ R] := by
    change
      ARCGeneralEvenLoopPumpedFamily
          base 0 (2 * v + 1) L k
        % (2 ^ R)
      =
      r.val % (2 ^ R)
    simpa [Nat.mod_eq_of_lt r.isLt] using hres

  have hscaledRaw :
      2 ^ s *
          ARCGeneralEvenLoopPumpedFamily
            base 0 (2 * v + 1) L k
        ≡
      2 ^ s * r.val
        [MOD (2 ^ s) * (2 ^ R)] :=
    Nat.ModEq.mul_left'
      (2 ^ s)
      hnorm

  have hscaled :
      2 ^ s *
          ARCGeneralEvenLoopPumpedFamily
            base 0 (2 * v + 1) L k
        ≡
      2 ^ s * r.val
        [MOD 2 ^ (s + R)] := by
    simpa [pow_add] using hscaledRaw

  have hoffset :
      N0
        +
      2 ^ s *
        ARCGeneralEvenLoopPumpedFamily
          base 0 (2 * v + 1) L k
        ≡
      N0 + 2 ^ s * r.val
        [MOD 2 ^ (s + R)] :=
    Nat.ModEq.add_left
      N0
      hscaled

  rw [arcA3_evenLoopPumpedFamily_scaled_odd]

  unfold ARCA3DyadicChildRepresentative

  exact hoffset


theorem arcA3_scaledOddPump_hits_every_child
    (base N0 s v L R : ℕ)
    (hbaseOdd : base % 2 = 1)
    (r : Fin (2 ^ R)) :
    ∃ k : Fin (2 ^ R),
      ARCGeneralEvenLoopPumpedFamily
          base
          N0
          (2 ^ s * (2 * v + 1))
          L
          k.val
        ≡
      ARCA3DyadicChildRepresentative
          N0 s R r
        [MOD 2 ^ (s + R)] := by

  rcases
    arcA3_oddPumpResidueMap_hits_every_residue
      base v L R hbaseOdd r with
    ⟨k, hk⟩

  refine ⟨k, ?_⟩

  exact
    arcA3_lift_oddPump_residue_hit
      base
      N0
      s
      v
      L
      R
      k.val
      r
      hk


theorem arcA3_evenLoopPumpedFamily_hits_every_child_of_exact_two_factor
    (base N0 d L s v R : ℕ)
    (hbaseOdd : base % 2 = 1)
    (hd :
      d = 2 ^ s * (2 * v + 1))
    (r : Fin (2 ^ R)) :
    ∃ k : Fin (2 ^ R),
      ARCGeneralEvenLoopPumpedFamily
          base N0 d L k.val
        ≡
      ARCA3DyadicChildRepresentative
          N0 s R r
        [MOD 2 ^ (s + R)] := by

  rw [hd]

  exact
    arcA3_scaledOddPump_hits_every_child
      base N0 s v L R hbaseOdd r


/-!
============================================================
3. Independent collision with dyadic nowhere-thickness
============================================================
-/

theorem arcA3_parent_point_has_canonical_child
    (N0 s R n : ℕ)
    (hnParent :
      n ≡ N0 [MOD 2 ^ s]) :
    ∃ r : Fin (2 ^ R),
      n
        ≡
      ARCA3DyadicChildRepresentative
          N0 s R r
        [MOD 2 ^ (s + R)] := by

  let D : ℕ :=
    2 ^ (s + R)

  let A : ℕ :=
    n + D * N0

  have hDpos :
      0 < D := by
    simp [D]

  have hDone :
      1 ≤ D := by
    omega

  have hN0mul :
      N0 ≤ D * N0 := by
    have h :=
      Nat.mul_le_mul_right
        N0
        hDone
    simpa using h

  have hN0A :
      N0 ≤ A := by
    dsimp [A]
    omega

  have hzero :
      D * N0
        ≡
      0
        [MOD 2 ^ s] := by

    have hz :
        (2 ^ s) * ((2 ^ R) * N0) + 0
          ≡
        0
          [MOD 2 ^ s] :=
      Nat.ModEq.modulus_mul_add

    simpa [D, pow_add, Nat.mul_assoc] using hz

  have hAParent :
      A
        ≡
      N0
        [MOD 2 ^ s] := by

    have hadd :=
      hnParent.add hzero

    simpa [A] using hadd

  have hN0Amod :
      N0
        ≡
      A
        [MOD 2 ^ s] :=
    hAParent.symm

  rcases
    (Nat.modEq_iff_exists_eq_add hN0A).mp
      hN0Amod with
    ⟨q, hAq⟩

  let r : Fin (2 ^ R) :=
    ⟨
      q % (2 ^ R),
      Nat.mod_lt
        q
        (Nat.two_pow_pos R)
    ⟩

  refine
    ⟨r, ?_⟩

  have hq :
      q
        ≡
      q % (2 ^ R)
        [MOD 2 ^ R] :=
    (Nat.mod_modEq q (2 ^ R)).symm

  have hscaledRaw :
      (2 ^ s) * q
        ≡
      (2 ^ s) * (q % (2 ^ R))
        [MOD (2 ^ s) * (2 ^ R)] :=
    Nat.ModEq.mul_left'
      (2 ^ s)
      hq

  have hscaled :
      (2 ^ s) * q
        ≡
      (2 ^ s) * (q % (2 ^ R))
        [MOD D] := by
    simpa [D, pow_add] using hscaledRaw

  have hchildRaw :
      N0 + (2 ^ s) * q
        ≡
      N0 + (2 ^ s) * (q % (2 ^ R))
        [MOD D] :=
    Nat.ModEq.add_left
      N0
      hscaled

  have hAchild :
      A
        ≡
      ARCA3DyadicChildRepresentative
          N0 s R r
        [MOD D] := by

    rw [hAq]

    simpa
      [ARCA3DyadicChildRepresentative, r]
      using hchildRaw

  have hAn :
      A
        ≡
      n
        [MOD D] := by

    have hbase :
        D * N0 + n
          ≡
        n
          [MOD D] :=
      Nat.ModEq.modulus_mul_add

    simpa [A, Nat.add_comm] using hbase

  have hnA :
      n
        ≡
      A
        [MOD D] :=
    hAn.symm

  exact
    hnA.trans
      hAchild


theorem arcA3_deep_dyadic_congruence_descends
    (s M : ℕ)
    {a b : ℕ}
    (h :
      a ≡ b [MOD 2 ^ (s + M)]) :
    a ≡ b [MOD 2 ^ M] := by

  have hdvd :
      2 ^ M ∣ 2 ^ (s + M) := by

    refine
      ⟨2 ^ s, ?_⟩

    rw [pow_add]
    ring

  exact
    Nat.ModEq.of_dvd
      hdvd
      h


theorem arcA3_child_filling_not_nowhereThick
    (base : ℕ)
    (hbaseOdd : base % 2 = 1)
    (S : Set ℕ)
    (N0 d L s v : ℕ)
    (hd :
      d = 2 ^ s * (2 * v + 1))
    (hpump :
      ∀ k : ℕ,
        ARCGeneralEvenLoopPumpedFamily
            base
            N0
            d
            L
            k
          ∈
        S) :
    ¬ ARCGeneralDyadicallyNowhereThick S := by

  intro hthin

  rcases
    hthin
      s
      N0 with
    ⟨M,
     t,
     hinside,
     hpositive,
     hempty⟩

  rcases
    hpositive with
    ⟨n,
     hnpos,
     hnt⟩

  have hnParent :
      n ≡ N0 [MOD 2 ^ s] :=
    hinside
      n
      hnt

  rcases
    arcA3_parent_point_has_canonical_child
      N0
      s
      M
      n
      hnParent with
    ⟨r, hnChild⟩

  rcases
    arcA3_evenLoopPumpedFamily_hits_every_child_of_exact_two_factor
      base
      N0
      d
      L
      s
      v
      M
      hbaseOdd
      hd
      r with
    ⟨k, hkChild⟩

  have hPumpNDeep :
      ARCGeneralEvenLoopPumpedFamily
          base
          N0
          d
          L
          k.val
        ≡
      n
        [MOD 2 ^ (s + M)] :=
    hkChild.trans
      hnChild.symm

  have hPumpN :
      ARCGeneralEvenLoopPumpedFamily
          base
          N0
          d
          L
          k.val
        ≡
      n
        [MOD 2 ^ M] :=
    arcA3_deep_dyadic_congruence_descends
      s
      M
      hPumpNDeep

  have hPumpT :
      ARCGeneralEvenLoopPumpedFamily
          base
          N0
          d
          L
          k.val
        ≡
      t
        [MOD 2 ^ M] :=
    hPumpN.trans
      hnt

  have hnotmem :
      ARCGeneralEvenLoopPumpedFamily
          base
          N0
          d
          L
          k.val
        ∉
      S :=
    hempty
      (ARCGeneralEvenLoopPumpedFamily
        base
        N0
        d
        L
        k.val)
      hPumpT

  exact
    hnotmem
      (hpump k.val)


/-!
============================================================
4. Independent A3 topological pumping
============================================================
-/

theorem arcA3_long_canonical_support_word_not_nowhereThick
    (base : ℕ)
    (hbase3 : 3 ≤ base)
    (hbaseOdd : base % 2 = 1)
    (M : ARCMSDDFAO base Bool)
    [Fintype M.State]
    (sseq : ℕ → Bool)
    (hM :
      ARCMSDDFAO.Generates M sseq)
    (x : List (Fin base))
    (hxCanonical :
      ARCGeneralCanonicalPositiveMSDWord base x)
    (hx :
      ARCGeneralMSDValue base x
        ∈
      ARCGeneralBoolSupport sseq)
    (hlen :
      Fintype.card M.State
        ≤
      x.length) :
    ¬
      ARCGeneralDyadicallyNowhereThick
        (ARCGeneralBoolSupport sseq) := by

  rcases
    arcGeneral_stage5_exact_dyadic_pumping_handoff
      base
      hbase3
      hbaseOdd
      M
      sseq
      hM
      x
      hxCanonical
      hx
      hlen with
    ⟨a,
     w,
     c,
     s,
     v,
     hsplit,
     hshort,
     hwne,
     hwlen,
     hdoubleNe,
     hdoubleLen,
     hdoublePos,
     hinc,
     hfactor,
     hpump,
     hvalue,
     hdyadic⟩

  exact
    arcA3_child_filling_not_nowhereThick
      base
      hbaseOdd
      (ARCGeneralBoolSupport sseq)
      (ARCGeneralMSDValue base (a ++ c))
      (ARCGeneralDoubleWordPumpIncrement base a w c)
      w.length
      s
      v
      hfactor
      hpump


theorem arcA3_infinite_msd_support_not_nowhereThick
    (base : ℕ)
    (hbase3 : 3 ≤ base)
    (hbaseOdd : base % 2 = 1)
    (M : ARCMSDDFAO base Bool)
    [Fintype M.State]
    (sseq : ℕ → Bool)
    (hM :
      ARCMSDDFAO.Generates M sseq)
    (hinf :
      (ARCGeneralBoolSupport sseq).Infinite) :
    ¬
      ARCGeneralDyadicallyNowhereThick
        (ARCGeneralBoolSupport sseq) := by

  have hbase2 :
      2 ≤ base := by
    omega

  rcases
    arcGeneral_infinite_support_has_long_canonical_word
      base
      hbase2
      sseq
      (Fintype.card M.State)
      hinf with
    ⟨x,
     hxCanonical,
     hxSupport,
     hxLength⟩

  exact
    arcA3_long_canonical_support_word_not_nowhereThick
      base
      hbase3
      hbaseOdd
      M
      sseq
      hM
      x
      hxCanonical
      hxSupport
      hxLength


theorem arcA3_msd_nowhereThick_support_finite
    (base : ℕ)
    (hbase3 : 3 ≤ base)
    (hbaseOdd : base % 2 = 1)
    (M : ARCMSDDFAO base Bool)
    [Fintype M.State]
    (sseq : ℕ → Bool)
    (hM :
      ARCMSDDFAO.Generates M sseq)
    (hthin :
      ARCGeneralDyadicallyNowhereThick
        (ARCGeneralBoolSupport sseq)) :
    (ARCGeneralBoolSupport sseq).Finite := by

  by_contra hfinite

  have hinf :
      (ARCGeneralBoolSupport sseq).Infinite :=
    (Set.not_finite).mp
      hfinite

  have hnotThin :
      ¬
      ARCGeneralDyadicallyNowhereThick
        (ARCGeneralBoolSupport sseq) :=
    arcA3_infinite_msd_support_not_nowhereThick
      base
      hbase3
      hbaseOdd
      M
      sseq
      hM
      hinf

  exact
    hnotThin
      hthin


theorem arcA3_kernelAutomatic_nowhereThick_support_finite
    (base : ℕ)
    (hbase3 : 3 ≤ base)
    (hbaseOdd : base % 2 = 1)
    (sseq : ℕ → Bool)
    (hAuto :
      ARCAutomaticByKernel base sseq)
    (hthin :
      ARCGeneralDyadicallyNowhereThick
        (ARCGeneralBoolSupport sseq)) :
    (ARCGeneralBoolSupport sseq).Finite := by

  have hKernel :
      (ARCKernel base sseq).Finite := by
    simpa [ARCAutomaticByKernel] using hAuto

  have hMSD :
      ARCMSDAutomatic base sseq :=
    arc_finite_kernel_implies_msd_automatic
      base
      sseq
      hKernel

  rcases hMSD with
    ⟨M, hM⟩

  letI : Finite M.State :=
    M.stateFinite

  letI : Fintype M.State :=
    Fintype.ofFinite M.State

  exact
    arcA3_msd_nowhereThick_support_finite
      base
      hbase3
      hbaseOdd
      M
      sseq
      hM
      hthin


/-- Public A3 audit target. -/
theorem arcA3_target :
    ∀ base : ℕ,
      3 ≤ base
        →
      base % 2 = 1
        →
      ∀ sseq : ℕ → Bool,
        ARCAutomaticByKernel base sseq
          →
        ARCGeneralDyadicallyNowhereThick
          (ARCGeneralBoolSupport sseq)
          →
        (ARCGeneralBoolSupport sseq).Finite := by

  intro base hbase3 hbaseOdd sseq hAuto hthin

  exact
    arcA3_kernelAutomatic_nowhereThick_support_finite
      base
      hbase3
      hbaseOdd
      sseq
      hAuto
      hthin