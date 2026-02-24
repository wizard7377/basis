module Sig_CHAR = struct
(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
  *);;
open General;;
module Char = struct
                type nonrec char = char;;
                end;;
open General;;
module String = struct
                  type nonrec string = string;;
                  end;;
open General;;
module StringCvt = struct
                     type nonrec ('a, 'b) reader = 'b -> ('a * 'b) option;;
                     end;;
open General;;
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
                   val compare : (char * char) -> order
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
                   val
                     scan : ((Char.char, 'a) StringCvt.reader) ->
                            (char, 'a)
                            StringCvt.reader
                   val toString : char -> String.string
                   val fromCString : String.string -> char option
                   val toCString : char -> String.string
                   end;;
end;;
module type CHAR = Sig_CHAR.CHAR;;
open! Option;;
open! Bool;;
(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
  *);;
open General;;
open Exceptions;;
module Char = struct
                type nonrec char = char;;
                type nonrec string = string;;
                let rec ord c = raise ((General.Fail "TODO"));;
                let rec chr i = raise ((General.Fail "TODO"));;
                let maxOrd = 255;;
                let minChar = chr 0;;
                let maxChar = chr maxOrd;;
                let rec succ c = begin
                  if c = maxChar then raise Chr else chr ((ord c) + 1) end;;
                let rec pred c = begin
                  if c = minChar then raise Chr else chr ((ord c) - 1) end;;
                let rec string_sub_ (s, i) = raise ((General.Fail "TODO"));;
                let rec string_size_ s = raise ((General.Fail "TODO"));;
                let rec string_str_ c = raise ((General.Fail "TODO"));;
                let rec contains s c = conts' (s, c, (string_size_ s) - 1)
                and conts' (s, c, i) =
                  (i >= 0) &&
                    (((string_sub_ (s, i)) = c) || (conts' (s, c, i - 1)));;
                let rec notContains s c = Bool.not (contains s c);;
                let rec isUpper c = ('A' <= c) && (c <= 'Z');;
                let rec isLower c = ('a' <= c) && (c <= 'z');;
                let rec isDigit c = ('0' <= c) && (c <= '9');;
                let rec isAlpha c = (isUpper c) || (isLower c);;
                let rec isAlphaNum c = (isAlpha c) || (isDigit c);;
                let rec isHexDigit c =
                  (isDigit c) ||
                    ((('a' <= c) && (c <= 'f')) || (('A' <= c) && (c <= 'F')));;
                let rec isGraph c = ('!' <= c) && (c <= '~');;
                let rec isPrint c = (isGraph c) || (c = ' ');;
                let rec isPunct c = (isGraph c) && (Bool.not (isAlphaNum c));;
                let rec isCntrl c = Bool.not (isPrint c);;
                let rec isSpace c = (('t' <= c) && (c <= 'r')) || (c = ' ');;
                let rec isAscii c = (0 <= (ord c)) && ((ord c) <= 127);;
                let rec toLower c = begin
                  if isUpper c then chr ((ord c) + 32) else c end;;
                let rec toUpper c = begin
                  if isLower c then chr ((ord c) - 32) else c end;;
                let rec toControl c =
                  "\\^" ^ (string_str_ (chr ((ord c) + (ord '@'))));;
                let rec toAscii c = raise ((General.Fail "TODO"));;
                let rec toOctAscii c = raise ((General.Fail "TODO"));;
                let rec toString =
                  function 
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
                               if (ord c) < 32 then toControl c else begin
                               if (ord c) >= 127 then toAscii c else
                               string_str_ c end end;;
                let rec toCString =
                  function 
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
                           | c -> begin
                               if isPrint c then string_str_ c else
                               toOctAscii c end;;
                let rec isOctDigit c = ('0' <= c) && (c <= '7');;
                let rec value c =
                  (ord (toUpper c)) -
                    (begin if c < 'A' then ord '0' else (ord 'A') - 10 end);;
                let rec bindOpt arg__0 arg__1 =
                  begin
                  match (arg__0, arg__1)
                  with 
                       | (None, f) -> None
                       | (Some x, f) -> f x
                  end;;
                let rec scanAscii getc src0 = raise ((General.Fail "TODO"));;
                let rec scanUnicode getc src0 = raise ((General.Fail "TODO"));;
                let rec scanControl getc src = raise ((General.Fail "TODO"));;
                let rec scan getc src = raise ((General.Fail "TODO"));;
                let rec scanCAscii getc src = raise ((General.Fail "TODO"));;
                let rec scanCUnicode getc src = raise ((General.Fail "TODO"));;
                let rec scanCEscape getc src = raise ((General.Fail "TODO"));;
                let rec scanC getc src = raise ((General.Fail "TODO"));;
                let rec scanString f s =
                  Option.map
                  (fun (r, _) -> r)
                  ((f (reader s) 0 : ('a * int) option))
                and reader s i =
                  try (Some (string_sub_ (s, i), i + 1))
                  with 
                       | Subscript -> None;;
                let rec fromString s = scanString scan s;;
                let rec fromCString s = scanString scanC s;;
                let rec ( < ) (a, b) = raise ((General.Fail "TODO"));;
                let rec ( <= ) (a, b) = raise ((General.Fail "TODO"));;
                let rec ( > ) (a, b) = raise ((General.Fail "TODO"));;
                let rec ( >= ) (a, b) = raise ((General.Fail "TODO"));;
                let rec compare (c1, c2) = raise ((General.Fail "TODO"));;
                end;;