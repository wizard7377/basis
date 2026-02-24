# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

OCaml implementation of the Standard ML (SML) Basis Library, translated from SML to OCaml. The `.ml` files are **generated/translated output**, not hand-written OCaml. Original SML sources live in `docs/basis/hamlet/`.

## Build Commands

```sh
dune build        # Build the library
dune test         # Run tests (test suite is currently a placeholder)
dune clean        # Clean build artifacts
```

Requires OCaml >= 4.14 and Dune >= 3.20. Dependencies: `ppx_deriving`, `bos`, `ptime`.

## Architecture

### Entry Point & Module Loading

`lib/Basis.ml` is the main entry point. It opens all modules in **strict dependency order** — this ordering is critical and cannot be rearranged. New modules must be inserted at the correct position in this chain.

### Module Pattern

Every module follows signature-first: `FOO_sig.ml` defines `module type FOO`, then `Foo.ml` implements `module Foo : FOO`. Both files must be added to the `modules` list in `lib/dune`.

### Infrastructure Files (loaded first)

- `infix.ml` — infix operator declarations
- `types.ml` — top-level type definitions (`unit`, `int`, `option`, `order`, `list`, `ref`, etc.)
- `exceptions.ml` — standard SML exceptions (`Bind`, `Chr`, `Div`, `Domain`, `Empty`, `Fail`, etc.)
- `values.ml` — re-exports top-level SML bindings (`hd`, `tl`, `map`, `print`, `vector`, etc.) from their implementing modules

### OS Module Extension Pattern

OS substructures progressively extend a single `OS` module across multiple files. Each of `OS_Path.ml`, `OS_FileSys.ml`, `OS_Process.ml` reopens `OS` with `include OS` and adds a submodule.

### Unimplemented Modules

Commented out in `Basis.ml`: Date, Time, Timer, BinPrimIO, TextPrimIO, BinIO, OS.IO.

## SML-to-OCaml Translation Conventions

These conventions are systematic across all files. **Preserve them when editing:**

| Convention | Detail |
|---|---|
| Primitives (non-nilary) | `use { b = "Module.func" }` |
| Primitives (nilary) | `use { b = "Module.val" } ()` |
| Name `'` | `_prime` suffix (e.g., `rev'` → `rev_prime`) |
| OCaml keywords | trailing `_` (e.g., `mod_`, `true_`, `false_`) |
| Empty list pattern | `nil`, not `[]` |
| Arguments | tupled, not curried: `let min (i, j) = ...` |
| Control flow | `begin...end` blocks wrap if-then-else |
| Declarations | every top-level declaration ends with `;;` |
| Built-in types | `type nonrec` for re-declaring |
| Order constructors | `LESS`, `EQUAL`, `GREATER` (uppercase) |
| Mutable arrays | `('a ref) vector ref` |
| Incomplete modules | `Note: Incomplete.` in SML comment header |

All warnings are suppressed (`-warn-error -A`) due to patterns from auto-generated code.
