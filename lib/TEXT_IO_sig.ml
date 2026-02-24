(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Notes:
 * - Had to copy content of open General 
signature IMPERATIVE_IO because StreamIO is
 *   specialized.
 * - Incomplete.
  *);;
open General;;
open TEXT_STREAM_IO_sig;;
open GENERAL_sig;;
open Substring;;
module type TEXT_IO = sig
                      include GENERAL
                      module StreamIO : TEXT_STREAM_IO
                      (* 
    where type reader = TextPrimIO.reader
    where type writer = TextPrimIO.writer
    where type pos = TextPrimIO.pos
 *)
                      (*  include IMPERATIVE_IO  *)
                      type nonrec vector = StreamIO.vector
                      type nonrec elem = StreamIO.elem
                      type nonrec instream
                      type nonrec outstream
                      val input : instream -> vector
                      val input1 : instream -> elem option
                      val inputN : (instream * int) -> vector
                      val inputAll : instream -> vector
                      (* 
  val canInput : instream * int -> int option
  val lookahead : instream -> elem option
 *)
                      val closeIn : instream -> unit
                      val endOfStream : instream -> bool
                      val output : (outstream * vector) -> unit
                      val output1 : (outstream * elem) -> unit
                      val flushOut : outstream -> unit
                      val closeOut : outstream -> unit
                      (* 
  val mkInstream : StreamIO.instream -> instream
  val getInstream : instream -> StreamIO.instream
  val setInstream : instream * StreamIO.instream -> unit
  val mkOutstream : StreamIO.outstream -> outstream
  val getOutstream : outstream -> StreamIO.outstream
  val setOutstream : outstream * StreamIO.outstream -> unit
  val getPosOut : outstream -> StreamIO.out_pos
  val setPosOut : outstream * StreamIO.out_pos -> unit
 *)
                      val inputLine : instream -> string option
                      val outputSubstr : (outstream * substring) -> unit
                      val openIn : string -> instream
                      val openOut : string -> outstream
                      val openAppend : string -> outstream
                      (* 
  val openString : string -> instream
 *)
                      val stdIn : instream
                      val stdOut : outstream
                      val stdErr : outstream
                      val print : string -> unit
                      end;;
(* 
  val scanStream : ((Char.char, StreamIO.instream) StringCvt.reader -> ('a, StreamIO.instream) StringCvt.reader) -> instream -> 'a option
 *);;