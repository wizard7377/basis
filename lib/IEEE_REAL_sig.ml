[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note: Incomplete.\n *)|}];;
module type IEEE_REAL = sig
                        exception Unordered 
                        type real_order =
                          | Less 
                          | Equal 
                          | Greater 
                          | Unordered 
                        type float_class =
                          | Nan 
                          | Inf 
                          | Zero 
                          | Normal 
                          | Subnormal 
                        type rounding_mode =
                          | To_nearest 
                          | To_neginf 
                          | To_posinf 
                          | To_zero 
                        end;;
[@@@sml.comment
  {|(*\n  val setRoundingMode : rounding_mode -> unit\n  val getRoundingMode : unit -> rounding_mode\n  type decimal_approx = {\n                          class : float_class,\n                          sign : bool,\n                          digits : int list,\n                          exp : int\n                        }\n  val toString : decimal_approx -> string\n  val scan : (char, 'a) StringCvt.reader -> (decimal_approx, 'a) StringCvt.reader\n  val fromString : string -> decimal_approx option\n*)|}];;