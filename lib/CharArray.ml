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

  let rec copyVec x =
    let src = Obj.magic x.src
    and dst = (Obj.magic x.dst : array)
    and di = x.di in
    begin if di < 0 || length dst < di + CharVector.length src then
      raise Subscript
    else copyVec_prime (src, dst, di, 0)
    end

  and copyVec_prime (src, dst, di, i) =
    begin if i = CharVector.length src then ()
    else begin
      Array.update (dst, di + i, CharVector.sub (src, i));
      copyVec_prime (src, dst, di, i + 1)
    end
    end
end
