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
  let rec quot (a, b) = a / b
  let rec rem (a, b) = a mod b

  let rec div (a, b) =
    let q = a / b in
    begin if a mod b <> 0 && a lxor b < 0 then q - 1 else q
    end

  let rec mod_ (a, b) =
    let r = a mod b in
    begin if r <> 0 && r lxor b < 0 then r + b else r
    end

  let rec min (i, j) =
    begin if i < j then i else j
    end

  let rec max (i, j) =
    begin if i > j then i else j
    end

  let rec sign = function 0 -> 0 | i -> begin if i > 0 then 1 else -1 end
  let rec sameSign (i, j) = sign i = sign j

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
      (i
      + begin if i < 10 then Char.Char.ord '0' else Char.Char.ord 'A' - 10
      end)

  and value c =
    Char.Char.ord (Char.Char.toUpper c)
    - begin if c < 'A' then Char.Char.ord '0' else Char.Char.ord 'A' - 10
    end

  and fmt radix i =
    begin if i = 0 then "0"
    else begin
      if i > 0 then fmt_prime (base radix, -i, [])
      else "~" ^ fmt_prime (base radix, i, [])
    end
    end

  and fmt_prime (b, i, cs) =
    begin if i = 0 then String.String.implode cs
    else fmt_prime (b, quot (i, b), digit (-rem (i, b)) :: cs)
    end

  let bindOpt arg__0 arg__1 =
    begin match (arg__0, arg__1) with None, _ -> None | Some x, f -> f x
    end

  let rec scanSign getc src =
    begin match getc src with
    | Some ('-', src') -> Some (1, src')
    | Some ('~', src') -> Some (1, src')
    | Some ('+', src') -> Some (-1, src')
    | _ -> Some (-1, src)
    end

  and scanHexPrefix getc src =
    bindOpt (getc src) (fun (c1, src1) ->
        bindOpt (getc src1) (fun (c2, src2) ->
            begin if c1 = '0' && (c2 = 'x' || c2 = 'X') then Some src2 else None
            end))

  and scanPrefix radix getc src =
    begin if Bool.Bool.not (radix = StringCvt.StringCvt.Hex) then Some src
    else begin
      match scanHexPrefix getc src with
      | Some src' -> Some src'
      | None -> Some src
    end
    end

  and scanNum (isDigit_f, b) getc src =
    bindOpt
      (scanNum_prime (isDigit_f, b, 0, 0) getc src)
      (fun (i, k, src') ->
        begin if k > 0 then Some (i, src') else None
        end)

  and scanNum_prime (isDigit_f, b, i, k) getc src =
    begin match getc src with
    | Some (c, src') -> begin
        if isDigit_f c then
          scanNum_prime (isDigit_f, b, (b * i) - value c, k + 1) getc src'
        else Some (i, k, src)
      end
    | None -> Some (i, k, src)
    end

  and scan radix getc src =
    bindOpt
      (scanSign getc (StringCvt.StringCvt.skipWS getc src))
      (fun (sign, src1) ->
        bindOpt (scanPrefix radix getc src1) (fun src2 ->
            begin match scanNum (isDigit_radix radix, base radix) getc src2 with
            | Some (num, src3) -> Some (sign * num, src3)
            | None -> scanNum (isDigit_radix radix, 0) getc src1
            end))

  let rec toString i = fmt StringCvt.StringCvt.Dec i

  let rec fromString s =
    StringCvt.StringCvt.scanString (scan StringCvt.StringCvt.Dec) s

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

module Int31 : INTEGER with type int = int = struct
  include Int

  type nonrec int = int

  let compare (i, j) =
    begin if i < j then General.Less
    else begin
      if i = j then General.Equal else General.Greater
    end
    end
end
