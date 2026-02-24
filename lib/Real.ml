module Sig_REAL = struct
(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note: Incomplete.
  *);;
open General;;
open StringCvt;;
open IEEEReal;;
open IEEEReal;;
open Int;;
module LargeReal = struct
                     type nonrec real = float;;
                     end;;
open General;;
open Math;;
module LargeInt = struct
                    type nonrec int = int;;
                    end;;
module type REAL = sig
                   type nonrec real
                   module Math : MATH
                   (* 
  val radix : int
  val precision : int
  val maxFinite : real
  val minPos : real
  val minNormalPos : real
 *)
                   val posInf : real
                   val negInf : real
                   val ( + ) : real -> real -> real
                   val ( - ) : real -> real -> real
                   val ( * ) : real -> real -> real
                   val ( / ) : real -> real -> real
                   (* 
  val rem : real * real -> real
 *)
                   val ( *+ ) : (real * real * real) -> real
                   val ( *- ) : (real * real * real) -> real
                   val ( ~- ) : real -> real
                   val abs : real -> real
                   val min : (real * real) -> real
                   val max : (real * real) -> real
                   val sign : real -> int
                   val signBit : real -> bool
                   val sameSign : (real * real) -> bool
                   val copySign : (real * real) -> real
                   val compare : (real * real) -> order
                   val compareReal : (real * real) -> IEEEReal.real_order
                   val ( < ) : real -> real -> bool
                   val ( <= ) : real -> real -> bool
                   val ( > ) : real -> real -> bool
                   val ( >= ) : real -> real -> bool
                   val ( == ) : real -> real -> bool
                   val ( != ) : (real * real) -> bool
                   val op_qmark_eq : (real * real) -> bool
                   val unordered : (real * real) -> bool
                   val isFinite : real -> bool
                   val isNan : real -> bool
                   (* 
  val isNormal : real -> bool
  val class : real -> IEEEReal.float_class
  val fmt : StringCvt.realfmt -> real -> string
 *)
                   val toString : real -> string
                   val
                     scan : ((char, 'a) StringCvt.reader) ->
                            (real, 'a)
                            StringCvt.reader
                   val fromString : string -> real option
                   (* 
  val toManExp : real -> {man : real, exp : int}
  val fromManExp : {man : real, exp : int} -> real
  val split : real -> {whole : real, frac : real}
  val realMod : real -> real
  val nextAfter : real * real -> real
 *)
                   val checkFloat : real -> real
                   (* 
  val realFloor : real -> real
  val realCeil : real -> real
  val realTrunc : real -> real
  val realRound : real -> real
 *)
                   val floor : real -> int
                   val ceil : real -> int
                   val trunc : real -> int
                   val round : real -> int
                   val toInt : IEEEReal.rounding_mode -> real -> int
                   val
                     toLargeInt : IEEEReal.rounding_mode ->
                                  real ->
                                  LargeInt.int
                   val fromInt : int -> real
                   val fromLargeInt : LargeInt.int -> real
                   val toLarge : real -> LargeReal.real
                   val
                     fromLarge : IEEEReal.rounding_mode ->
                                 LargeReal.real ->
                                 real
                   end;;
(* 
  val toDecimal : real -> IEEEReal.decimal_approx
  val fromDecimal : IEEEReal.decimal_approx -> real option
 *);;
end;;
module type REAL = Sig_REAL.REAL;;
open! IEEEReal;;
(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Notes:
 * - Incomplete
 * - toString is currently implemented as primitive (it shouldn't be).
  *);;
open General;;
open Exceptions;;
open Types;;
module Real = struct
                type nonrec real = float;;
                module Math = Math;;
                let posInf : real = 0.0;;
                let negInf : real = 0.0;;
                let rec toLarge x = x;;
                let rec fromLarge mode x = x;;
                let rec fromInt i = raise ((General.Fail "TODO"));;
                let rec floor x = raise ((General.Fail "TODO"));;
                let rec ceil x = raise ((General.Fail "TODO"));;
                let rec trunc x = raise ((General.Fail "TODO"));;
                let rec round x = raise ((General.Fail "TODO"));;
                let rec toInt mode x = raise ((General.Fail "TODO"));;
                let rec toLargeInt mode x = raise ((General.Fail "TODO"));;
                let rec fromLargeInt i = raise ((General.Fail "TODO"));;
                let rec abs x = raise ((General.Fail "TODO"));;
                let ( ~- ) = ( ~- );;
                let ( + ) x__op y__op = x__op + y__op;;
                let ( - ) x__op y__op = x__op - y__op;;
                let ( * ) x__op y__op = x__op * y__op;;
                let ( / ) x__op y__op = x__op / y__op;;
                let rec multiply_add (x, y, z) = (x * y) + z;;
                let rec multiply_sub (x, y, z) = (x * y) - z;;
                let ( > ) x__op y__op = x__op > y__op;;
                let ( >= ) x__op y__op = x__op >= y__op;;
                let ( < ) x__op y__op = x__op < y__op;;
                let ( <= ) x__op y__op = x__op <= y__op;;
                let rec eq (a, b) = raise ((General.Fail "TODO"));;
                let rec qeq (a, b) = raise ((General.Fail "TODO"));;
                let rec neq (a, b) = raise ((General.Fail "TODO"));;
                let rec compareReal (i, j) = begin
                  if i < j then IEEEReal.Less else begin
                  if i > j then IEEEReal.Greater else IEEEReal.Equal end end;;
                let rec compare (i, j) = begin
                  if i < j then Less else begin
                  if i > j then Greater else Equal end end;;
                let rec isFinite x = raise ((General.Fail "TODO"));;
                let rec isNan x = raise ((General.Fail "TODO"));;
                let rec signBit x = raise ((General.Fail "TODO"));;
                let rec checkFloat x = raise ((General.Fail "TODO"));;
                let rec copySign (x, y) = raise ((General.Fail "TODO"));;
                let rec unordered (x, y) = raise ((General.Fail "TODO"));;
                let rec sameSign (x, y) = raise ((General.Fail "TODO"));;
                let rec min (x, y) = begin if x < y then x else y end;;
                let rec max (x, y) = begin if x > y then x else y end;;
                let rec sign x = begin
                  if x > 0.0 then 1 else begin if x < 0.0 then (-1) else 0
                  end end;;
                let rec toString x = raise ((General.Fail "TODO"));;
                let rec scan getc src = raise ((General.Fail "TODO"));;
                let rec fromString s = None;;
                end;;