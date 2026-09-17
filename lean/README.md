# Lean 4 formalization

This directory contains the public Lean 4 release material for ARC2, ARC3, and ARC5.

## ARC2 source archive

- [ARC2/ARC2_Lean4_Source.zip](ARC2/ARC2_Lean4_Source.zip)

This is the earlier ARC2 Lean 4 archive that was originally published at the repository root as `ARC_Lean4_Source.zip`. It was reorganized without altering its binary content.

## ARC3 + ARC5 source archive

- [ARC3_ARC5_Lean4_Source.zip](ARC3_ARC5_Lean4_Source.zip)

The ARC3/ARC5 archive was prepared from the verified local project tree and cleaned to retain the ARC3/ARC5 dependency closure together with the project metadata needed for reconstruction.

It includes:

- `lean-toolchain`
- `lakefile.toml`
- `lake-manifest.json`
- `.gitignore`
- `SOURCE_FILE_LIST.txt`
- the required `ARC/` source tree

ARC3 depends on shared automaticity bridge files in addition to the ARC3-specific theorem files. ARC5 has a substantially longer dependency chain. For that reason, the ARC3/ARC5 public release is distributed as one combined reproducible source archive rather than reconstructed from isolated theorem files.

The `ARC2/`, `ARC3/`, and `ARC5/` subdirectories contain release notes. The ARC2 source ZIP is stored inside `ARC2/`; the reproducible ARC3/ARC5 source tree is in the combined ZIP above.

ARC3 uses Cobham's theorem as an explicit external principle. The main ARC5 proof route does not use Cobham's theorem.
