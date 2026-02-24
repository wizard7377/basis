(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
  *);;
open General;;
module type OPTION = sig
                     type nonrec 'a option = 'a option
                     exception Option 
                     val getOpt : ('a option * 'a) -> 'a
                     val isSome : 'a option -> bool
                     val valOf : 'a option -> 'a
                     val filter : ('a -> bool) -> 'a -> 'a option
                     val join : 'a option option -> 'a option
                     val app : ('a -> unit) -> 'a option -> unit
                     val map : ('a -> 'b) -> 'a option -> 'b option
                     val
                       mapPartial : ('a -> 'b option) ->
                                    'a
                                    option ->
                                    'b
                                    option
                     val
                       compose : (('a -> 'b) * ('c -> 'a option)) ->
                                 'c ->
                                 'b
                                 option
                     val
                       composePartial : (('a -> 'b option) *
                                         ('c -> 'a option)) ->
                                        'c ->
                                        'b
                                        option
                     end;;
(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
  *);;
module Option = struct
                  type nonrec 'a option = 'a option;;
                  exception Option ;;
                  let rec getOpt =
                    function 
                             | (Some v, a) -> v
                             | (None, a) -> a;;
                  let rec isSome = function 
                                            | Some v -> true
                                            | None -> false;;
                  let rec valOf =
                    function 
                             | Some v -> v
                             | None -> raise Option;;
                  let rec filter f a = begin if f a then (Some a) else None
                    end;;
                  let rec join = function 
                                          | None -> None
                                          | Some v -> v;;
                  let rec app arg__0 arg__1 =
                    begin
                    match (arg__0, arg__1)
                    with 
                         | (f, None) -> ()
                         | (f, Some v) -> f v
                    end;;
                  let rec map arg__2 arg__3 =
                    begin
                    match (arg__2, arg__3)
                    with 
                         | (f, None) -> None
                         | (f, Some v) -> (Some (f v))
                    end;;
                  let rec mapPartial f x = join (map f x);;
                  let rec compose (f, g) x = map f (g x);;
                  let rec composePartial (f, g) x = mapPartial f (g x);;
                  end;;