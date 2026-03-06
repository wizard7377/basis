module Sig_CHAR = struct
  (*
   * (c) Andreas Rossberg 2001-2025
   *
   * Standard ML Basis Library
   *)
  open General

  module Char = struct
    type nonrec char = char
  end

  open General

  module String = struct
    type nonrec string = string
  end

  open General

  module StringCvt = struct
    type nonrec ('a, 'b) reader = 'b -> ('a * 'b) option
  end

  open General

  module type CHAR = sig
    type nonrec char
    type nonrec string

    val minChar : char
    val maxChar : char
    val maxOrd : int
    val ord : char -> int
    val chr : int -> char
    val succ : char -> char
    val pred : char -> char
    val ( < ) : char -> char -> bool
    val ( <= ) : char -> char -> bool
    val ( > ) : char -> char -> bool
    val ( >= ) : char -> char -> bool
    val compare : char * char -> order
    val contains : string -> char -> bool
    val notContains : string -> char -> bool
    val toLower : char -> char
    val toUpper : char -> char
    val isAlpha : char -> bool
    val isAlphaNum : char -> bool
    val isAscii : char -> bool
    val isCntrl : char -> bool
    val isDigit : char -> bool
    val isGraph : char -> bool
    val isHexDigit : char -> bool
    val isLower : char -> bool
    val isPrint : char -> bool
    val isSpace : char -> bool
    val isPunct : char -> bool
    val isUpper : char -> bool
    val fromString : String.string -> char option
    val scan : (Char.char, 'a) StringCvt.reader -> (char, 'a) StringCvt.reader
    val toString : char -> String.string
    val fromCString : String.string -> char option
    val toCString : char -> String.string
  end
end

module type CHAR = Sig_CHAR.CHAR

open! Option
open! Bool

(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *)
open General
open Exceptions

