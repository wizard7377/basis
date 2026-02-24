(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *)
open General

module type STRING_CVT = sig
  type radix = Bin | Oct | Dec | Hex

  type realfmt =
    | Sci of int option
    | Fix of int option
    | Gen of int option
    | Exact

  type nonrec ('a, 'b) reader = 'b -> ('a * 'b) option

  val padLeft : char -> int -> string -> string
  val padRight : char -> int -> string -> string
  val splitl : (char -> bool) -> (char, 'a) reader -> 'a -> string * 'a
  val takel : (char -> bool) -> (char, 'a) reader -> 'a -> string
  val dropl : (char -> bool) -> (char, 'a) reader -> 'a -> 'a
  val skipWS : (char, 'a) reader -> 'a -> 'a

  type nonrec cs

  val scanString : ((char, cs) reader -> ('a, cs) reader) -> string -> 'a option
end

open! List
open! String

(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *)
open Exceptions

module StringCvt = struct
  type nonrec cs = int
  type nonrec ('a, 'b) reader = 'b -> ('a * 'b) option
  type radix = Bin | Oct | Dec | Hex

  type realfmt =
    | Sci of int option
    | Fix of int option
    | Gen of int option
    | Exact

  let rec strCat (a, b) = a ^ b

  let rec clamp i =
    begin if i < 0 then 0 else i
    end

  let rec padding c i =
    String.implode (List.tabulate (clamp i, function _ -> c))

  let rec padLeft c i s = strCat (padding c (i - String.size s), s)
  let rec padRight c i s = strCat (s, padding c (i - String.size s))

  let rec splitl p f src = splitl' (p, f, src, [])

  and splitl' (p, f, src, cs) =
    begin match f src with
    | None -> (String.implode (List.rev cs), src)
    | Some (c, src') -> begin
        if p c then splitl' (p, f, src', c :: cs)
        else (String.implode (List.rev cs), src)
      end
    end

  let rec takel p f s =
    let a, _ = splitl p f s in
    a

  let rec dropl p f s =
    let _, b = splitl p f s in
    b

  let rec skipWS f s =
    dropl (function c -> c = ' ' || c = 't' || c = '\n' || c = 'r') f s

  let rec scanString f s = raise (General.Fail "TODO")

  let rec reader s i =
    try Some (String.sub (s, i), i + 1) with Subscript -> None
end
