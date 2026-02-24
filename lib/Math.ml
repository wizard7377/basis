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

  let e : real = raise (General.Fail "TODO: Math.e")
  let pi : real = raise (General.Fail "TODO: Math.pi")
  let sqrt : real -> real = raise (General.Fail "TODO: Math.sqrt")
  let sin : real -> real = raise (General.Fail "TODO: Math.sin")
  let cos : real -> real = raise (General.Fail "TODO: Math.cos")
  let tan : real -> real = raise (General.Fail "TODO: Math.tan")
  let asin : real -> real = raise (General.Fail "TODO: Math.asin")
  let acos : real -> real = raise (General.Fail "TODO: Math.acos")
  let atan : real -> real = raise (General.Fail "TODO: Math.atan")
  let atan2 : real * real -> real = raise (General.Fail "TODO: Math.atan2")
  let exp : real -> real = raise (General.Fail "TODO: Math.exp")
  let pow : real * real -> real = raise (General.Fail "TODO: Math.pow")
  let ln : real -> real = raise (General.Fail "TODO: Math.ln")
  let log10 : real -> real = raise (General.Fail "TODO: Math.log10")
  let sinh : real -> real = raise (General.Fail "TODO: Math.sinh")
  let cosh : real -> real = raise (General.Fail "TODO: Math.cosh")
  let tanh : real -> real = raise (General.Fail "TODO: Math.tanh")
end
