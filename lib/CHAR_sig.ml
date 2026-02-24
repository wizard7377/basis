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