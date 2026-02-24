(*
 * (c) Andreas Rossberg 2002-2025
 *
 * Standard ML Basis Library
 *)
open General

module type VECTOR_SLICE = sig
  type nonrec 'a slice

  val length : 'a slice -> int
  val sub : 'a slice * int -> 'a
  val full : 'a Vector.vector -> 'a slice
  val slice : 'a Vector.vector * int * int option -> 'a slice
  val subslice : 'a slice * int * int option -> 'a slice
  val base : 'a slice -> 'a Vector.vector * int * int
  val vector : 'a slice -> 'a Vector.vector
  val concat : 'a slice list -> 'a Vector.vector
  val isEmpty : 'a slice -> bool
  val getItem : 'a slice -> ('a * 'a slice) option
  val appi : (int * 'a -> unit) -> 'a slice -> unit
  val app : ('a -> unit) -> 'a slice -> unit
  val mapi : (int * 'a -> 'b) -> 'a slice -> 'b Vector.vector
  val map : ('a -> 'b) -> 'a slice -> 'b Vector.vector
  val foldli : (int * 'a * 'b -> 'b) -> 'b -> 'a slice -> 'b
  val foldri : (int * 'a * 'b -> 'b) -> 'b -> 'a slice -> 'b
  val foldl : ('a * 'b -> 'b) -> 'b -> 'a slice -> 'b
  val foldr : ('a * 'b -> 'b) -> 'b -> 'a slice -> 'b
  val findi : (int * 'a -> bool) -> 'a slice -> (int * 'a) option
  val find : ('a -> bool) -> 'a slice -> 'a option
  val exists : ('a -> bool) -> 'a slice -> bool
  val all : ('a -> bool) -> 'a slice -> bool
  val collate : ('a * 'a -> order) -> 'a slice * 'a slice -> order
end

open! List
open! Option
open! Vector
open! Bool

(*
 * (c) Andreas Rossberg 2002-2025
 *
 * Standard ML Basis Library
 *)
open Exceptions

module VectorSlice = struct
  type nonrec 'a slice = 'a Vector.vector * int * int

  let rec base sl = (sl : 'a slice)
  let rec length (v, i, n) = n
  let rec isEmpty sl = length sl = 0

  let rec sub ((v, i, n), j) =
    begin if j < 0 || n <= j then raise Subscript else Vector.sub (v, i + j)
    end

  let rec subslice = function
    | sl, i, None -> subslice (sl, i, Some (length sl - i))
    | (v, s, n_), i, Some n -> (
        try
          begin if i < 0 || n < 0 || n_ < i + n then raise Subscript
          else (v, s + i, n)
          end
        with Overflow -> raise Subscript)

  let rec full v = (v, 0, Vector.length v)
  let rec slice (v, i, sz) = subslice (full v, i, sz)
  let rec vector sl = Vector.tabulate (length sl, function i -> sub (sl, i))
  let rec concat l = Vector.concat (List.map vector l)

  let rec getItem sl =
    begin if isEmpty sl then None else Some (sub (sl, 0), subslice (sl, 1, None))
    end

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
    let rec ff (i, a, l) = f (i, a) :: l in
    Vector.fromList (List.rev (foldli ff [] sl))

  let rec findi f sl = findi' (f, sl, 0)

  and findi' (f, sl, i) =
    begin if i = length sl then None
    else begin
      if f (i, sub (sl, i)) then Some (i, sub (sl, i)) else findi' (f, sl, i + 1)
    end
    end

  let rec app f sl = appi (function _, a -> f a) sl
  let rec map f sl = mapi (function _, a -> f a) sl
  let rec foldl f init sl = foldli (function _, a, x -> f (a, x)) init sl
  let rec foldr f init sl = foldri (function _, a, x -> f (a, x)) init sl

  let rec find f sl =
    Option.map (function _, a -> a) (findi (function _, a -> f a) sl)

  let rec exists f sl = Option.isSome (find f sl)
  let rec all f sl = Bool.not (exists (fun x -> Bool.not (f x)) sl)

  let rec collate arg__0 arg__1 =
    begin match (arg__0, arg__1) with
    | f, ((v1, i1, 0), (v2, i2, 0)) -> Equal
    | f, ((v1, i1, 0), (v2, i2, n2)) -> Less
    | f, ((v1, i1, n1), (v2, i2, 0)) -> Greater
    | f, ((v1, i1, n1), (v2, i2, n2)) -> begin
        match f (Vector.sub (v1, i1), Vector.sub (v2, i2)) with
        | Equal -> collate f ((v1, i1 + 1, n1 - 1), (v2, i2 + 1, n2 - 1))
        | other -> other
      end
    end
end
