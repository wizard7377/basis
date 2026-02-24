(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
  *);;
open General;;
module type LIST = sig
                   type nonrec 'a list = 'a list
                   exception Empty 
                   val null : 'a list -> bool
                   val length : 'a list -> int
                   val ( @ ) : 'a list -> 'a list -> 'a list
                   val hd : 'a list -> 'a
                   val tl : 'a list -> 'a list
                   val last : 'a list -> 'a
                   val getItem : 'a list -> ('a * 'a list) option
                   val nth : ('a list * int) -> 'a
                   val take : ('a list * int) -> 'a list
                   val drop : ('a list * int) -> 'a list
                   val rev : 'a list -> 'a list
                   val concat : 'a list list -> 'a list
                   val revAppend : ('a list * 'a list) -> 'a list
                   val app : ('a -> unit) -> 'a list -> unit
                   val map : ('a -> 'b) -> 'a list -> 'b list
                   val mapPartial : ('a -> 'b option) -> 'a list -> 'b list
                   val find : ('a -> bool) -> 'a list -> 'a option
                   val filter : ('a -> bool) -> 'a list -> 'a list
                   val
                     partition : ('a -> bool) -> 'a list -> 'a list * 'a list
                   val foldl : (('a * 'b) -> 'b) -> 'b -> 'a list -> 'b
                   val foldr : (('a * 'b) -> 'b) -> 'b -> 'a list -> 'b
                   val exists : ('a -> bool) -> 'a list -> bool
                   val all : ('a -> bool) -> 'a list -> bool
                   val tabulate : (int * (int -> 'a)) -> 'a list
                   val
                     collate : (('a * 'a) -> order) ->
                               ('a list * 'a list) ->
                               order
                   end;;
open! Bool;;
(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
  *);;
open Exceptions;;
module List = struct
                exception Empty = Empty;;
                let rec null = function 
                                        | [] -> true
                                        | _ -> false;;
                let rec length =
                  function 
                           | [] -> 0
                           | (x :: l') -> 1 + (length l');;
                let rec hd = function 
                                      | (x :: l') -> x
                                      | _ -> raise Empty;;
                let rec tl = function 
                                      | (x :: l') -> l'
                                      | _ -> raise Empty;;
                let rec last =
                  function 
                           | (x :: []) -> x
                           | (x :: l') -> last l'
                           | [] -> raise Empty;;
                let rec getItem =
                  function 
                           | (x :: l') -> (Some (x, l'))
                           | [] -> None;;
                let rec nth =
                  function 
                           | ((x :: l'), 0) -> x
                           | ((x :: l'), i) -> nth (l', i - 1)
                           | ([], i) -> raise Subscript;;
                let rec rev l = rev' (l, [])
                and rev' =
                  function 
                           | ([], xs) -> xs
                           | ((x :: l'), xs) -> rev' (l', (x :: xs));;
                let rec append =
                  function 
                           | ([], l2) -> l2
                           | ((x :: l1'), l2) -> (x :: append (l1', l2));;
                let rec revAppend =
                  function 
                           | ([], l2) -> l2
                           | ((x :: l1'), l2) -> revAppend (l1', (x :: l2));;
                let rec concat =
                  function 
                           | [] -> []
                           | (xs :: l') -> append (xs, concat l');;
                let rec take =
                  function 
                           | (l, 0) -> []
                           | ((x :: l'), i) -> (x :: take (l', i - 1))
                           | ([], i) -> raise Subscript;;
                let rec drop =
                  function 
                           | (l, 0) -> l
                           | ((x :: l'), i) -> drop (l', i - 1)
                           | ([], i) -> raise Subscript;;
                let rec app arg__0 arg__1 =
                  begin
                  match (arg__0, arg__1)
                  with 
                       | (f, []) -> ()
                       | (f, (x :: l')) -> begin
                                             f x;app f l'
                                             end
                  end;;
                let rec map arg__2 arg__3 =
                  begin
                  match (arg__2, arg__3)
                  with 
                       | (f, []) -> []
                       | (f, (x :: l')) -> (f x :: map f l')
                  end;;
                let rec mapPartial arg__4 arg__5 =
                  begin
                  match (arg__4, arg__5)
                  with 
                       | (f, []) -> []
                       | (f, (x :: l'))
                           -> begin
                              match f x
                              with 
                                   | None -> mapPartial f l'
                                   | Some y -> (y :: mapPartial f l')
                              end
                  end;;
                let rec find arg__6 arg__7 =
                  begin
                  match (arg__6, arg__7)
                  with 
                       | (f, []) -> None
                       | (f, (x :: l')) -> begin
                           if f x then (Some x) else find f l' end
                  end;;
                let rec filter arg__8 arg__9 =
                  begin
                  match (arg__8, arg__9)
                  with 
                       | (f, []) -> []
                       | (f, (x :: l')) -> begin
                           if f x then (x :: filter f l') else filter f l'
                           end
                  end;;
                let rec partition arg__10 arg__11 =
                  begin
                  match (arg__10, arg__11)
                  with 
                       | (f, []) -> ([], [])
                       | (f, (x :: l'))
                           -> let (l1, l2) = partition f l' in begin
                                if f x then ((x :: l1), l2) else
                                (l1, (x :: l2)) end
                  end;;
                let rec foldl arg__12 arg__13 arg__14 =
                  begin
                  match (arg__12, arg__13, arg__14)
                  with 
                       | (f, b, []) -> b
                       | (f, b, (x :: l')) -> foldl f (f (x, b)) l'
                  end;;
                let rec foldr arg__15 arg__16 arg__17 =
                  begin
                  match (arg__15, arg__16, arg__17)
                  with 
                       | (f, b, []) -> b
                       | (f, b, (x :: l')) -> f (x, foldr f b l')
                  end;;
                let rec exists arg__18 arg__19 =
                  begin
                  match (arg__18, arg__19)
                  with 
                       | (f, []) -> false
                       | (f, (x :: l')) -> (f x) || (exists f l')
                  end;;
                let rec all f l =
                  Bool.not (exists (fun x -> Bool.not (f x)) l);;
                let rec tabulate (n, f) = begin
                  if n < 0 then raise Size else tabulate' (n, f, 0, []) end
                and tabulate' (n, f, i, l) = begin
                  if i = n then rev l else
                  tabulate' (n, f, i + 1, (f i :: l)) end;;
                let rec collate arg__20 arg__21 =
                  begin
                  match (arg__20, arg__21)
                  with 
                       | (f, ([], [])) -> Equal
                       | (f, ([], l2)) -> Less
                       | (f, (l1, [])) -> Greater
                       | (f, ((x1 :: l1'), (x2 :: l2')))
                           -> begin
                              match f (x1, x2)
                              with 
                                   | Equal -> collate f (l1', l2')
                                   | other -> other
                              end
                  end;;
                end;;