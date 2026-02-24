(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note: Incomplete.
  *);;
open General;;
open IEEE_REAL_sig;;
module IEEEReal = struct
                    exception Unordered ;;
                    type real_order = | Less 
                                      | Equal 
                                      | Greater 
                                      | Unordered ;;
                    type rounding_mode =
                      | To_nearest 
                      | To_neginf 
                      | To_posinf 
                      | To_zero ;;
                    type float_class =
                      | Nan 
                      | Inf 
                      | Zero 
                      | Normal 
                      | Subnormal ;;
                    end;;
(* 
  val setRoundingMode : rounding_mode -> unit
  val getRoundingMode : unit -> rounding_mode
  type decimal_approx =
      {kind : float_class, sign : bool, digits : int list, exp : int}
  val toString : decimal_approx -> string
  val fromString : string -> decimal_approx option
 *);;