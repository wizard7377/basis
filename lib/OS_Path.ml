(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *)
open General

module type OS_PATH = sig
  exception Path
  exception InvalidArc

  val parentArc : string
  val currentArc : string

  type nonrec __0 = { isAbs : bool; vol : string }

  val validVolume : __0 -> bool

  type nonrec __1 = { isAbs : bool; vol : string; arcs : string list }

  val fromString : string -> __1

  type nonrec __2 = { isAbs : bool; vol : string; arcs : string list }

  val toString : __2 -> string
  val getVolume : string -> string
  val getParent : string -> string

  type nonrec __3 = { dir : string; file : string }

  val splitDirFile : string -> __3

  type nonrec __4 = { dir : string; file : string }

  val joinDirFile : __4 -> string
  val dir : string -> string
  val file : string -> string

  type nonrec __5 = { base : string; ext : string option }

  val splitBaseExt : string -> __5

  type nonrec __6 = { base : string; ext : string option }

  val joinBaseExt : __6 -> string
  val base : string -> string
  val ext : string -> string option
  val mkCanonical : string -> string
  val isCanonical : string -> bool

  type nonrec __7 = { path : string; relativeTo : string }

  val mkAbsolute : __7 -> string

  type nonrec __8 = { path : string; relativeTo : string }

  val mkRelative : __8 -> string
  val isAbsolute : string -> bool
  val isRelative : string -> bool
  val isRoot : string -> bool
  val concat : string * string -> string
  val fromUnixPath : string -> string
  val toUnixPath : string -> string
end
(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note: Merged into OS.sml for OCaml compatibility.
 *)
