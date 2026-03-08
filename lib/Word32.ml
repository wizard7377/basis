(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note:
 * - Dropped deprecated {from,to}LargeWord functions.
 *)
open General
open Exceptions
open Word

module Word32 = struct
  type nonrec word = int

  let wordSize = 32
  let rec toLarge w = w
  let rec toLargeX w = w
  let rec fromLarge w = w
  let rec toInt w = w
  let rec toIntX w = w
  let rec fromInt w = w
  let rec toLargeInt w = w
  let rec toLargeIntX w = w
  let rec fromLargeInt w = w
  let rec notb w = lnot w
  let rec orb (a, b) = a lor b
  let rec xorb (a, b) = a lxor b
  let rec andb (a, b) = a land b
  let rec shl (a, b) = a lsl b
  let rec shr (a, b) = a lsr b
  let rec ashr (a, b) = a asr b
  let ( + ) x__op y__op = x__op + y__op
  let ( - ) x__op y__op = x__op - y__op
  let ( * ) x__op y__op = x__op * y__op
  let rec div (a, b) = a / b
  let rec mod_ (a, b) = a mod b
  let rec negate w = lnot (w - 1)
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

  let rec min (i, j) =
    begin if i < j then i else j
    end

  let rec max (i, j) =
    begin if i > j then i else j
    end

  let rec fmt radix w = Word.fmt radix (toLarge w)
  let rec toString w = fmt StringCvt.StringCvt.Hex w
  let rec scan radix getc src = Word.scan radix getc src

  let rec fromString s =
    StringCvt.StringCvt.scanString (scan StringCvt.StringCvt.Hex) s
end
