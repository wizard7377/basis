[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2013-2025\n *\n * Standard ML Basis Library\n *)|}];;
let name = ((use { b = "CommandLine.name"} ) : (unit -> string));;
let arguments =
  ((use { b = "CommandLine.arguments"} ) : (unit -> string list));;
