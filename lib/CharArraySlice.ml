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

  let rec copyVec x =
    let src : vector_slice = Obj.magic (Obj.field (Obj.repr x) 0) in
    let dst : array = Obj.magic (Obj.field (Obj.repr x) 1) in
    let di : int = Obj.magic (Obj.field (Obj.repr x) 2) in
    let src_len = Substring.Substring.size src in
    begin if di < 0 || Stdlib.Array.length dst < di + src_len then
      raise Subscript
    else copyVec_prime (src, dst, di, 0, src_len)
    end

  and copyVec_prime (src, dst, di, i, len) =
    begin if i = len then ()
    else begin
      Stdlib.Array.set dst (di + i) (Substring.Substring.sub (src, i));
      copyVec_prime (src, dst, di, i + 1, len)
    end
    end
end
