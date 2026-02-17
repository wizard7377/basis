[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note:\n * - We must keep the array type transparent in order to keep its\n *   special equality property.\n *)|}];;
type nonrec 'a array = (('a ref) vector) ref;;
type nonrec 'a vector = 'a vector;;
let maxLen = Vector.maxLen;;
let rec tabulate (n, f) = (ref ((Vector.tabulate (n, (o ref f)))));;
let rec array (n, init) =
  (ref ((Vector.tabulate (n, (function 
                                       | _ -> (ref init))))));;
let rec fromList l = (ref ((Vector.fromList ((List.map ref l)))));;
let rec length arr = (Vector.length ((! arr)));;
let rec sub (arr, i) = (! ((Vector.sub ((! arr), i))));;
let rec update (arr, i, x) = (((Vector.sub ((! arr), i))) := x);;
let rec vector arr = (Vector.map ( ! ) ((! arr)));;
let rec deref2 (i, r) = (i, (! r));;
let rec deref3 (i, r, x) = (i, (! r), x);;
let rec appi f arr = (Vector.appi ((o f deref2)) ((! arr)));;
let rec modifyi f arr =
  (Vector.appi
  ((function 
             | (i, r) -> (r := ((f (i, (! r)))))))
  ((! arr)));;
let rec foldli f init arr = (Vector.foldli ((o f deref3)) init ((! arr)));;
let rec foldri f init arr = (Vector.foldri ((o f deref3)) init ((! arr)));;
let rec findi f arr =
  (Option.map deref2 ((Vector.findi ((o f deref2)) ((! arr)))));;
let rec app f = (appi ((o f ((fun (_, r) -> r)))));;
let rec modify f = (modifyi ((o f ((fun (_, r) -> r)))));;
let rec foldl f = (foldli ((function 
                                     | (_, a, x) -> (f (a, x)))));;
let rec foldr f = (foldri ((function 
                                     | (_, a, x) -> (f (a, x)))));;
let rec find f arr =
  (Option.map
  ((fun (_, r) -> r))
  ((findi ((o f ((fun (_, r) -> r)))) arr)));;
let rec exists f arr = (Option.isSome ((find f arr)));;
let rec all f arr = (Bool.not ((exists ((o Bool.not f)) arr)));;
let rec collate_prime (f, a1, a2, i) =
  begin
  match ((i = ((length a1))), (i = ((length a2))))
  with 
       | (true, true) -> EQUAL
       | (true, false) -> LESS
       | (false, true) -> GREATER
       | (false, false)
           -> begin
              match (f ((sub (a1, i)), (sub (a2, i))))
              with 
                   | EQUAL -> (collate_prime (f, a1, a2, (i + 1)))
                   | other -> other
              end
  end;;
let rec collate f (a1, a2) = (collate_prime (f, a1, a2, 0));;
type ('a, 'b) copy_args = { src : 'a; dst : 'b array; di : int };;
let rec copy_prime (src, dst, di, i) = begin
  if (i = ((length src))) then () else
  begin
    (update (dst, (di + i), (sub (src, i))));
    (copy_prime (src, dst, di, (i + 1)))
    end
  end;;
let rec copy { src; dst; di } = begin
  if (((di < 0)) || ((((length dst)) < ((di + ((length src))))))) then
  (raise Subscript) else (copy_prime (src, dst, di, 0)) end;;
let rec copyVec_prime (src, dst, di, i) = begin
  if (i = ((Vector.length src))) then () else
  begin
    (update (dst, (di + i), (Vector.sub (src, i))));
    (copyVec_prime (src, dst, di, (i + 1)))
    end
  end;;
let rec copyVec { src; dst; di } = begin
  if (((di < 0)) || ((((length dst)) < ((di + ((Vector.length src)))))))
  then (raise Subscript) else (copyVec_prime (src, dst, di, 0)) end;;