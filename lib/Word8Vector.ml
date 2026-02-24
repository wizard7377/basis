(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note: Kept transparent to allow easy implementation of Word8VectorSlice.
 *)
open General
open MONO_VECTOR_sig

module Word8Vector = struct
  open Vector

  type nonrec elem = int
  type nonrec vector = elem vector
end