module Char = struct
  type nonrec char = char
  type nonrec string = string

  let rec ord c = Stdlib.Char.code c
  let rec chr i = try Stdlib.Char.chr i with Invalid_argument _ -> raise Chr
  let maxOrd = 255
  let minChar = chr 0
  let maxChar = chr maxOrd

  let rec succ c =
    begin if c = maxChar then raise Chr else chr (ord c + 1)
    end

  let rec pred c =
    begin if c = minChar then raise Chr else chr (ord c - 1)
    end

  let rec string_sub_ (s, i) = try Stdlib.String.get s i with Invalid_argument _ -> raise Subscript
  let rec string_size_ s = Stdlib.String.length s
  let rec string_str_ c = Stdlib.String.make 1 c

  let rec contains s c = conts' (s, c, string_size_ s - 1)

  and conts' (s, c, i) =
    i >= 0 && (string_sub_ (s, i) = c || conts' (s, c, i - 1))

  let rec notContains s c = Bool.not (contains s c)
  let rec isUpper c = 'A' <= c && c <= 'Z'
  let rec isLower c = 'a' <= c && c <= 'z'
  let rec isDigit c = '0' <= c && c <= '9'
  let rec isAlpha c = isUpper c || isLower c
  let rec isAlphaNum c = isAlpha c || isDigit c

  let rec isHexDigit c =
    isDigit c || ('a' <= c && c <= 'f') || ('A' <= c && c <= 'F')

  let rec isGraph c = '!' <= c && c <= '~'
  let rec isPrint c = isGraph c || c = ' '
  let rec isPunct c = isGraph c && Bool.not (isAlphaNum c)
  let rec isCntrl c = Bool.not (isPrint c)
  let rec isSpace c = ('t' <= c && c <= 'r') || c = ' '
  let rec isAscii c = 0 <= ord c && ord c <= 127

  let rec toLower c =
    begin if isUpper c then chr (ord c + 32) else c
    end

  let rec toUpper c =
    begin if isLower c then chr (ord c - 32) else c
    end

  let rec toControl c = "\\^" ^ string_str_ (chr (ord c + ord '@'))
  let rec toAscii c = "\\" ^ string_str_ (chr (ord c / 100 + ord '0')) ^ string_str_ (chr (ord c mod 100 / 10 + ord '0')) ^ string_str_ (chr (ord c mod 10 + ord '0'))
  let rec toOctAscii c = "\\" ^ string_str_ (chr (ord c / 64 + ord '0')) ^ string_str_ (chr (ord c mod 64 / 8 + ord '0')) ^ string_str_ (chr (ord c mod 8 + ord '0'))

  let rec toString = function
    | '\\' -> "\\\\"
    | '"' -> "\\\""
    | 'a' -> "\\a"
    | 'b' -> "\\b"
    | 't' -> "\\t"
    | '\n' -> "\\n"
    | 'v' -> "\\v"
    | 'f' -> "\\f"
    | 'r' -> "\\r"
    | c -> begin
        if ord c < 32 then toControl c
        else begin
          if ord c >= 127 then toAscii c else string_str_ c
        end
      end

  let rec toCString = function
    | '\\' -> "\\\\"
    | '"' -> "\\\""
    | '?' -> "\\?"
    | '\'' -> "\\'"
    | 'a' -> "\\a"
    | 'b' -> "\\b"
    | 't' -> "\\t"
    | '\n' -> "\\n"
    | 'v' -> "\\v"
    | 'f' -> "\\f"
    | 'r' -> "\\r"
    | c -> begin if isPrint c then string_str_ c else toOctAscii c end

  let rec isOctDigit c = '0' <= c && c <= '7'

  let rec value c =
    ord (toUpper c)
    - begin if c < 'A' then ord '0' else ord 'A' - 10
    end

  let rec bindOpt arg__0 arg__1 =
    begin match (arg__0, arg__1) with None, f -> None | Some x, f -> f x
    end

  let rec scanAscii getc src0 =
    bindOpt (getc src0) (fun (c1, src1) ->
    bindOpt (getc src1) (fun (c2, src2) ->
    bindOpt (getc src2) (fun (c3, src3) ->
      begin if isDigit c1 && isDigit c2 && isDigit c3 then
        let i = 100 * value c1 + 10 * value c2 + value c3 in
        begin if i <= 255 then Some (chr i, src3) else None end
      else None
      end
    )))

  and scanUnicode getc src0 =
    bindOpt (getc src0) (fun (c1, src1) ->
    bindOpt (getc src1) (fun (c2, src2) ->
    bindOpt (getc src2) (fun (c3, src3) ->
    bindOpt (getc src3) (fun (c4, src4) ->
      begin if isHexDigit c1 && isHexDigit c2 && isHexDigit c3 && isHexDigit c4 then
        try Some (chr (4096 * value c1 + 256 * value c2 + 16 * value c3 + value c4), src4)
        with Chr -> None
      else None
      end
    ))))

  and scanControl getc src =
    bindOpt (getc src) (fun (c, src') ->
      begin if 64 <= ord c && ord c < 96 then Some (chr (ord c - 64), src')
      else None
      end
    )

  and scan getc src =
    bindOpt (scan_prime getc src) (fun (c, src') ->
    bindOpt (scanOptGap getc src') (fun src'' ->
      Some (c, src'')
    ))
  and scan_prime getc src =
    bindOpt (getc src) (fun (c, src') ->
      begin if c = '\\' then scanEscape getc src'
      else begin if isPrint c then Some (c, src') else None end
      end
    )

  and scanEscape getc src =
    bindOpt (getc src) (fun (c, src') ->
      begin if isDigit c then scanAscii getc src
      else begin if isSpace c then bindOpt (scanGap getc src') (scan_prime getc)
      else begin match c with
        | 'a' -> Some ('\007', src')
        | 'b' -> Some ('\b', src')
        | 't' -> Some ('\t', src')
        | 'n' -> Some ('\n', src')
        | 'v' -> Some ('\011', src')
        | 'f' -> Some ('\012', src')
        | 'r' -> Some ('\r', src')
        | '\\' -> Some ('\\', src')
        | '"' -> Some ('"', src')
        | '^' -> scanControl getc src'
        | 'u' -> scanUnicode getc src'
        | _ -> None
      end end end
    )

  and scanGap getc src =
    bindOpt (getc src) (fun (c, src') ->
      begin if c = '\\' then Some src'
      else begin if isSpace c then scanGap getc src' else None end
      end
    )

  and scanOptGap getc src = Some (begin match scanOptGap_prime getc src with None -> src | Some s -> s end)
  and scanOptGap_prime getc src =
    bindOpt (getc src) (fun (c1, src') ->
    bindOpt (getc src') (fun (c2, src'') ->
      begin if c1 = '\\' && isSpace c2
      then bindOpt (scanGap getc src'') (scanOptGap getc)
      else None
      end
    ))

  and scanCAscii getc src =
    bindOpt (scanCAscii_prime 0 0 getc src) (fun (i, k, src') ->
      begin if k = 0 then None
      else try Some (chr i, src') with Chr -> None
      end
    )
  and scanCAscii_prime i k getc src =
    begin if k = 3 then Some (i, 3, src)
    else begin match getc src with
      | None -> Some (i, k, src)
      | Some (c, src') ->
        begin if isOctDigit c
        then scanCAscii_prime (8 * i + value c) (k + 1) getc src'
        else Some (i, k, src)
        end
    end end

  and scanCUnicode getc src =
    bindOpt (try scanCUnicode_prime 0 0 getc src with Overflow -> None) (fun (i, k, src') ->
      begin if k = 0 then None
      else try Some (chr i, src') with Chr -> None
      end
    )
  and scanCUnicode_prime i k getc src =
    begin match getc src with
    | None -> Some (i, k, src)
    | Some (c, src') ->
      begin if isHexDigit c
      then scanCUnicode_prime (16 * i + value c) (k + 1) getc src'
      else Some (i, k, src)
      end
    end

  and scanCEscape getc src =
    bindOpt (getc src) (fun (c, src') ->
      begin if isDigit c then scanCAscii getc src
      else begin match c with
        | 'a' -> Some ('\007', src')
        | 'b' -> Some ('\b', src')
        | 't' -> Some ('\t', src')
        | 'n' -> Some ('\n', src')
        | 'v' -> Some ('\011', src')
        | 'f' -> Some ('\012', src')
        | 'r' -> Some ('\r', src')
        | '?' -> Some ('?', src')
        | '\\' -> Some ('\\', src')
        | '"' -> Some ('"', src')
        | '\'' -> Some ('\'', src')
        | '^' -> scanControl getc src'
        | 'x' -> scanCUnicode getc src'
        | _ -> None
      end end
    )

  and scanC getc src =
    bindOpt (getc src) (fun (c, src') ->
      begin if c = '\\' then scanCEscape getc src'
      else begin if isPrint c then Some (c, src') else None end
      end
    )

  let rec scanString f s =
    Option.map (fun (r, _) -> r) (f (reader s) 0 : ('a * int) option)

  and reader s i = try Some (string_sub_ (s, i), i + 1) with Subscript -> None

  let rec fromString s = scanString scan s
  let rec fromCString s = scanString scanC s
  let ( < ) (a, b) = a < b
  let ( <= ) (a, b) = a <= b
  let ( > ) (a, b) = a > b
  let ( >= ) (a, b) = a >= b
  let rec compare (c1, c2) =
    begin if Stdlib.( < ) c1 c2 then Less
    else begin if c1 = c2 then Equal else Greater end
    end
end
