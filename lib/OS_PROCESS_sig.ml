[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2013-2025\n *\n * Standard ML Basis Library\n *)|}];;
module type OS_PROCESS = sig
                         type nonrec status
                         val success : status
                         val failure : status
                         val isSuccess : (status -> bool)
                         [@@@sml.comment
                           {|(*\n  val system : string -> status\n  val atExit : (unit -> unit) -> unit\n*)|}]
                         val exit : (status -> 'a)
                         val terminate : (status -> 'a)
                         end;;
[@@@sml.comment
  {|(*\n  val getEnv : string -> string option\n  val sleep : Time.time -> unit\n*)|}];;