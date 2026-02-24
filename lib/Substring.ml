(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note: Incomplete.
  *);;
open General;;
module type SUBSTRING = sig
                        type nonrec substring
                        type nonrec char
                        type nonrec string
                        val sub : (substring * int) -> char
                        val size : substring -> int
                        val base : substring -> string * int * int
                        val
                          extract : (string * int * int option) -> substring
                        val substring : (string * int * int) -> substring
                        val full : string -> substring
                        val string : substring -> string
                        val isEmpty : substring -> bool
                        val getc : substring -> (char * substring) option
                        val first : substring -> char option
                        val triml : int -> substring -> substring
                        val trimr : int -> substring -> substring
                        val
                          slice : (substring * int * int option) -> substring
                        val concat : substring list -> string
                        val concatWith : string -> substring list -> string
                        val explode : substring -> char list
                        val isPrefix : string -> substring -> bool
                        val isSubstring : string -> substring -> bool
                        val isSuffix : string -> substring -> bool
                        val compare : (substring * substring) -> order
                        val
                          collate : ((char * char) -> order) ->
                                    (substring * substring) ->
                                    order
                        val
                          splitl : (char -> bool) ->
                                   substring ->
                                   substring * substring
                        val
                          splitr : (char -> bool) ->
                                   substring ->
                                   substring * substring
                        val
                          splitAt : (substring * int) ->
                                    substring * substring
                        val dropl : (char -> bool) -> substring -> substring
                        val dropr : (char -> bool) -> substring -> substring
                        val takel : (char -> bool) -> substring -> substring
                        val taker : (char -> bool) -> substring -> substring
                        val
                          position : string ->
                                     substring ->
                                     substring * substring
                        val span : (substring * substring) -> substring
                        val
                          translate : (char -> string) -> substring -> string
                        val
                          tokens : (char -> bool) ->
                                   substring ->
                                   substring
                                   list
                        val
                          fields : (char -> bool) ->
                                   substring ->
                                   substring
                                   list
                        val app : (char -> unit) -> substring -> unit
                        val
                          foldl : ((char * 'a) -> 'a) ->
                                  'a ->
                                  substring ->
                                  'a
                        val
                          foldr : ((char * 'a) -> 'a) ->
                                  'a ->
                                  substring ->
                                  'a
                        end;;
open! List;;
open! Option;;
open! Bool;;
open! String;;
(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note: Incomplete.
  *);;
open Exceptions;;
module Substring = struct
                     type nonrec substring = string * int * int;;
                     type nonrec char = char;;
                     type nonrec string = string;;
                     let rec base ss = (ss : substring);;
                     let string x = String.substring (base x);;
                     let rec getSize ss = let (_, _, n) = base ss in n;;
                     let size = getSize;;
                     let rec sub ((s, i, n), j) = String.sub (s, i + j);;
                     let rec substring (s, i, j) =
                       try begin
                       if (i < 0) || ((j < 0) || ((String.size s) < (i + j)))
                       then raise Subscript else (s, i, j) end
                       with 
                            | Overflow -> raise Subscript;;
                     let rec extract =
                       function 
                                | (s, i, None)
                                    -> substring (s, i, (String.size s) - i)
                                | (s, i, Some j) -> substring (s, i, j);;
                     let rec full s = substring (s, 0, String.size s);;
                     let rec isEmpty (s, i, n) = n = 0;;
                     let rec getc =
                       function 
                                | (s, i, 0) -> None
                                | (s, i, n)
                                    -> (Some
                                        (String.sub (s, i),
                                         (s, i + 1, n - 1)));;
                     let first x =
                       Option.map (function 
                                            | (c, _) -> c) (getc x);;
                     let rec int_min_ (i, j) = begin if i < j then i else j
                       end;;
                     let rec int_max_ (i, j) = begin if i > j then i else j
                       end;;
                     let rec triml k (s, i, n) = begin
                       if k < 0 then raise Subscript else
                       (s, i + (int_min_ (k, n)), int_max_ (n - k, 0)) end;;
                     let rec trimr k (s, i, n) = begin
                       if k < 0 then raise Subscript else
                       (s, i, int_max_ (n - k, 0)) end;;
                     let rec slice =
                       function 
                                | (ss, i, Some m) -> slice' (ss, i, m)
                                | (ss, i, None)
                                    -> slice' (ss, i, (size ss) - i)
                     and slice' ((s, i, n), j, m) =
                       try begin
                       if (j + m) > n then raise Subscript else
                       substring (s, i + j, m) end
                       with 
                            | Overflow -> raise Subscript;;
                     let concat x = String.concat (List.map string x);;
                     let rec concatWith s x =
                       String.concatWith s (List.map string x);;
                     let rec explode ss = String.explode (string ss);;
                     let rec translate f ss =
                       String.concat (List.map f (explode ss));;
                     let rec isPrefix s ss = String.isPrefix s (string ss);;
                     let rec isSubstring s ss =
                       String.isSubstring s (string ss);;
                     let rec isSuffix s ss = String.isSuffix s (string ss);;
                     let rec compare (ss, st) =
                       String.compare (string ss, string st);;
                     let rec collate f (ss, st) =
                       String.collate f (string ss, string st);;
                     let rec splitAt ((s, i, n), j) = begin
                       if (j < 0) || (j > n) then raise Subscript else
                       ((s, i, j), (s, i + j, n - j)) end;;
                     let rec splitl f (s, i, n) = splitl' (f, s, i, n, i)
                     and splitl' (f, s, i, n, j) = begin
                       if j = (i + n) then ((s, i, n), (s, j, 0)) else begin
                       if f (String.sub (s, j)) then
                       splitl' (f, s, i, n, j + 1) else
                       ((s, i, j - i), (s, j, n - (j - i))) end end;;
                     let rec splitr f (s, i, n) =
                       splitr' (f, s, i, n, (i + n) - 1)
                     and splitr' (f, s, i, n, j) = begin
                       if j < i then ((s, i, 0), (s, i, n)) else begin
                       if f (String.sub (s, j)) then
                       splitr' (f, s, i, n, j - 1) else
                       ((s, i, (j - i) + 1), (s, j + 1, n - ((j - i) + 1)))
                       end end;;
                     let rec takel p ss = let (a, _) = splitl p ss in a;;
                     let rec dropl p ss = let (_, b) = splitl p ss in b;;
                     let rec taker p ss = let (_, b) = splitr p ss in b;;
                     let rec dropr p ss = let (a, _) = splitr p ss in a;;
                     let rec position s' (s, i, n) =
                       let (s, k, n') = position' s' (s, i, n)
                         in ((s, i, k - i), (s, k, n'))
                     and position' s' (s, i, n) = begin
                       if (String.size s') > n then (s, i + n, 0) else begin
                       if isPrefix s' (s, i, n) then (s, i, n) else
                       position' s' (triml 1 (s, i, n)) end end;;
                     let rec span ((s, i, n), (s', i', n')) = begin
                       if (Bool.not (s = s')) || ((i' + n') < i) then
                       raise Span else (s, i, (i' + n') - i) end;;
                     let rec fields f (s, i, n) = fields' (f, s, i, i, n)
                     and fields' (f, s, i, j, n) = begin
                       if j = (i + n) then [(s, i, j - i)] else begin
                       if f (String.sub (s, j)) then
                       ((s, i, j - i) :: fields' (f, s, j + 1, j + 1, n - 1))
                       else fields' (f, s, i, j + 1, n - 1) end end;;
                     let rec tokens f s =
                       List.filter
                       (function 
                                 | (s, i, n) -> Bool.not (n = 0))
                       (fields f s);;
                     let rec foldl f a ss = List.foldl f a (explode ss);;
                     let rec foldr f a ss = List.foldr f a (explode ss);;
                     let rec app f ss = List.app f (explode ss);;
                     end;;
type nonrec substring = Substring.substring;;