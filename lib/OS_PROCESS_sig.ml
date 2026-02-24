(* 
 * (c) Andreas Rossberg 2013-2025
 *
 * Standard ML Basis Library
  *);;
open General;;
module type OS_PROCESS = sig
                         type nonrec status
                         val success : status
                         val failure : status
                         val isSuccess : status -> bool
                         (* 
  val system : string -> status
  val atExit : (unit -> unit) -> unit
 *)
                         val exit : status -> 'a
                         val terminate : status -> 'a
                         end;;
(* 
  val getEnv : string -> string option
  val sleep : Time.time -> unit
 *);;