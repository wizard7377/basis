[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
type nonrec vector = String.string;;
type nonrec elem = Char.char;;
let maxLen = String.maxSize;;
let length = String.size;;
let sub = String.sub;;
let concat = String.concat;;
let collate = String.collate;;
let fromList =
  ((use { b = "CharVector.fromList"} ) : (elem list -> vector));;
let rec tabulate (n, f) = (fromList ((List.tabulate (n, f))));;
let rec update (vec, i, x) =
  (tabulate
  ((length vec),
   (function 
             | j -> begin if (j = i) then x else (sub (vec, i)) end)));;
let rec appi_prime (f, vec, i) = begin
  if (i = ((length vec))) then () else
  begin
    (f (i, (sub (vec, i))));(appi_prime (f, vec, (i + 1)))
    end
  end;;
let rec appi f vec = (appi_prime (f, vec, 0));;
let rec foldli_prime (f, x, vec, i) = begin
  if (i = ((length vec))) then x else
  (foldli_prime (f, (f (i, (sub (vec, i)), x)), vec, (i + 1))) end;;
let rec foldli f init vec = (foldli_prime (f, init, vec, 0));;
let rec foldri_prime (f, x, vec, i) = begin
  if (i = 0) then x else
  (foldli_prime
  (f, (f ((i - 1), (sub (vec, (i - 1))), x)), vec, (i - 1))) end;;
let rec foldri f init vec = (foldri_prime (f, init, vec, (length vec)));;
let rec mapi f vec =
  (fromList
  ((foldri ((function 
                      | (i, x, l) -> ((f (i, x)) :: l))) [] vec)));;
let rec findi_prime (f, vec, i) = begin
  if (i = ((length vec))) then None else begin
  if (f (i, (sub (vec, i)))) then (Some (i, (sub (vec, i)))) else
  (findi_prime (f, vec, (i + 1))) end end;;
let rec findi f vec = (findi_prime (f, vec, 0));;
let rec app f vec = (appi ((o f ((fun (_, r) -> r)))) vec);;
let rec map f vec = (mapi ((o f ((fun (_, r) -> r)))) vec);;
let rec foldl f init vec =
  (foldli ((function 
                     | (_, a, x) -> (f (a, x)))) init vec);;
let rec foldr f init vec =
  (foldri ((function 
                     | (_, a, x) -> (f (a, x)))) init vec);;
let rec find f vec =
  (Option.map
  ((fun (_, r) -> r))
  ((findi ((o f ((fun (_, r) -> r)))) vec)));;
let rec exists f vec = (Option.isSome ((find f vec)));;
let rec all f vec = (Bool.not ((exists ((o Bool.not f)) vec)));;
