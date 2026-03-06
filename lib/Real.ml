module Sig_REAL = struct
  (*
   * (c) Andreas Rossberg 2001-2025
   *
   * Standard ML Basis Library
   *
   * Note: Incomplete.
   *)
  open General
  open StringCvt
  open IEEEReal
  open IEEEReal
  open Int

  module LargeReal = struct
    type nonrec real = float
  end

  open General
  open Math

  module LargeInt = struct
    type nonrec int = int
  end

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
    val ( *+ ) : real * real * real -> real
    val ( *- ) : real * real * real -> real
    val ( ~- ) : real -> real
    val abs : real -> real
    val min : real * real -> real
    val max : real * real -> real
    val sign : real -> int
    val signBit : real -> bool
    val sameSign : real * real -> bool
    val copySign : real * real -> real
    val compare : real * real -> order
    val compareReal : real * real -> IEEEReal.real_order
    val ( < ) : real -> real -> bool
    val ( <= ) : real -> real -> bool
    val ( > ) : real -> real -> bool
    val ( >= ) : real -> real -> bool
    val ( == ) : real -> real -> bool
    val ( != ) : real * real -> bool
    val op_qmark_eq : real * real -> bool
    val unordered : real * real -> bool
    val isFinite : real -> bool
    val isNan : real -> bool

    (* 
  val isNormal : real -> bool
  val class : real -> IEEEReal.float_class
  val fmt : StringCvt.realfmt -> real -> string
 *)
    val toString : real -> string
    val scan : (char, 'a) StringCvt.reader -> (real, 'a) StringCvt.reader
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
    val toLargeInt : IEEEReal.rounding_mode -> real -> LargeInt.int
    val fromInt : int -> real
    val fromLargeInt : LargeInt.int -> real
    val toLarge : real -> LargeReal.real
    val fromLarge : IEEEReal.rounding_mode -> LargeReal.real -> real
  end
  (* 
  val toDecimal : real -> IEEEReal.decimal_approx
  val fromDecimal : IEEEReal.decimal_approx -> real option
 *)
end

module type REAL = Sig_REAL.REAL

open! IEEEReal

