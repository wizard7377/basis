open! CharVector
open! Array

(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note:
 * - Array type kept transparent to allow trivial implementation
 *   of CharArraySlice.
 *)
open General
open Exceptions
open MONO_ARRAY_sig

module CharArray = struct
  let length = Array.length
  let sub = Array.sub

  type nonrec array = char array
  type nonrec elem = char
  type nonrec vector = string

  let rec vector arr =
    CharVector.tabulate (length arr, function i -> sub (arr, i))

  let rec copyVec x = raise (Fail "TODO")
end
