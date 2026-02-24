open! Option
open! CharVector
open! Bool
open! Substring

(*
 * (c) Andreas Rossberg 2002-2025
 *
 * Standard ML Basis Library
 *)
open General
open MONO_VECTOR_SLICE_sig

module CharVectorSlice = struct
  type nonrec elem = char
  type nonrec vector = string
  type nonrec slice = Substring.substring

  let base = Substring.base
  let length = Substring.size
  let isEmpty = Substring.isEmpty
  let sub = Substring.sub
  let full = Substring.full
  let slice = Substring.extract
  let subslice = Substring.slice
  let vector = Substring.string
  let concat = Substring.concat
  let getItem = Substring.getc
  let collate = Substring.collate

  let rec appi f sl = appi' (f, sl, 0)

  and appi' (f, sl, i) =
    begin if i = length sl then ()
    else begin
      f (i, sub (sl, i));
      appi' (f, sl, i + 1)
    end
    end

  let rec foldli f init sl = foldli' (f, init, sl, 0)

  and foldli' (f, x, sl, i) =
    begin if i = length sl then x
    else foldli' (f, f (i, sub (sl, i), x), sl, i + 1)
    end

  let rec foldri f init sl = foldri' (f, init, sl, length sl)

  and foldri' (f, x, sl, i) =
    begin if i = 0 then x
    else foldli' (f, f (i - 1, sub (sl, i - 1), x), sl, i - 1)
    end

  let rec mapi f sl =
    CharVector.fromList (foldri (function i, a, l -> f (i, a) :: l) [] sl)

  let rec findi f sl = findi' (f, sl, 0)

  and findi' (f, sl, i) =
    begin if i = length sl then None
    else begin
      if f (i, sub (sl, i)) then Some (i, sub (sl, i)) else findi' (f, sl, i + 1)
    end
    end

  let rec app f sl = appi (fun x -> f ((fun (_, r) -> r) x)) sl
  let rec map f sl = mapi (fun x -> f ((fun (_, r) -> r) x)) sl
  let rec foldl f init sl = foldli (function _, a, x -> f (a, x)) init sl
  let rec foldr f init sl = foldri (function _, a, x -> f (a, x)) init sl

  let rec find f sl =
    Option.map (fun (_, r) -> r) (findi (fun x -> f ((fun (_, r) -> r) x)) sl)

  let rec exists f sl = Option.isSome (find f sl)
  let rec all f sl = Bool.not (exists (fun x -> Bool.not (f x)) sl)
end
