(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *)
open General

module type MATH = sig
  type nonrec real

  val pi : real
  val e : real
  val sqrt : real -> real
  val sin : real -> real
  val cos : real -> real
  val tan : real -> real
  val asin : real -> real
  val acos : real -> real
  val atan : real -> real
  val atan2 : real * real -> real
  val exp : real -> real
  val pow : real * real -> real
  val ln : real -> real
  val log10 : real -> real
  val sinh : real -> real
  val cosh : real -> real
  val tanh : real -> real
end

(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *)
open Exceptions
open Types

module Math = struct
  type nonrec real = real

  let e : real = Float.exp 1.0
  let pi : real = Float.pi
  let sqrt : real -> real = fun x -> Float.sqrt x
  let sin : real -> real = fun x -> Float.sin x
  let cos : real -> real = fun x -> Float.cos x
  let tan : real -> real = fun x -> Float.tan x
  let asin : real -> real = fun x -> Float.asin x
  let acos : real -> real = fun x -> Float.acos x
  let atan : real -> real = fun x -> Float.atan x
  let atan2 : real * real -> real = fun (y, x) -> Float.atan2 y x
  let exp : real -> real = fun x -> Float.exp x
  let pow : real * real -> real = fun (x, y) -> Float.pow x y
  let ln : real -> real = fun x -> Float.log x
  let log10 : real -> real = fun x -> Float.log10 x
  let sinh : real -> real = fun x -> Float.sinh x
  let cosh : real -> real = fun x -> Float.cosh x
  let tanh : real -> real = fun x -> Float.tanh x
end
