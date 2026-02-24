open! List;;
open! Option;;
open! Bool;;
(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
  *);;
open General;;
open VECTOR_sig;;
module Vector = struct
                  type nonrec 'a vector = 'a array;;
                  let maxLen : int = 0;;
                  let rec length x = raise ((General.Fail "TODO"));;
                  let rec sub x = raise ((General.Fail "TODO"));;
                  let rec fromList x = raise ((General.Fail "TODO"));;
                  let rec tabulate (n, f) = fromList (List.tabulate (n, f));;
                  let rec update (vec, i, x) =
                    tabulate
                    (length vec,
                     function 
                              | i' -> begin
                                  if i = i' then x else sub (vec, i') end);;
                  let rec foldli f init vec = foldli' (f, init, vec, 0)
                  and foldli' (f, x, vec, i) = begin
                    if i = (length vec) then x else
                    foldli' (f, f (i, sub (vec, i), x), vec, i + 1) end;;
                  let rec foldri f init vec =
                    foldri' (f, init, vec, length vec)
                  and foldri' (f, x, vec, i) = begin
                    if i = 0 then x else
                    foldri' (f, f (i - 1, sub (vec, i - 1), x), vec, i - 1)
                    end;;
                  let rec foldl f init vec =
                    foldli (function 
                                     | (_, a, x) -> f (a, x)) init vec;;
                  let rec foldr f init vec =
                    foldri (function 
                                     | (_, a, x) -> f (a, x)) init vec;;
                  let rec appi f vec =
                    List.app
                    f
                    (foldri (function 
                                      | (i, a, l) -> ((i, a) :: l)) [] vec);;
                  let rec app f vec =
                    List.app f (foldr (function 
                                                | (a, l) -> (a :: l)) [] vec);;
                  let rec mapi f vec =
                    fromList
                    (List.map
                     f
                     (foldri (function 
                                       | (i, a, l) -> ((i, a) :: l)) [] vec));;
                  let rec map f vec =
                    fromList
                    (List.map
                     f
                     (foldr (function 
                                      | (a, l) -> (a :: l)) [] vec));;
                  let rec findi f vec = findi' (f, vec, 0)
                  and findi' (f, vec, i) = begin
                    if i = (length vec) then None else begin
                    if f (i, sub (vec, i)) then (Some (i, sub (vec, i))) else
                    findi' (f, vec, i + 1) end end;;
                  let rec find f vec =
                    Option.map
                    (fun (_, r) -> r)
                    (findi (fun x -> f ((fun (_, r) -> r) x)) vec);;
                  let rec exists f vec = Option.isSome (find f vec);;
                  let rec all f vec =
                    Bool.not (exists (fun x -> Bool.not (f x)) vec);;
                  let rec collate f (vec1, vec2) =
                    collate' (f, vec1, vec2, 0)
                  and collate' (f, vec1, vec2, i) =
                    begin
                    match (i = (length vec1), i = (length vec2))
                    with 
                         | (true, true) -> Equal
                         | (true, false) -> Less
                         | (false, true) -> Greater
                         | (false, false)
                             -> begin
                                match f (sub (vec1, i), sub (vec2, i))
                                with 
                                     | Equal
                                         -> collate' (f, vec1, vec2, i + 1)
                                     | other -> other
                                end
                    end;;
                  let rec concat l =
                    fromList
                    (List.concat
                     (List.map (foldr (function 
                                                | (a, l) -> (a :: l)) []) l));;
                  end;;
type nonrec 'a vector = 'a Vector.vector;;