module Sig_BOOL = struct
  (*
   * (c) Andreas Rossberg 2001-2025
   *
   * Standard ML Basis Library
   *)
  open General

  module StringCvt = struct
    type nonrec ('a, 'b) reader = 'b -> ('a * 'b) option
  end

  open General

  module type BOOL = sig
    type nonrec bool = bool

    val not : bool -> bool
    val scan : (char, 'a) StringCvt.reader -> (bool, 'a) StringCvt.reader
    val fromString : string -> bool option
    val toString : bool -> string
  end
end

module type BOOL = Sig_BOOL.BOOL

(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *)
open General
open Exceptions

module Bool = struct
  type nonrec bool = bool

  let rec not = function true -> false | false -> true
  let rec string_sub (s, i) = (raise (General.Fail "TODO") : char)
  let rec string_size s = raise (General.Fail "TODO")
  let rec ord c = raise (General.Fail "TODO")
  let rec chr i = raise (General.Fail "TODO")
  let rec char_isSpace c = ('t' <= c && c <= 'r') || c <= ' '
  let rec char_isUpper c = 'A' <= c && c <= 'Z'

  let rec char_toLower c =
    begin if char_isUpper c then chr (ord c + 32) else c
    end

  let rec stringCvt_dropl p f src =
    begin match f src with
    | None -> src
    | Some (c, src') -> begin if p c then stringCvt_dropl p f src' else src end
    end

  let rec stringCvt_skipWS f s = stringCvt_dropl char_isSpace f s

  let rec stringCvt_scanString f s =
    begin match f (reader s) 0 with None -> None | Some (a, _) -> Some a
    end

  and reader s i = try Some (string_sub (s, i), i + 1) with Subscript -> None

  let rec scanTextual (s, i) getc src =
    begin if i = string_size s then Some src
    else begin
      match getc src with
      | Some (c, src') -> begin
          if char_toLower c = string_sub (s, i) then
            scanTextual (s, i + 1) getc src'
          else None
        end
      | None -> None
    end
    end

  let rec scan getc src =
    let src1 = stringCvt_skipWS getc src in
    begin match scanTextual ("true", 0) getc src1 with
    | Some src2 -> Some (true, src2)
    | None -> begin
        match scanTextual ("false", 0) getc src1 with
        | Some src2 -> Some (false, src2)
        | None -> None
      end
    end

  let rec fromString s = stringCvt_scanString scan s
  let rec toString = function true -> "true" | false -> "false"
end
