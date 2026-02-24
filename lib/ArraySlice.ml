(* 
 * (c) Andreas Rossberg 2002-2025
 *
 * Standard ML Basis Library
  *);;
open General;;
module type ARRAY_SLICE = sig
                          type nonrec 'a slice
                          val length : 'a slice -> int
                          val sub : ('a slice * int) -> 'a
                          val update : ('a slice * int * 'a) -> unit
                          val
                            slice : ('a Array.array * int * int option) ->
                                    'a
                                    slice
                          val full : 'a Array.array -> 'a slice
                          val
                            subslice : ('a slice * int * int option) ->
                                       'a
                                       slice
                          val base : 'a slice -> 'a Array.array * int * int
                          val vector : 'a slice -> 'a Vector.vector
                          type nonrec 'a __0 = { src: 'a slice ;
                            dst: 'a Array.array ; di: int }
                          val copy : 'a __0 -> unit
                          type nonrec 'a __1 = { src: 'a VectorSlice.slice ;
                            dst: 'a Array.array ; di: int }
                          val copyVec : 'a __1 -> unit
                          val isEmpty : 'a slice -> bool
                          val getItem : 'a slice -> ('a * 'a slice) option
                          val appi : ((int * 'a) -> unit) -> 'a slice -> unit
                          val app : ('a -> unit) -> 'a slice -> unit
                          val
                            modifyi : ((int * 'a) -> 'a) -> 'a slice -> unit
                          val modify : ('a -> 'a) -> 'a slice -> unit
                          val
                            foldli : ((int * 'a * 'b) -> 'b) ->
                                     'b ->
                                     'a
                                     slice ->
                                     'b
                          val
                            foldri : ((int * 'a * 'b) -> 'b) ->
                                     'b ->
                                     'a
                                     slice ->
                                     'b
                          val
                            foldl : (('a * 'b) -> 'b) -> 'b -> 'a slice -> 'b
                          val
                            foldr : (('a * 'b) -> 'b) -> 'b -> 'a slice -> 'b
                          val
                            findi : ((int * 'a) -> bool) ->
                                    'a
                                    slice ->
                                    (int * 'a)
                                    option
                          val find : ('a -> bool) -> 'a slice -> 'a option
                          val exists : ('a -> bool) -> 'a slice -> bool
                          val all : ('a -> bool) -> 'a slice -> bool
                          val
                            collate : (('a * 'a) -> order) ->
                                      ('a slice * 'a slice) ->
                                      order
                          end;;
open! Option;;
open! Vector;;
open! Bool;;
open! Array;;
(* 
 * (c) Andreas Rossberg 2002-2025
 *
 * Standard ML Basis Library
  *);;
open Exceptions;;
module ArraySlice = struct
                      type nonrec 'a slice = 'a Array.array * int * int;;
                      let rec base sl = (sl : 'a slice);;
                      let rec length (a, i, n) = n;;
                      let rec isEmpty sl = (length sl) = 0;;
                      let rec sub ((a, i, n), j) = begin
                        if (j < 0) || (n <= j) then raise Subscript else
                        Array.sub (a, i + j) end;;
                      let rec update ((a, i, n), j, x) = begin
                        if (j < 0) || (n <= j) then raise Subscript else
                        Array.update (a, i + j, x) end;;
                      let rec subslice =
                        function 
                                 | (sl, i, None)
                                     -> subslice
                                        (sl, i, (Some ((length sl) - i)))
                                 | ((a, s, n_), i, Some n)
                                     -> try begin
                                        if
                                        (i < 0) ||
                                          ((n < 0) || (n_ < (i + n)))
                                        then raise Subscript else
                                        (a, s + i, n) end
                                        with 
                                             | Overflow -> raise Subscript;;
                      let rec full arr = (arr, 0, Array.length arr);;
                      let rec slice (arr, i, sz) = subslice (full arr, i, sz);;
                      let rec vector sl =
                        Vector.tabulate
                        (length sl, function 
                                             | i -> sub (sl, i));;
                      let rec getItem sl = begin
                        if isEmpty sl then None else
                        (Some (sub (sl, 0), subslice (sl, 1, None))) end;;
                      let rec appi f sl = appi' (f, sl, 0)
                      and appi' (f, sl, i) = begin
                        if i = (length sl) then () else
                        begin
                          f (i, sub (sl, i));appi' (f, sl, i + 1)
                          end
                        end;;
                      let rec modifyi f sl = modifyi' (f, sl, 0)
                      and modifyi' (f, sl, i) = begin
                        if i = (length sl) then () else
                        begin
                          update (sl, i, f (i, sub (sl, i)));
                          modifyi' (f, sl, i + 1)
                          end
                        end;;
                      let rec foldli f init sl = foldli' (f, init, sl, 0)
                      and foldli' (f, x, sl, i) = begin
                        if i = (length sl) then x else
                        foldli' (f, f (i, sub (sl, i), x), sl, i + 1) end;;
                      let rec foldri f init sl =
                        foldri' (f, init, sl, length sl)
                      and foldri' (f, x, sl, i) = begin
                        if i = 0 then x else
                        foldri' (f, f (i - 1, sub (sl, i - 1), x), sl, i - 1)
                        end;;
                      let rec findi f sl = findi' (f, sl, 0)
                      and findi' (f, sl, i) = begin
                        if i = (length sl) then None else begin
                        if f (i, sub (sl, i)) then (Some (i, sub (sl, i)))
                        else findi' (f, sl, i + 1) end end;;
                      let rec app f sl = appi (function 
                                                        | (_, a) -> f a) sl;;
                      let rec modify f sl =
                        modifyi (function 
                                          | (_, a) -> f a) sl;;
                      let rec foldl f init sl =
                        foldli (function 
                                         | (_, a, x) -> f (a, x)) init sl;;
                      let rec foldr f init sl =
                        foldri (function 
                                         | (_, a, x) -> f (a, x)) init sl;;
                      let rec find f sl =
                        Option.map
                        (function 
                                  | (_, a) -> a)
                        (findi (function 
                                         | (_, a) -> f a) sl);;
                      let rec exists f sl = Option.isSome (find f sl);;
                      let rec all f sl =
                        Bool.not (exists (fun x -> Bool.not (f x)) sl);;
                      let rec collate arg__0 arg__1 =
                        begin
                        match (arg__0, arg__1)
                        with 
                             | (f, ((a1, i1, 0), (a2, i2, 0))) -> Equal
                             | (f, ((a1, i1, 0), (a2, i2, n2))) -> Less
                             | (f, ((a1, i1, n1), (a2, i2, 0))) -> Greater
                             | (f, ((a1, i1, n1), (a2, i2, n2)))
                                 -> begin
                                    match f
                                          (Array.sub (a1, i1),
                                           Array.sub (a2, i2))
                                    with 
                                         | Equal
                                             -> collate
                                                f
                                                ((a1, i1 + 1, n1 - 1),
                                                 (a2, i2 + 1, n2 - 1))
                                         | other -> other
                                    end
                        end;;
                      let rec copy x = raise ((Fail "TODO"));;
                      let rec copyVec x = raise ((Fail "TODO"));;
                      end;;