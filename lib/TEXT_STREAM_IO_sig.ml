[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note: Incomplete.\n *)|}];;
module type TEXT_STREAM_IO = sig type nonrec elem type nonrec vector end;;
[@@@sml.comment
  {|(*\n  val inputLine : instream -> (string * instream) option\n  val outputSubstr : outstream * substring -> unit\n*)|}];;