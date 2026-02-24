(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note: Incomplete.
  *);;
open General;;
module type STRING = sig
                     type nonrec string
                     type nonrec char
                     val maxSize : int
                     val size : string -> int
                     val sub : (string * int) -> char
                     val extract : (string * int * int option) -> string
                     val substring : (string * int * int) -> string
                     val ( ^ ) : string -> string -> string
                     val concat : string list -> string
                     val concatWith : string -> string list -> string
                     val str : char -> string
                     val implode : char list -> string
                     val explode : string -> char list
                     val map : (char -> char) -> string -> string
                     val translate : (char -> string) -> string -> string
                     val tokens : (char -> bool) -> string -> string list
                     val fields : (char -> bool) -> string -> string list
                     val isPrefix : string -> string -> bool
                     val isSubstring : string -> string -> bool
                     val isSuffix : string -> string -> bool
                     val compare : (string * string) -> order
                     val
                       collate : ((char * char) -> order) ->
                                 (string * string) ->
                                 order
                     val ( < ) : string -> string -> bool
                     val ( <= ) : string -> string -> bool
                     val ( > ) : string -> string -> bool
                     val ( >= ) : string -> string -> bool
                     val fromString : string -> string option
                     val toString : string -> string
                     (* 
  val fromCString : string -> string option
 *)
                     val toCString : string -> string
                     end;;