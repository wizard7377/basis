(*
 * (c) Andreas Rossberg 2002-2025
 *
 * Standard ML Basis Library
 *)
open General
open MONO_VECTOR_SLICE_sig

module Word8VectorSlice = struct
  open VectorSlice

  type nonrec elem = int
  type nonrec vector = elem array
end
