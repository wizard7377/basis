module Sig_WORD = struct
  (*
   * (c) Andreas Rossberg 2001-2025
   *
   * Standard ML Basis Library
   *
   * Note:
   * - Dropped deprecated {from,to}LargeWord functions.
   *)
  open General
  open StringCvt

  module Int = struct
    type nonrec int = int
  end

  module LargeInt = struct
    type nonrec int = int
  end

  module Word = struct
    type nonrec word = int
  end

  open General

  module LargeWord = struct
    type nonrec word = int
  end

  open General

  module type WORD = sig
    type nonrec word

    val wordSize : int
    val toLarge : word -> LargeWord.word
    val toLargeX : word -> LargeWord.word
    val fromLarge : LargeWord.word -> word
    val toLargeInt : word -> LargeInt.int
    val toLargeIntX : word -> LargeInt.int
    val fromLargeInt : LargeInt.int -> word
    val toInt : word -> Int.int
    val toIntX : word -> Int.int
    val fromInt : Int.int -> word
    val orb : word * word -> word
    val xorb : word * word -> word
    val andb : word * word -> word
    val notb : word -> word
    val ( << ) : word -> Word.word -> word
    val ( >> ) : word -> Word.word -> word
    val ( ~>> ) : word * Word.word -> word
    val ( + ) : word -> word -> word
    val ( - ) : word -> word -> word
    val ( * ) : word -> word -> word
    val div : word * word -> word
    val mod_ : word * word -> word
    val ( ~- ) : word -> word
    val compare : word * word -> order
    val ( > ) : word -> word -> bool
    val ( < ) : word -> word -> bool
    val ( >= ) : word -> word -> bool
    val ( <= ) : word -> word -> bool
    val min : word * word -> word
    val max : word * word -> word
    val fmt : StringCvt.radix -> word -> string
    val toString : word -> string

    val scan :
      StringCvt.radix ->
      (char, 'a) StringCvt.reader ->
      (word, 'a) StringCvt.reader

    val fromString : string -> word option
  end
end

module type WORD = Sig_WORD.WORD

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

module Word = struct
  type nonrec word = int

  let wordSize = 63
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

  let rec base = function
    | StringCvt.StringCvt.Bin -> 2
    | StringCvt.StringCvt.Oct -> 8
    | StringCvt.StringCvt.Dec -> 10
    | StringCvt.StringCvt.Hex -> 16

  and isDigit_radix = function
    | StringCvt.StringCvt.Bin -> fun c -> '0' <= c && c <= '1'
    | StringCvt.StringCvt.Oct -> fun c -> '0' <= c && c <= '7'
    | StringCvt.StringCvt.Dec -> Char.Char.isDigit
    | StringCvt.StringCvt.Hex -> Char.Char.isHexDigit

  and digit i =
    Char.Char.chr
      begin if i < 10 then Char.Char.ord '0' + i else Char.Char.ord 'A' + i - 10
      end

  and value c =
    Char.Char.ord (Char.Char.toUpper c)
    - begin if c < 'A' then Char.Char.ord '0' else Char.Char.ord 'A' - 10
    end

  and fmt radix w =
    begin if w = 0 then "0" else fmt_prime (base radix, w, [])
    end

  and fmt_prime (b, w, cs) =
    begin if w = 0 then String.String.implode cs
    else fmt_prime (b, w / b, digit (toInt (w mod b)) :: cs)
    end

  let bindOpt arg__0 arg__1 =
    begin match (arg__0, arg__1) with None, _ -> None | Some x, f -> f x
    end

  let rec scanPrefix radix getc src =
    bindOpt (getc src) (fun (c1, src1) ->
        bindOpt (getc src1) (fun (c2, src2) ->
            begin if Bool.Bool.not (c1 = '0') then None
            else begin
              if radix = StringCvt.StringCvt.Hex && (c2 = 'x' || c2 = 'X') then
                Some src2
              else begin
                if Bool.Bool.not (c2 = 'w') then None
                else
                  bindOpt (getc src2) (fun (c3, src3) ->
                      Some
                        begin if c3 = 'x' || c3 = 'X' then src3 else src2
                        end)
              end
            end
            end))

  and scanOptPrefix radix getc src =
    begin match scanPrefix radix getc src with
    | Some src' -> Some src'
    | None -> Some src
    end

  and scanNum (isDigit_f, b) getc src =
    bindOpt
      (scanNum_prime (isDigit_f, b, 0, 0) getc src)
      (fun (w, k, src') ->
        begin if k > 0 then Some (w, src') else None
        end)

  and scanNum_prime (isDigit_f, b, w, k) getc src =
    begin match getc src with
    | Some (c, src') -> begin
        if not (isDigit_f c) then Some (w, k, src)
        else
          scanNum_prime
            (isDigit_f, b, (b * w) + fromInt (value c), k + 1)
            getc src'
      end
    | None -> Some (w, k, src)
    end

  and scan radix getc src =
    bindOpt
      (scanOptPrefix radix getc (StringCvt.StringCvt.skipWS getc src))
      (fun src1 ->
        begin match scanNum (isDigit_radix radix, base radix) getc src1 with
        | Some (num, src2) -> Some (num, src2)
        | None -> scanNum (isDigit_radix radix, 0) getc src
        end)

  let rec toString w = fmt StringCvt.StringCvt.Hex w

  let rec fromString s =
    StringCvt.StringCvt.scanString (scan StringCvt.StringCvt.Hex) s
end
