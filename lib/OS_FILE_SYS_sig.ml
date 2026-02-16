[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note: Incomplete.\n *)|}];;
module type OS_FILE_SYS = sig
                          [@@@sml.comment
                            {|(*\n  type dirstream\n  val openDir : string -> dirstream\n  val readDir : dirstream -> string option\n  val rewindDir : dirstream -> unit\n  val closeDir : dirstream -> unit\n*)|}]
                          val chDir : (string -> unit)
                          val getDir : (unit -> string)
                          val mkDir : (string -> unit)
                          val rmDir : (string -> unit)
                          val isDir : (string -> bool)
                          end;;
[@@@sml.comment
  {|(*\n  val isLink : string -> bool\n  val readLink : string -> string\n  val fullPath : string -> string\n  val realPath : string -> string\n  val modTime : string -> Time.time\n  val fileSize : string -> Position.int\n  val setTime : string * Time.time option -> unit\n  val remove : string -> unit\n  val rename : {old : string, new : string} -> unit\n  datatype access_mode = A_READ | A_WRITE | A_EXEC\n  val access : string * access_mode list -> bool\n  val tmpName : unit -> string\n  eqtype file_id\n  val fileId : string -> file_id\n  val hash : file_id -> word\n  val compare : file_id * file_id -> order\n*)|}];;