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
(* 
 * (c) Andreas Rossberg 2002-2025
 *
 * Standard ML Basis Library
  *);;
module Byte = struct
                let rec byteToChar i = raise ((General.Fail "TODO"));;
                let rec charToByte c = raise ((General.Fail "TODO"));;
                let rec stringToBytes s = raise ((General.Fail "TODO"));;
                let rec bytesToString v = raise ((General.Fail "TODO"));;
                let rec unpackStringVec sl = raise ((General.Fail "TODO"));;
                let rec unpackString sl = raise ((General.Fail "TODO"));;
                let rec packString x = raise ((General.Fail "TODO"));;
                end;;