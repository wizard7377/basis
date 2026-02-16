[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note: Kept transparent to allow easy implementation of Word8VectorSlice.\n *)|}];;
open Vector;;
type nonrec elem = Word8.word;;
type nonrec vector = elem vector;;
let tabulate = Vector.tabulate;;
let length = Vector.length;;
let sub = Vector.sub;;
let fromList = Vector.fromList;;
