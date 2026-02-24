(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note: Incomplete.
 *)
open General
open STREAM_IO_sig

module type TEXT_STREAM_IO = sig
  include STREAM_IO
end
(* 
  val inputLine : instream -> (string * instream) option
  val outputSubstr : outstream * substring -> unit
 *)
