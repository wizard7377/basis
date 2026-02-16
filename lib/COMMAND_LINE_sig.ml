[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2013-2025\n *\n * Standard ML Basis Library\n *)|}];;
module type COMMAND_LINE = sig
                           val name : (unit -> string)
                           val arguments : (unit -> string list)
                           end;;