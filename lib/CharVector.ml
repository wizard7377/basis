open! List
open! Option
open! Bool
open! String

(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *)
open General
open MONO_VECTOR_sig

module CharVector = struct
  type nonrec vector = string
  type nonrec elem = char

  let maxLen = String.maxSize
  let length = String.size
  let sub = String.sub
  let concat = String.concat
  let collate = String.collate
  let rec fromList l = raise (General.Fail "TODO")
  let rec tabulate (n, f) = fromList (List.tabulate (n, f))

  let rec update (vec, i, x) =
    tabulate
      (length vec, function j -> begin if j = i then x else sub (vec, i) end)

  let rec appi f vec = appi' (f, vec, 0)

  and appi' (f, vec, i) =
    begin if i = length vec then ()
    else begin
      f (i, sub (vec, i));
      appi' (f, vec, i + 1)
    end
    end

  let rec foldli f init vec = foldli' (f, init, vec, 0)

  and foldli' (f, x, vec, i) =
    begin if i = length vec then x
    else foldli' (f, f (i, sub (vec, i), x), vec, i + 1)
    end

  let rec foldri f init vec = foldri' (f, init, vec, length vec)

  and foldri' (f, x, vec, i) =
    begin if i = 0 then x
    else foldli' (f, f (i - 1, sub (vec, i - 1), x), vec, i - 1)
    end

  let rec mapi f vec =
    fromList (foldri (function i, x, l -> f (i, x) :: l) [] vec)

  let rec findi f vec = findi' (f, vec, 0)

  and findi' (f, vec, i) =
    begin if i = length vec then None
    else begin
      if f (i, sub (vec, i)) then Some (i, sub (vec, i))
      else findi' (f, vec, i + 1)
    end
    end

  let rec app f vec = appi (function _, a -> f a) vec
  let rec map f vec = mapi (function _, a -> f a) vec
  let rec foldl f init vec = foldli (function _, a, x -> f (a, x)) init vec
  let rec foldr f init vec = foldri (function _, a, x -> f (a, x)) init vec

  let rec find f vec =
    Option.map (function _, a -> a) (findi (function _, a -> f a) vec)

  let rec exists f vec = Option.isSome (find f vec)
  let rec all f vec = Bool.not (exists (fun x -> Bool.not (f x)) vec)
end
