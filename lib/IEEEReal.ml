[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note: Incomplete.\n *)|}];;
exception Unordered ;;
type real_order = | Less 
                  | Equal 
                  | Greater 
                  | Unordered ;;
type rounding_mode = | To_nearest 
                     | To_neginf 
                     | To_posinf 
                     | To_zero ;;
type float_class = | Nan 
                   | Inf 
                   | Zero 
                   | Normal 
                   | Subnormal ;;

[@@@sml.comment
  {|(*\n  val setRoundingMode : rounding_mode -> unit\n  val getRoundingMode : unit -> rounding_mode\n  type decimal_approx =\n      {kind : float_class, sign : bool, digits : int list, exp : int}\n  val toString : decimal_approx -> string\n  val fromString : string -> decimal_approx option\n*)|}];;