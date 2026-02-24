open IMPERATIVE_IO_sig
open STREAM_IO_sig
open Word8Vector
open Word8Array
open Word8
open PrimIO 
(*
module type BIN_IO = sig
include IMPERATIVE_IO
  with type StreamIO.vector = Word8Vector.vector
  and type StreamIO.elem = Word8.word
  and type StreamIO.reader = BinPrimIO.reader
  and type StreamIO.writer = BinPrimIO.writer
  and type StreamIO.pos = BinPrimIO.pos
val openIn  : string -> instream
val openOut : string -> outstream
val openAppend : string -> outstream
end
*)