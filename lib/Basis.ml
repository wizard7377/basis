(* 
 * (c) Andreas Rossberg 2001_2025
 *
 * Standard ML Basis Library
 *
 * Notes:
 * _ We only implement required structures (and their include General 
signatures).
 * _ Modules commented out are not yet implemented.
  *)
include Infix
include Types
include Exceptions
include General
include Option
include Bool
include List
include ListPair
include Char
include String
include Substring
include StringCvt
include Int
include LargeInt
include Word
include Word8
include LargeWord
include IEEEReal
include Math
include Real
include LargeReal
include Vector
include MONO_VECTOR_sig
include Word8Vector
include CharVector
include VectorSlice
include MONO_VECTOR_SLICE_sig
include Word8VectorSlice
include CharVectorSlice
include Array
include MONO_ARRAY_sig
include Word8Array
include CharArray
include ArraySlice
include MONO_ARRAY_SLICE_sig
include Word8ArraySlice
include CharArraySlice
include Byte
include Text
include IO

(* include PRIM_IO_sig; *)
(* include BinPrimIO; *)
(* include TextPrimIO; *)
include STREAM_IO_sig
include IMPERATIVE_IO_sig
include TEXT_STREAM_IO_sig
include TextIO

(* include BIN_IO_sig; *)
(* include BinIO; *)
include OS_FileSys
include OS_Path
include OS_Process

(* include OS_IO_sig; *)
include OS
include OS_Path
include OS_FileSys
include OS_Process

(* include OS_IO; *)
include OS
include CommandLine

(* include DATE_sig; *)
(* include Date; *)
(* include TIME_sig; *)
(* include Time; *)
(* include TIMER_sig; *)
(* include Timer; *)
include Values
include Toplevel
