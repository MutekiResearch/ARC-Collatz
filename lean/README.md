# Lean 4 formalization

This directory contains the public Lean 4 release material for ARC3 and ARC5.

## Source archive

- [ARC3_ARC5_Lean4_Source.zip](ARC3_ARC5_Lean4_Source.zip)

The archive was prepared from the verified local project tree and cleaned to retain the ARC3/ARC5 dependency closure together with the project metadata needed for reconstruction.

It includes:

- `lean-toolchain`
- `lakefile.toml`
- `lake-manifest.json`
- `.gitignore`
- `SOURCE_FILE_LIST.txt`
- the required `ARC/` source tree

ARC3 depends on shared automaticity bridge files in addition to the ARC3-specific theorem files. ARC5 has a substantially longer dependency chain. For that reason, the public release is distributed as one combined reproducible source archive rather than reconstructed from isolated theorem files.

The `ARC3/` and `ARC5/` subdirectories in this repository contain release notes only; the actual reproducible source tree is in the ZIP archive above.

ARC3 uses Cobham's theorem as an explicit external principle. The main ARC5 proof route does not use Cobham's theorem.
