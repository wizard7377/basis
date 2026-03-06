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
    | () -> Stdlib.Array.get Sys.argv 0

  let arguments : unit -> string list = function
    | () -> Stdlib.List.tl (Stdlib.Array.to_list Sys.argv)
end
