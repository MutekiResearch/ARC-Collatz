# Lean 4 formalization

This directory will contain the reproducible Lean 4 source tree for ARC3 and ARC5.

## Release rule

The Lean source should be copied from the exact local project state that was compiled successfully, including all imported ARC bridge files and project metadata required to rebuild the formalization. Individual theorem files are not sufficient if their imports are omitted.

Planned layout:

```text
lean/
├─ ARC3/
├─ ARC5/
└─ shared/
```

ARC3 depends on shared automaticity bridge files in addition to the ARC3-specific theorem files. ARC5 has a substantially longer dependency chain. For that reason, the release source will be taken from the verified local Lean project rather than reconstructed from isolated archived files.
