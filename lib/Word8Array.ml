(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note:
 *   Array type kept transparent to allow trivial implementation of
 *   Word8ArraySlice.
  *);;
open General;;
open MONO_ARRAY_sig;;
module Word8Array = struct
                      open Array;;
                      type nonrec elem = int;;
                      type nonrec vector = elem array;;
                      type nonrec array = elem array;;
                      end;;