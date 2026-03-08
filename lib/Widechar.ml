open Char
open StringCvt

module WideChar : CHAR with type string = string = struct
  type nonrec char = char
  type nonrec string = string

  let minChar : char = Char.minChar
  let maxChar : char = Char.maxChar
  let maxOrd : int = Char.maxOrd
  let ord : char -> int = Char.ord
  let chr : int -> char = Char.chr
  let succ : char -> char = Char.succ
  let pred : char -> char = Char.pred

  let compare : char * char -> General.General.order =
   fun (c1, c2) ->
    begin if Stdlib.( < ) c1 c2 then General.General.Less
    else begin
      if c1 = c2 then General.General.Equal else General.General.Greater
    end
    end

  let ( < ) : char -> char -> bool = fun a b -> Stdlib.( < ) a b
  let ( <= ) : char -> char -> bool = fun a b -> Stdlib.( <= ) a b
  let ( > ) : char -> char -> bool = fun a b -> Stdlib.( > ) a b
  let ( >= ) : char -> char -> bool = fun a b -> Stdlib.( >= ) a b
  let contains : string -> char -> bool = Char.contains
  let notContains : string -> char -> bool = Char.notContains
  let isAscii : char -> bool = Char.isAscii
  let toLower : char -> char = Char.toLower
  let toUpper : char -> char = Char.toUpper
  let isAlpha : char -> bool = Char.isAlpha
  let isAlphaNum : char -> bool = Char.isAlphaNum
  let isCntrl : char -> bool = Char.isCntrl
  let isDigit : char -> bool = Char.isDigit
  let isGraph : char -> bool = Char.isGraph
  let isHexDigit : char -> bool = Char.isHexDigit
  let isLower : char -> bool = Char.isLower
  let isPrint : char -> bool = Char.isPrint
  let isSpace : char -> bool = Char.isSpace
  let isPunct : char -> bool = Char.isPunct
  let isUpper : char -> bool = Char.isUpper
  let toString : char -> string = Char.toString

  let scan : (Char.char, 'a) StringCvt.reader -> (char, 'a) StringCvt.reader =
    Char.scan

  let fromString : string -> char option = Char.fromString
  let toCString : char -> string = Char.toCString
  let fromCString : string -> char option = Char.fromCString
end
