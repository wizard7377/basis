[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2002-2025\n *\n * Standard ML Basis Library\n *)|}];;
type nonrec 'a slice = 'a Array.array * int * int;;
let rec length (a, i, n) = n;;
let rec subslice =
  (function 
            | (sl, i, None)
                -> (subslice (sl, i, (Some ((((length sl)) - i)))))
            | (sl, i, (Some n))
                -> (try begin
                    if
                    (((i < 0)) ||
                      ((((n < 0)) || ((((length sl)) < ((i + n)))))))
                    then (raise Subscript) else
                    ((((fun (r, _, _) -> r)) sl),
                     (((((fun (_, r, _) -> r)) sl)) + i), n)
                    end with 
                             | Overflow -> (raise Subscript)));;
let rec full arr = (arr, 0, (Array.length arr));;
let rec slice (arr, i, sz) = (subslice ((full arr), i, sz));;
let rec base sl = (sl : 'a slice);;
let rec isEmpty sl = (((length sl)) = 0);;
let rec sub ((a, i, n), j) = begin
  if (((j < 0)) || ((n <= j))) then (raise Subscript) else
  (Array.sub (a, (i + j))) end;;
let rec update ((a, i, n), j, x) = begin
  if (((j < 0)) || ((n <= j))) then (raise Subscript) else
  (Array.update (a, (i + j), x)) end;;
let rec vector sl =
  (Vector.tabulate ((length sl), (function 
                                           | i -> (sub (sl, i)))));;
let rec getItem sl = begin
  if (isEmpty sl) then None else
  (Some ((sub (sl, 0)), (subslice (sl, 1, None)))) end;;
let rec appi_prime (f, sl, i) = begin
  if (i = ((length sl))) then () else
  begin
    (f (i, (sub (sl, i))));(appi_prime (f, sl, (i + 1)))
    end
  end;;
let rec appi f sl = (appi_prime (f, sl, 0));;
let rec modifyi_prime (f, sl, i) = begin
  if (i = ((length sl))) then () else
  begin
    (update (sl, i, (f (i, (sub (sl, i))))));
    (modifyi_prime (f, sl, (i + 1)))
    end
  end;;
let rec modifyi f sl = (modifyi_prime (f, sl, 0));;
let rec foldli_prime (f, x, sl, i) = begin
  if (i = ((length sl))) then x else
  (foldli_prime (f, (f (i, (sub (sl, i)), x)), sl, (i + 1))) end;;
let rec foldli f init sl = (foldli_prime (f, init, sl, 0));;
let rec foldri_prime (f, x, sl, i) = begin
  if (i = 0) then x else
  (foldri_prime (f, (f ((i - 1), (sub (sl, (i - 1))), x)), sl, (i - 1)))
  end;;
let rec foldri f init sl = (foldri_prime (f, init, sl, (length sl)));;
let rec findi_prime (f, sl, i) = begin
  if (i = ((length sl))) then None else begin
  if (f (i, (sub (sl, i)))) then (Some (i, (sub (sl, i)))) else
  (findi_prime (f, sl, (i + 1))) end end;;
let rec findi f sl = (findi_prime (f, sl, 0));;
let rec app f sl = (appi ((o f ((fun (_, r) -> r)))) sl);;
let rec modify f sl = (modifyi ((o f ((fun (_, r) -> r)))) sl);;
let rec foldl f init sl =
  (foldli ((function 
                     | (_, a, x) -> (f (a, x)))) init sl);;
let rec foldr f init sl =
  (foldri ((function 
                     | (_, a, x) -> (f (a, x)))) init sl);;
let rec find f sl =
  (Option.map
  ((fun (_, r) -> r))
  ((findi ((o f ((fun (_, r) -> r)))) sl)));;
let rec exists f sl = (Option.isSome ((find f sl)));;
let rec all f sl = (Bool.not ((exists ((o Bool.not f)) sl)));;
let rec collate arg__0 arg__1 =
  begin
  match (arg__0, arg__1)
  with 
       | (f, ((a1, i1, 0), (a2, i2, 0))) -> EQUAL
       | (f, ((a1, i1, 0), (a2, i2, n2))) -> LESS
       | (f, ((a1, i1, n1), (a2, i2, 0))) -> GREATER
       | (f, ((a1, i1, n1), (a2, i2, n2)))
           -> begin
              match (f ((Array.sub (a1, i1)), (Array.sub (a2, i2))))
              with 
                   | EQUAL
                       -> (collate
                          f
                          ((a1, (i1 + 1), (n1 - 1)),
                           (a2, (i2 + 1), (n2 - 1))))
                   | other -> other
              end
  end;;
type ('a, 'b) copy_args = { src : 'a; dst : 'b Array.array; di : int };;
let rec copy_prime (src, dst, di, i, to_, by) = begin
  if (i = to_) then () else
  begin
    (Array.update (dst, (di + i), (sub (src, i))));
    (copy_prime (src, dst, di, (i + by), to_, by))
    end
  end;;
let rec copy { src; dst; di } = begin
  if (((di < 0)) || ((((Array.length dst)) < ((di + ((length src)))))))
  then (raise Subscript) else begin
  if (((((fun (_, r, _) -> r)) src)) > di) then
  (copy_prime (src, dst, di, 0, (length src), 1)) else
  (copy_prime (src, dst, di, (((length src)) - 1), (-1), (-1))) end end;;
let rec copyVec_prime (src, dst, di, i) = begin
  if (i = ((VectorSlice.length src))) then () else
  begin
    (Array.update (dst, (di + i), (VectorSlice.sub (src, i))));
    (copyVec_prime (src, dst, di, (i + 1)))
    end
  end;;
let rec copyVec { src; dst; di } = begin
  if
  (((di < 0)) ||
    ((((Array.length dst)) < ((di + ((VectorSlice.length src)))))))
  then (raise Subscript) else (copyVec_prime (src, dst, di, 0)) end;;
