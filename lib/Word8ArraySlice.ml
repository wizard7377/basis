[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2002-2025\n *\n * Standard ML Basis Library\n *)|}];;
open ArraySlice;;
type nonrec elem = Word8.word;;
type nonrec vector = Word8Vector.vector;;
type nonrec array = elem array;;
type nonrec slice = elem slice;;
type nonrec vector_slice = Word8VectorSlice.slice;;
let length = ArraySlice.length;;
let sub = ArraySlice.sub;;
let full = ArraySlice.full;;
let slice = ArraySlice.slice;;
let rec copyVec_prime (src, dst, di, i) = begin
  if (i = ((Word8VectorSlice.length src))) then () else
  begin
    (Array.update (dst, (di + i), (Word8VectorSlice.sub (src, i))));
    (copyVec_prime (src, dst, di, (i + 1)))
    end
  end;;
type ('a, 'b) copy_args = { src : 'a; dst : 'b Array.array; di : int };;
let rec copyVec { src; dst; di } = begin
  if
  (((di < 0)) ||
    ((((Array.length dst)) < ((di + ((Word8VectorSlice.length src)))))))
  then (raise Subscript) else (copyVec_prime (src, dst, di, 0)) end;;
