[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Notes:\n * - Had to copy content of signature IMPERATIVE_IO because StreamIO is\n *   specialized.\n * - Incomplete.\n *)|}];;
module type TEXT_IO = sig
                      module StreamIO : sig type nonrec elem type nonrec vector end
                      [@@@sml.comment
                        {|(*\n    where type reader = TextPrimIO.reader\n    where type writer = TextPrimIO.writer\n    where type pos = TextPrimIO.pos\n*)|}]
                      [@@@sml.comment {|(* include IMPERATIVE_IO *)|}]
                      type nonrec vector = StreamIO.vector
                      type nonrec elem = StreamIO.elem
                      type nonrec instream
                      type nonrec outstream
                      val input : (instream -> vector)
                      val input1 : (instream -> elem option)
                      val inputN : (instream * int -> vector)
                      val inputAll : (instream -> vector)
                      [@@@sml.comment
                        {|(*\n  val canInput : instream * int -> int option\n  val lookahead : instream -> elem option\n*)|}]
                      val closeIn : (instream -> unit)
                      val endOfStream : (instream -> bool)
                      val output : (outstream * vector -> unit)
                      val output1 : (outstream * elem -> unit)
                      val flushOut : (outstream -> unit)
                      val closeOut : (outstream -> unit)
                      [@@@sml.comment
                        {|(*\n  val mkInstream : StreamIO.instream -> instream\n  val getInstream : instream -> StreamIO.instream\n  val setInstream : instream * StreamIO.instream -> unit\n  val mkOutstream : StreamIO.outstream -> outstream\n  val getOutstream : outstream -> StreamIO.outstream\n  val setOutstream : outstream * StreamIO.outstream -> unit\n  val getPosOut : outstream -> StreamIO.out_pos\n  val setPosOut : outstream * StreamIO.out_pos -> unit\n*)|}]
                      val inputLine : (instream -> string option)
                      val outputSubstr : (outstream * Substring.substring -> unit)
                      val openIn : (string -> instream)
                      val openOut : (string -> outstream)
                      val openAppend : (string -> outstream)
                      [@@@sml.comment
                        {|(*\n  val openString : string -> instream\n*)|}]
                      val stdIn : instream
                      val stdOut : outstream
                      val stdErr : outstream
                      val print : (string -> unit)
                      end;;
[@@@sml.comment
  {|(*\n  val scanStream : ((Char.char, StreamIO.instream) StringCvt.reader -> ('a, StreamIO.instream) StringCvt.reader) -> instream -> 'a option\n*)|}];;