(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note: Incomplete.
 *)
open General

module type STRING = sig
  type nonrec string
  type nonrec char

  val maxSize : int
  val size : string -> int
  val sub : string * int -> char
  val extract : string * int * int option -> string
  val substring : string * int * int -> string
  val ( ^ ) : string -> string -> string
  val concat : string list -> string
  val concatWith : string -> string list -> string
  val str : char -> string
  val implode : char list -> string
  val explode : string -> char list
  val map : (char -> char) -> string -> string
  val translate : (char -> string) -> string -> string
  val tokens : (char -> bool) -> string -> string list
  val fields : (char -> bool) -> string -> string list
  val isPrefix : string -> string -> bool
  val isSubstring : string -> string -> bool
  val isSuffix : string -> string -> bool
  val compare : string * string -> order
  val collate : (char * char -> order) -> string * string -> order
  val ( < ) : string -> string -> bool
  val ( <= ) : string -> string -> bool
  val ( > ) : string -> string -> bool
  val ( >= ) : string -> string -> bool
  val fromString : string -> string option
  val toString : string -> string

  (* 
  val fromCString : string -> string option
 *)
  val toCString : string -> string
end

open! List
open! Bool
open! Char

(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note: Incomplete.
 *)
open Exceptions

module String = struct
  type nonrec string = string
  type nonrec char = char

  let maxSize : int = 0
  let rec size s = raise (General.Fail "TODO")
  let rec sub (s, i) = raise (General.Fail "TODO")
  let rec str c = raise (General.Fail "TODO")
  let rec concat = function [] -> "" | s :: l -> s ^ concat l

  let rec concatWith arg__0 arg__1 =
    begin match (arg__0, arg__1) with
    | s, [] -> ""
    | s, s' :: [] -> s'
    | s, s' :: l -> (s' ^ s) ^ concatWith s l
    end

  let rec implode l = concat (List.map str l)

  let rec explode s = explode' (s, size s - 1, [])

  and explode' (s, i, l) =
    begin if i < 0 then l else explode' (s, i - 1, sub (s, i) :: l)
    end

  let rec substring (s, i, j) =
    try substring' (s, i, i - 1 + j, []) with Overflow -> raise Subscript

  and substring' (s, i, j, cs) =
    begin if i > j then implode cs
    else substring' (s, i, j - 1, sub (s, j) :: cs)
    end

  let ( ^ ) s1 s2 = s1 ^ s2

  let rec extract = function
    | s, i, None -> substring (s, i, size s - i)
    | s, i, Some j -> substring (s, i, j)

  let rec map f s = implode (List.map f (explode s))
  let rec translate f s = concat (List.map f (explode s))

  let rec fields f s = fields' (f, s, 0, 0)

  and fields' (f, s, i, j) =
    begin if j = size s then [ substring (s, i, j - i) ]
    else begin
      if f (sub (s, j)) then
        substring (s, i, j - i) :: fields' (f, s, j + 1, j + 1)
      else fields' (f, s, i, j + 1)
    end
    end

  let rec tokens f s =
    List.filter (function s -> Bool.not (s = "")) (fields f s)

  let rec isPrefix s1 s2 = isPrefix' (s1, s2, 0)

  and isPrefix' (s1, s2, i) =
    i = size s1
    || (i < size s2 && sub (s1, i) = sub (s2, i) && isPrefix' (s1, s2, i + 1))

  let rec isSuffix s1 s2 = isSuffix' (s1, s2, 0)

  and isSuffix' (s1, s2, i) =
    i = size s1
    || i < size s2
       && sub (s1, size s1 - i - 1) = sub (s2, size s2 - i - 1)
       && isSuffix' (s1, s2, i + 1)

  let rec isSubstring s1 s2 = isSubstring' (s1, s2, 0)

  and isSubstring' (s1, s2, i) =
    i + size s1 < size s2
    && (isSubstring'' (s1, s2, i, 0) || isSubstring' (s1, s2, i + 1))

  and isSubstring'' (s1, s2, i, j) =
    j = size s1
    || (sub (s1, i) = sub (s2, i + j) && isSubstring'' (s1, s2, i, j + 1))

  let rec collate f (s, t) = collate' (f, s, t, 0)

  and collate' (f, s, t, i) =
    begin match (i = size s, i = size t) with
    | true, true -> Equal
    | true, false -> Less
    | false, true -> Greater
    | false, false -> begin
        match f (sub (s, i), sub (t, i)) with
        | Equal -> collate' (f, s, t, i + 1)
        | other -> other
      end
    end

  let rec compare (a, b) = raise (General.Fail "TODO")
  let rec ( < ) a b = raise (General.Fail "TODO")
  let rec ( <= ) a b = raise (General.Fail "TODO")
  let rec ( > ) a b = raise (General.Fail "TODO")
  let rec ( >= ) a b = raise (General.Fail "TODO")
  let rec toString s = translate Char.toString s
  let rec toCString s = translate Char.toCString s
  let rec scan getc src = raise (General.Fail "TODO")
  let rec scanString f s = raise (General.Fail "TODO")
  let rec fromString s = raise (General.Fail "TODO")
end
(* 
  val fromCString : String.string -> string option
 *)
