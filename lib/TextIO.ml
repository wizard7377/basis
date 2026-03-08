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
  *)
open General
open TEXT_STREAM_IO_sig
open General
open Substring

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
  val inputN : instream * int -> vector
  val inputAll : instream -> vector

  (* 
  val canInput : instream * int -> int option
  val lookahead : instream -> elem option
 *)
  val closeIn : instream -> unit
  val endOfStream : instream -> bool
  val output : outstream * vector -> unit
  val output1 : outstream * elem -> unit
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
  val outputSubstr : outstream * substring -> unit
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
end

(* 
  val scanStream : ((Char.char, StreamIO.instream) StringCvt.reader -> ('a, StreamIO.instream) StringCvt.reader) -> instream -> 'a option
 *)
(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note: Incomplete.
  *)
module TextIO = struct
  module StreamIO = struct
    type nonrec vector = string
    type nonrec elem = char
  end

  type nonrec vector = StreamIO.vector
  type nonrec elem = StreamIO.elem
  type nonrec instream = Stdlib.in_channel
  type nonrec outstream = Stdlib.out_channel

  let stdIn = Stdlib.stdin
  let stdOut = Stdlib.stdout
  let stdErr = Stdlib.stderr
  let rec openIn s = Stdlib.open_in s
  let rec openOut s = Stdlib.open_out s

  let rec openAppend s =
    Stdlib.open_out_gen [ Open_wronly; Open_append; Open_creat ] 0o666 s

  let rec closeIn s = Stdlib.close_in s
  let rec closeOut s = Stdlib.close_out s
  let rec input s = Stdlib.In_channel.input_all s
  let rec input1 s = try Some (Stdlib.input_char s) with End_of_file -> None

  let rec inputN (s, n) =
    begin match Stdlib.In_channel.really_input_string s n with
    | Some str -> str
    | None -> Stdlib.In_channel.input_all s
    end

  let rec inputAll s = Stdlib.In_channel.input_all s

  let rec inputLine s =
    try Some (Stdlib.input_line s ^ "\n") with End_of_file -> None

  let rec endOfStream s =
    begin match input1 s with
    | None -> true
    | Some c ->
        Stdlib.seek_in s (Stdlib.pos_in s - 1);
        false
    end

  let rec output (os, v) = Stdlib.output_string os v
  let rec output1 (os, e) = Stdlib.output_char os e
  let rec flushOut os = Stdlib.flush os

  let rec print s =
    output (stdOut, s);
    flushOut stdOut

  let rec outputSubstr (os, ss) = output (os, Substring.string ss)
end
(* 
  fun scanStream scanFn strm  =
      let
        val instrm = getInstream strm
      in
        case (scanFn StreamIO.input1 instrm) of
          NONE => NONE
        | SOME(v, instrm') => ( setInstream (strm, instrm'); SOME v )
      end
 *)
