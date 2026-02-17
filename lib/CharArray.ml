[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note:\n * - Array type kept transparent to allow trivial implementation\n *   of CharArraySlice.\n *)|}];;
open Array;;
type nonrec array = char array;;
type nonrec elem = char;;
type nonrec vector = CharVector.vector;;
let rec vector arr =
  (CharVector.tabulate ((length arr), (function 
                                                | i -> (sub (arr, i)))));;
let rec copyVec_prime (src, dst, di, i) = begin
  if (i = ((CharVector.length src))) then () else
  begin
    (update (dst, (di + i), (CharVector.sub (src, i))));
    (copyVec_prime (src, dst, di, (i + 1)))
    end
  end;;
type ('a, 'b) copy_args = { src : 'a; dst : 'b Array.array; di : int };;
let rec copyVec { src; dst; di } = begin
  if
  (((di < 0)) || ((((length dst)) < ((di + ((CharVector.length src)))))))
  then (raise Subscript) else (copyVec_prime (src, dst, di, 0)) end;;
