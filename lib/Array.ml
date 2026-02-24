open! List;;
open! Option;;
open! Vector;;
open! Bool;;
(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note:
 * - We must keep the array type transparent in order to keep its
 *   special equality property.
  *);;
open General;;
open Exceptions;;
open ARRAY_sig;;
module Array : ARRAY =
  struct
    type nonrec 'a array = 'a ref vector ref;;
    type nonrec 'a vector = 'a vector;;
    let maxLen = Vector.maxLen;;
    let rec array (n, init) =
      ref (Vector.tabulate (n, function 
                                        | _ -> ref init));;
    let rec fromList l = ref (Vector.fromList (List.map ref l));;
    let rec tabulate (n, f) = ref (Vector.tabulate (n, fun x -> ref (f x)));;
    let rec length arr = Vector.length (! arr);;
    let rec sub (arr, i) = ! (Vector.sub (! arr, i));;
    let rec update (arr, i, x) = (Vector.sub (! arr, i)) := x;;
    let rec vector arr = Vector.map ( ! ) (! arr);;
    let rec deref2 (i, r) = (i, ! r);;
    let rec deref3 (i, r, x) = (i, ! r, x);;
    let rec appi f arr = Vector.appi (fun x -> f (deref2 x)) (! arr);;
    let rec modifyi f arr =
      Vector.appi (function 
                            | (i, r) -> r := (f (i, ! r))) (! arr);;
    let rec foldli f init arr =
      Vector.foldli (fun x -> f (deref3 x)) init (! arr);;
    let rec foldri f init arr =
      Vector.foldri (fun x -> f (deref3 x)) init (! arr);;
    let rec findi f arr =
      Option.map deref2 (Vector.findi (fun x -> f (deref2 x)) (! arr));;
    let rec app f = appi (fun x -> f ((fun (_, r) -> r) x));;
    let rec modify f = modifyi (fun x -> f ((fun (_, r) -> r) x));;
    let rec foldl f = foldli (function 
                                       | (_, a, x) -> f (a, x));;
    let rec foldr f = foldri (function 
                                       | (_, a, x) -> f (a, x));;
    let rec find f arr =
      Option.map
      (fun (_, r) -> r)
      (findi (fun x -> f ((fun (_, r) -> r) x)) arr);;
    let rec exists f arr = Option.isSome (find f arr);;
    let rec all f arr = Bool.not (exists (fun x -> Bool.not (f x)) arr);;
    let rec collate f (a1, a2) = collate' (f, a1, a2, 0)
    and collate' (f, a1, a2, i) =
      begin
      match (i = (length a1), i = (length a2))
      with 
           | (true, true) -> Equal
           | (true, false) -> Less
           | (false, true) -> Greater
           | (false, false)
               -> begin
                  match f (sub (a1, i), sub (a2, i))
                  with 
                       | Equal -> collate' (f, a1, a2, i + 1)
                       | other -> other
                  end
      end;;
    let rec copy x = raise ((Fail "TODO"));;
    let rec copyVec x = raise ((Fail "TODO"));;
    end;;
type nonrec 'a array = 'a Array.array;;