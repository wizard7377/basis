(* 
 * (c) Andreas Rossberg 2002-2025
 *
 * Standard ML Basis Library
  *);;
open General;;
open Exceptions;;
open MONO_ARRAY_SLICE_sig;;
module Word8ArraySlice = struct
                           open ArraySlice;;
                           type nonrec elem = int;;
                           type nonrec vector = elem array;;
                           type nonrec array = elem array;;
                           let rec copyVec x = raise ((Fail "TODO"));;
                           end;;