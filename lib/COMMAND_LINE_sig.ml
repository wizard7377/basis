(* 
 * (c) Andreas Rossberg 2013-2025
 *
 * Standard ML Basis Library
  *);;
open General;;
module type COMMAND_LINE = sig
                           val name : unit -> string
                           val arguments : unit -> string list
                           end;;