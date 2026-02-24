open! CharVector
open! ArraySlice

(*
 * (c) Andreas Rossberg 2002-2025
 *
 * Standard ML Basis Library
 *)
open General
open Exceptions
open MONO_ARRAY_SLICE_sig

module CharArraySlice = struct
  let length = ArraySlice.length
  let sub = ArraySlice.sub

  type nonrec elem = char
  type nonrec vector = string
  type nonrec array = elem array
  type nonrec slice = elem ArraySlice.slice
  type nonrec vector_slice = Substring.substring

  let rec vector sl =
    CharVector.tabulate (length sl, function i -> sub (sl, i))

  let rec copyVec x = raise (Fail "TODO")
end
