[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2002-2025\n *\n * Standard ML Basis Library\n *)|}];;
open ArraySlice;;
type nonrec elem = Char.char;;
type nonrec vector = CharVector.vector;;
type nonrec array = elem array;;
type nonrec slice = elem slice;;
type nonrec vector_slice = CharVectorSlice.slice;;
let rec vector sl =
  (CharVector.tabulate ((length sl), (function 
                                               | i -> (sub (sl, i)))));;
let rec copyVec_prime (src, dst, di, i) = begin
  if (i = ((CharVectorSlice.length src))) then () else
  begin
    (Array.update (dst, (di + i), (CharVectorSlice.sub (src, i))));
    (copyVec_prime (src, dst, di, (i + 1)))
    end
  end;;
type ('a, 'b) copy_args = { src : 'a; dst : 'b Array.array; di : int };;
let rec copyVec { src; dst; di } = begin
  if
  (((di < 0)) ||
    ((((Array.length dst)) < ((di + ((CharVectorSlice.length src)))))))
  then (raise Subscript) else (copyVec_prime (src, dst, di, 0)) end;;
