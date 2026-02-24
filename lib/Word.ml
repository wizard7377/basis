(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note:
 * - Dropped deprecated {from,to}LargeWord functions.
  *);;
open General;;
open Exceptions;;
open WORD_sig;;
module Word = struct
                type nonrec word = int;;
                let wordSize = 63;;
                let rec toLarge w = w;;
                let rec toLargeX w = w;;
                let rec fromLarge w = w;;
                let rec toInt w = w;;
                let rec toIntX w = w;;
                let rec fromInt w = w;;
                let rec toLargeInt w = w;;
                let rec toLargeIntX w = w;;
                let rec fromLargeInt w = w;;
                let rec notb w = raise ((General.Fail "TODO"));;
                let rec orb (a, b) = raise ((General.Fail "TODO"));;
                let rec xorb (a, b) = raise ((General.Fail "TODO"));;
                let rec andb (a, b) = raise ((General.Fail "TODO"));;
                let rec shl (a, b) = raise ((General.Fail "TODO"));;
                let rec shr (a, b) = raise ((General.Fail "TODO"));;
                let rec ashr (a, b) = raise ((General.Fail "TODO"));;
                let ( + ) x__op y__op = x__op + y__op;;
                let ( - ) x__op y__op = x__op - y__op;;
                let ( * ) x__op y__op = x__op * y__op;;
                let rec div (a, b) = raise ((General.Fail "TODO"));;
                let rec mod_ (a, b) = raise ((General.Fail "TODO"));;
                let rec negate w = raise ((General.Fail "TODO"));;
                let ( > ) x__op y__op = x__op > y__op;;
                let ( >= ) x__op y__op = x__op >= y__op;;
                let ( < ) x__op y__op = x__op < y__op;;
                let ( <= ) x__op y__op = x__op <= y__op;;
                let rec compare (i, j) = begin
                  if i < j then Less else begin
                  if i = j then Equal else Greater end end;;
                let rec min (i, j) = begin if i < j then i else j end;;
                let rec max (i, j) = begin if i > j then i else j end;;
                let rec fmt radix w = raise ((General.Fail "TODO"));;
                let rec toString w = raise ((General.Fail "TODO"));;
                let rec scan radix getc src = raise ((General.Fail "TODO"));;
                let rec fromString s = None;;
                end;;