[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note: Incomplete.\n *)|}];;
module type OS = sig
                 module FileSys : sig
                   val chDir : (string -> unit)
                   val getDir : (unit -> string)
                   val mkDir : (string -> unit)
                   val rmDir : (string -> unit)
                   val isDir : (string -> bool)
                 end
                 module Path : sig
                   exception Path
                   exception InvalidArc
                   val parentArc : string
                   val currentArc : string
                 end
                 module Process : sig
                   type nonrec status
                   val success : status
                   val failure : status
                   val isSuccess : (status -> bool)
                   val exit : (status -> 'a)
                   val terminate : (status -> 'a)
                 end
                 [@@@sml.comment {|(*\n  structure IO : OS_IO\n*)|}]
                 type nonrec syserror
                 exception SysErr of (string * syserror option) 
                 end;;
[@@@sml.comment
  {|(*\n  val errorMsg : syserror -> string\n  val errorName : syserror -> string\n  val syserror : string -> syserror option\n*)|}];;