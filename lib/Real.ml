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
open REAL_sig;;
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