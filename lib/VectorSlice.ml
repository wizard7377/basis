[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2002-2025\n *\n * Standard ML Basis Library\n *)|}];;
type nonrec 'a slice = 'a Vector.vector * int * int;;
let rec length (v, i, n) = n;;
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
let rec full v = (v, 0, (Vector.length v));;
let rec slice (v, i, sz) = (subslice ((full v), i, sz));;
let rec base sl = (sl : 'a slice);;
let rec isEmpty sl = (((length sl)) = 0);;
let rec sub ((v, i, n), j) = begin
  if (((j < 0)) || ((n <= j))) then (raise Subscript) else
  (Vector.sub (v, (i + j))) end;;
let rec vector sl =
  (Vector.tabulate ((length sl), (function 
                                           | i -> (sub (sl, i)))));;
let rec foldli_prime (f, x, sl, i) = begin
  if (i = ((length sl))) then x else
  (foldli_prime (f, (f (i, (sub (sl, i)), x)), sl, (i + 1))) end;;
let rec foldli f init sl = (foldli_prime (f, init, sl, 0));;
let rec mapi f sl =
  (let rec ff (i, a, l) = ((f (i, a)) :: l)
   in (Vector.fromList ((List.rev ((foldli ff [] sl))))));;
let rec map f sl = (mapi ((o f ((fun (_, r) -> r)))) sl);;
let rec concat l = (Vector.concat ((List.map vector l)));;
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
let rec foldri_prime (f, x, sl, i) = begin
  if (i = 0) then x else
  (foldli_prime (f, (f ((i - 1), (sub (sl, (i - 1))), x)), sl, (i - 1)))
  end;;
let rec foldri f init sl = (foldri_prime (f, init, sl, (length sl)));;
let rec findi_prime (f, sl, i) = begin
  if (i = ((length sl))) then None else begin
  if (f (i, (sub (sl, i)))) then (Some (i, (sub (sl, i)))) else
  (findi_prime (f, sl, (i + 1))) end end;;
let rec findi f sl = (findi_prime (f, sl, 0));;
let rec app f sl = (appi ((o f ((fun (_, r) -> r)))) sl);;
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
       | (f, ((v1, i1, 0), (v2, i2, 0))) -> EQUAL
       | (f, ((v1, i1, 0), (v2, i2, n2))) -> LESS
       | (f, ((v1, i1, n1), (v2, i2, 0))) -> GREATER
       | (f, ((v1, i1, n1), (v2, i2, n2)))
           -> begin
              match (f ((Vector.sub (v1, i1)), (Vector.sub (v2, i2))))
              with 
                   | EQUAL
                       -> (collate
                          f
                          ((v1, (i1 + 1), (n1 - 1)),
                           (v2, (i2 + 1), (n2 - 1))))
                   | other -> other
              end
  end;;
