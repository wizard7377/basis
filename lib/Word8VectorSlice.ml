[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2002-2025\n *\n * Standard ML Basis Library\n *)|}];;
open VectorSlice;;
type nonrec elem = Word8.word;;
type nonrec vector = Word8Vector.vector;;
type nonrec slice = elem VectorSlice.slice;;
let length = VectorSlice.length;;
let sub = VectorSlice.sub;;