(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Notes:
 * - Incomplete
 * - toString is currently implemented as primitive (it shouldn't be).
 *)
open General
open Exceptions
open Types

module Real = struct
  type nonrec real = float

  module Math = Math.Math

  let posInf : real = infinity
  let negInf : real = neg_infinity
  let rec toLarge x = x
  let rec fromLarge mode x = x
  let rec fromInt i = Stdlib.Float.of_int i
  let rec floor x = Stdlib.Float.to_int (Stdlib.floor x)
  let rec ceil x = Stdlib.Float.to_int (Stdlib.ceil x)
  let rec trunc x = Stdlib.Float.to_int x
  let rec round x =
    let f = Stdlib.Float.round x in
    let diff = x -. f in
    begin if diff = 0.5 || diff = -0.5 then
      let fi = Stdlib.Float.to_int f in
      begin if fi mod 2 <> 0 then
        begin if diff > 0.0 then fi - 1 else fi + 1 end
      else fi end
    else Stdlib.Float.to_int f end
  let rec toInt mode x =
    begin match mode with
    | IEEEReal.To_neginf -> floor x
    | IEEEReal.To_posinf -> ceil x
    | IEEEReal.To_zero -> trunc x
    | IEEEReal.To_nearest -> round x
    end
  let rec toLargeInt mode x = toInt mode x
  let rec fromLargeInt i = fromInt i
  let rec abs x = Stdlib.Float.abs x
  let ( ~- ) = ( ~- )
  let ( + ) x__op y__op = x__op + y__op
  let ( - ) x__op y__op = x__op - y__op
  let ( * ) x__op y__op = x__op * y__op
  let ( / ) x__op y__op = x__op / y__op
  let rec multiply_add (x, y, z) = (x * y) + z
  let rec multiply_sub (x, y, z) = (x * y) - z
  let ( > ) x__op y__op = x__op > y__op
  let ( >= ) x__op y__op = x__op >= y__op
  let ( < ) x__op y__op = x__op < y__op
  let ( <= ) x__op y__op = x__op <= y__op
  let rec eq (a, b) = a = b
  let rec qeq (a, b) = a = b || (Stdlib.Float.is_nan a && Stdlib.Float.is_nan b)
  let rec neq (a, b) = not (a = b)

  let rec compareReal (i, j) =
    begin if i < j then IEEEReal.Less
    else begin if eq (i, j) then IEEEReal.Equal
    else begin if i > j then IEEEReal.Greater
    else IEEEReal.Unordered
    end end end

  let rec compare (i, j) =
    begin match compareReal (i, j) with
    | IEEEReal.Less -> Less
    | IEEEReal.Equal -> Equal
    | IEEEReal.Greater -> Greater
    | IEEEReal.Unordered -> raise IEEEReal.Unordered
    end

  let rec isFinite x = Stdlib.Float.is_finite x
  let rec isNan x = Stdlib.Float.is_nan x
  let rec signBit x = Stdlib.Float.copy_sign 1.0 x < 0.0
  let rec checkFloat x =
    begin if isNan x then raise Div
    else begin if not (isFinite x) then raise Overflow else x end
    end
  let rec copySign (x, y) = Stdlib.Float.copy_sign x y
  let rec unordered (x, y) = isNan x || isNan y
  let rec sameSign (x, y) = signBit x = signBit y

  let rec min (x, y) =
    begin if x < y then x else y
    end

  let rec max (x, y) =
    begin if x > y then x else y
    end

  let rec sign x =
    begin if x > 0.0 then 1
    else begin
      if x < 0.0 then -1 else 0
    end
    end

  let rec value c = fromInt (Stdlib.Char.code c - Stdlib.Char.code '0')

  let bindOpt arg__0 arg__1 =
    begin match (arg__0, arg__1) with None, _ -> None | Some x, f -> f x
    end

  let rec scanSign getc src =
    begin match getc src with
    | Some ('-', src') -> Some (-1.0, src')
    | Some ('~', src') -> Some (-1.0, src')
    | Some ('+', src') -> Some (1.0, src')
    | _ -> Some (1.0, src)
    end

  and scanTextual ss getc src =
    begin if Substring.Substring.size ss = 0 then Some src
    else bindOpt (getc src) (fun (c, src') ->
      begin if Char.Char.toLower c = Substring.Substring.sub (ss, 0)
      then scanTextual (Substring.Substring.triml 1 ss) getc src'
      else None
      end
    )
    end

  and scanFractional getc src =
    bindOpt (getc src) (fun (c, _) ->
      begin if Char.Char.isDigit c
      then scanFractional_prime 0.0 0.1 getc src
      else None
      end
    )
  and scanFractional_prime r d getc src =
    begin match getc src with
    | Some (c, src') ->
      begin if Char.Char.isDigit c
      then scanFractional_prime (r +. d *. value c) (d /. 10.0) getc src'
      else Some (r, src)
      end
    | None -> Some (r, src)
    end

  and scanMantissa getc src =
    bindOpt (getc src) (fun (c, src') ->
      begin if c = '.' then
        bindOpt (scanFractional getc src') (fun (r, src'') -> Some (r, src''))
      else begin if Char.Char.isDigit c then Some (scanMantissa_prime 0.0 getc src)
      else None
      end end
    )
  and scanMantissa_prime r getc src =
    begin match getc src with
    | Some ('.', src') ->
      begin match scanFractional getc src' with
      | Some (r', src'') -> (r +. r', src'')
      | None -> (r, src)
      end
    | Some (c, src') ->
      begin if Char.Char.isDigit c
      then scanMantissa_prime (10.0 *. r +. value c) getc src'
      else (r, src)
      end
    | None -> (r, src)
    end

  and scanExp getc src =
    bindOpt (getc src) (fun (c, src') ->
      begin if c = 'e' || c = 'E' then scanExp_prime getc src' else None end
    )
  and scanExp_prime getc src =
    bindOpt (scanSign getc src) (fun (sign, src1) ->
    bindOpt (getc src1) (fun (c, _) ->
      begin if Char.Char.isDigit c
      then bindOpt (scanExp_prime2 0.0 getc src1) (fun (r, src2) -> Some (sign *. r, src2))
      else None
      end
    ))
  and scanExp_prime2 exp getc src =
    begin match getc src with
    | Some (c, src') ->
      begin if Char.Char.isDigit c
      then scanExp_prime2 (10.0 *. exp +. value c) getc src'
      else Some (exp, src)
      end
    | None -> Some (exp, src)
    end

  and scan getc src =
    bindOpt (scanSign getc (StringCvt.StringCvt.skipWS getc src)) (fun (sign, src1) ->
      begin match scanTextual (Substring.Substring.full "infinity") getc src1 with
      | Some src2 -> Some (sign *. posInf, src2)
      | None ->
      begin match scanTextual (Substring.Substring.full "inf") getc src1 with
      | Some src2 -> Some (sign *. posInf, src2)
      | None ->
      begin match scanTextual (Substring.Substring.full "nan") getc src1 with
      | Some src2 -> Some (0.0 *. posInf, src2)
      | None ->
      bindOpt (scanMantissa getc src1) (fun (man, src2) ->
        begin match scanExp getc src2 with
        | None -> Some (sign *. man, src2)
        | Some (exp, src3) ->
          Some (
            (begin if eq (man, 0.0) then 0.0 else sign *. man *. Math.pow (10.0, exp) end),
            src3
          )
        end
      )
      end end end
    )

  let rec toString x = Stdlib.string_of_float x
  let rec fromString s = StringCvt.StringCvt.scanString scan s
end
