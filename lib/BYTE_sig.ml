(* 
 * (c) Andreas Rossberg 2002-2025
 *
 * Standard ML Basis Library
  *);;
open General;;
module type BYTE = sig
                   val byteToChar : int -> char
                   val charToByte : char -> int
                   val bytesToString : int array -> string
                   val stringToBytes : string -> int array
                   val unpackStringVec : int array -> string
                   val unpackString : int array -> string
                   val packString : (int array * int * string) -> unit
                   end;;