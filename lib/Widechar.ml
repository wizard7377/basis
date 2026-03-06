open Char 
open StringCvt
module WideChar : CHAR with type string = string = struct
  type nonrec char = char
  type nonrec string = string 


let minChar  :  char = assert false
let maxChar  :  char = assert false
let maxOrd  :  int = assert false

let ord  :  char -> int = assert false
let chr  :  int -> char = assert false
let succ  :  char -> char = assert false
let pred  :  char -> char = assert false

let compare  :  char * char -> General.General.order = assert false
let (< )  :  char -> char -> bool = assert false
let (<=)  :  char -> char -> bool = assert false
let (> )  :  char -> char -> bool = assert false
let (>=)  :  char -> char -> bool = assert false

let contains  :  string -> char -> bool = assert false
let notContains  :  string -> char -> bool = assert false

let isAscii  :  char -> bool = assert false
let toLower  :  char -> char = assert false
let toUpper  :  char -> char = assert false
let isAlpha  :  char -> bool = assert false
let isAlphaNum  :  char -> bool = assert false
let isCntrl  :  char -> bool = assert false
let isDigit  :  char -> bool = assert false
let isGraph  :  char -> bool = assert false
let isHexDigit  :  char -> bool = assert false
let isLower  :  char -> bool = assert false
let isPrint  :  char -> bool = assert false
let isSpace  :  char -> bool = assert false
let isPunct  :  char -> bool = assert false
let isUpper  :  char -> bool = assert false

let toString  :  char -> string = assert false
let scan        :  (Char.char, 'a) StringCvt.reader
                   -> (char, 'a) StringCvt.reader  = assert false
let fromString  :  string -> char option = assert false
let toCString  :  char -> string = assert false
let fromCString  :  string -> char option = assert false
end