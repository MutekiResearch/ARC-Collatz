# Independent A1-A4 Lean audit modules

**Audit revision:** 2026-09-24

These files are supplementary reconstruction modules for the Independent Audit
Note on the Cobham-free Full General ARC theorem.

| File | Main audited target | Recorded targeted build |
| --- | --- | ---: |
| `ARCA1IndependentAudit_v2.lean` | base-2 kernel -> base-3 odd-subsequence kernel transfer | 8767 jobs |
| `ARCA2IndependentAudit.lean` | affine pullback `x = 2n+1` and dyadic thinness of the odd change set | 8859 jobs |
| `ARCA3IndependentAudit.lean` | odd-base residue permutation -> child filling -> finite support | 8819 jobs |
| `ARCA4IndependentAudit_v2.lean` | all-base finite-kernel invariant witness and sharpness at zero | 8845 jobs |

All four standalone checks reported no `sorryAx` at the audited endpoints.
The principal endpoint dependencies were the standard Lean/Mathlib principles
`propext`, `Classical.choice`, and `Quot.sound` (or a subset for some
elementary endpoints).

### Scope of "independent"

- A1 avoids the earlier packaged ARC2 transfer theorem.
- A2 reuses the already established lower local-density theorem, but rebuilds
  the A2-specific affine pullback and nowhere-thickness conclusion.
- A3 directly avoids the packaged Stage 6-10 conclusions under audit, while
  reusing lower automaticity / Stage-5 infrastructure. It is therefore a
  direct-non-use reconstruction, not complete transitive import-graph isolation.
- A4 constructs the witness directly and does not invoke a prior sharpness
  theorem or the Full General rigidity endpoint.

These modules are intended to be placed in the project's `ARC/` source
directory when reproducing the recorded commands.
