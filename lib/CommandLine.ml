(* 
 * (c) Andreas Rossberg 2013-2025
 *
 * Standard ML Basis Library
  *);;
open General;;
open Exceptions;;
open COMMAND_LINE_sig;;
module CommandLine : COMMAND_LINE =
  struct
    let name : unit -> string =
      function 
               | () -> raise ((General.Fail "TODO: CommandLine.name"));;
    let arguments : unit -> string list =
      function 
               | () -> raise ((General.Fail "TODO: CommandLine.arguments"));;
    end;;