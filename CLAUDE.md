# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an OCaml library implementing the **Standard ML (SML) Basis Library** — the standard library of the SML programming language — translated into OCaml. Authored by Andreas Rossberg (2001–2025). The `.ml` files are generated output from an SML-to-OCaml translator, not hand-written OCaml.

The library expects to run in the context of an SML runtime where primitive operations (referenced via `use { b = "Module.func" }`) are provided by the host system.

## Build Commands

```sh
dune build        # Build the library
dune test         # Run tests (test suite is currently a placeholder)
dune clean        # Clean build artifacts
```

No external OCaml library dependencies beyond `ocaml` and `dune` (>= 3.20).

## Architecture

### Source Layout

- `lib/` — All library source (~80 modules), published as the `basis` Dune library
- `lib/basis.ml` — Main entry point; chains all module loads in dependency order
- `test/test_basis.ml` — Test executable (currently empty)

### Module Organization

Every module follows a **signature-first** pattern:
1. `*_sig.ml` defines a `module type` (e.g., `LIST_sig.ml` → `module type LIST`)
2. The corresponding `.ml` file implements that signature (e.g., `List.ml` → `module List : LIST`)

OS substructures use nested modules that progressively extend `OS`:
```
OS_Path.ml    → module OS = struct module Path : OS_PATH = ... end
OS_FileSys.ml → module OS = struct open OS;; module FileSys : OS_FILE_SYS = ... end
OS_Process.ml → module OS = struct open OS;; module Process : OS_PROCESS = ... end
```

### SML-to-OCaml Translation Conventions

These conventions are systematic across all files — preserve them when editing:

- **SML comments** are preserved as `[@@@sml.comment {|...|}]` attributes
- **Primitives** use `use { b = "Module.func" }` (non-nilary) or `use { b = "Module.val" } ()` (nilary)
- **Name mangling**: `'` → `_prime` (e.g., `rev'` → `rev_prime`), keywords get trailing underscore (`mod_`, `true_`, `false_`)
- **`nil`** used for empty list pattern, not `[]`
- **Tuple arguments** instead of curried style: `let min (i, j) = ...`
- **`begin...end` blocks** wrap if-then-else and sequenced expressions
- **Double semicolons** (`;;`) terminate every top-level declaration
- **`type nonrec`** used for re-declaring built-in types without recursive binding
- **SML order type**: `LESS`, `EQUAL`, `GREATER` (uppercase constructors)
- **Arrays** are implemented as `('a ref) vector ref` (refs-of-vectors for mutability)
- **Incomplete modules** are marked with `Note: Incomplete.` in their SML comment header
