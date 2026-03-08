(*
 * (c) Andreas Rossberg 2002-2025
 *
 * Standard ML Basis Library
 *)
open General

module type BYTE = sig
  val byteToChar : int -> char
  val charToByte : char -> int
  val bytesToString : int array -> string
  val stringToBytes : string -> int array
  val unpackStringVec : int array -> string
  val unpackString : int array -> string
  val packString : int array * int * string -> unit
end

(*
 * (c) Andreas Rossberg 2002-2025
 *
 * Standard ML Basis Library
 *)
module Byte = struct
  let rec byteToChar i = Stdlib.Char.chr i
  let rec charToByte c = Stdlib.Char.code c

  let rec stringToBytes s =
    Stdlib.Array.init (Stdlib.String.length s) (fun i ->
        Stdlib.Char.code (Stdlib.String.get s i))

  let rec bytesToString v =
    Stdlib.String.init (Stdlib.Array.length v) (fun i ->
        Stdlib.Char.chr (Stdlib.Array.get v i))

  let rec unpackStringVec sl = bytesToString sl
  let rec unpackString sl = bytesToString sl

  let rec packString (arr, i, ss) =
    let s = ss in
    let len = Stdlib.String.length s in
    for j = 0 to len - 1 do
      Stdlib.Array.set arr (i + j) (Stdlib.Char.code (Stdlib.String.get s j))
    done
end
