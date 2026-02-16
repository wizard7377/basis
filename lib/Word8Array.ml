[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note:\n *   Array type kept transparent to allow trivial implementation of\n *   Word8ArraySlice.\n *)|}];;
open Array;;
type nonrec elem = Word8.word;;
type nonrec vector = Word8Vector.vector;;
type nonrec array = elem array;;
let length = Array.length;;
let update = Array.update;;
let sub = Array.sub;;
let copyVec = Array.copyVec;;
