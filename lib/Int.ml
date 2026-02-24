module Sig_INTEGER = struct
  (*
   * (c) Andreas Rossberg 2001-2025
   *
   * Standard ML Basis Library
   *)
  open General

  module Int = struct
    type nonrec int = int
  end

  open General
  module LargeInt = Int
  open General
  open StringCvt

  module type INTEGER = sig
    type nonrec int

    val toLarge : int -> LargeInt.int
    val fromLarge : LargeInt.int -> int
    val toInt : int -> Int.int
    val fromInt : Int.int -> int
    val precision : Int.int option
    val minInt : int option
    val maxInt : int option
    val ( + ) : int -> int -> int
    val ( - ) : int -> int -> int
    val ( * ) : int -> int -> int
    val div : int * int -> int
    val mod_ : int * int -> int
    val quot : int * int -> int
    val rem : int * int -> int
    val compare : int * int -> order
    val ( > ) : int -> int -> bool
    val ( >= ) : int -> int -> bool
    val ( < ) : int -> int -> bool
    val ( <= ) : int -> int -> bool
    val ( ~- ) : int -> int
    val abs : int -> int
    val min : int * int -> int
    val max : int * int -> int
    val sign : int -> Int.int
    val sameSign : int * int -> bool
    val fmt : StringCvt.radix -> int -> string
    val toString : int -> string

    val scan :
      StringCvt.radix ->
      (char, 'a) StringCvt.reader ->
      (int, 'a) StringCvt.reader

    val fromString : string -> int option
  end
end

module type INTEGER = Sig_INTEGER.INTEGER

(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *)
open General
open Exceptions

module Int = struct
  type nonrec int = int

  let precision : int option = None
  let minInt : int option = None
  let maxInt : int option = None
  let rec toLarge i = i
  let rec fromLarge i = i
  let rec toInt i = i
  let rec fromInt i = i

  let rec abs i =
    begin if i < 0 then -i else i
    end

  let ( ~- ) = ( ~- )
  let ( + ) x__op y__op = x__op + y__op
  let ( - ) x__op y__op = x__op - y__op
  let ( * ) x__op y__op = x__op * y__op
  let rec div (a, b) = raise (General.Fail "TODO")
  let rec mod_ (a, b) = raise (General.Fail "TODO")
  let rec quot (a, b) = raise (General.Fail "TODO")
  let rec rem (a, b) = raise (General.Fail "TODO")

  let rec min (i, j) =
    begin if i < j then i else j
    end

  let rec max (i, j) =
    begin if i > j then i else j
    end

  let rec sign = function 0 -> 0 | i -> begin if i > 0 then 1 else -1 end
  let rec sameSign (i, j) = sign i = sign j
  let rec fmt radix i = raise (General.Fail "TODO")
  let rec toString i = raise (General.Fail "TODO")
  let rec scan radix getc src = raise (General.Fail "TODO")
  let rec fromString s = raise (General.Fail "TODO")
  let ( > ) x__op y__op = x__op > y__op
  let ( >= ) x__op y__op = x__op >= y__op
  let ( < ) x__op y__op = x__op < y__op
  let ( <= ) x__op y__op = x__op <= y__op

  let rec compare (i, j) =
    begin if i < j then Less
    else begin
      if i = j then Equal else Greater
    end
    end
end
