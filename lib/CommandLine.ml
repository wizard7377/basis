(*
 * (c) Andreas Rossberg 2013-2025
 *
 * Standard ML Basis Library
 *)
open General

module type COMMAND_LINE = sig
  val name : unit -> string
  val arguments : unit -> string list
end

(*
 * (c) Andreas Rossberg 2013-2025
 *
 * Standard ML Basis Library
 *)
open Exceptions

module CommandLine : COMMAND_LINE = struct
  let name : unit -> string = function
    | () -> raise (General.Fail "TODO: CommandLine.name")

  let arguments : unit -> string list = function
    | () -> raise (General.Fail "TODO: CommandLine.arguments")
end
