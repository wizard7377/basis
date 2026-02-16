[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2002-2025\n *\n * Standard ML Basis Library\n *)|}];;
type nonrec elem = Char.char;;
type nonrec vector = CharVector.vector;;
type nonrec slice = Substring.substring;;
let base = Substring.base;;
let length = Substring.size;;
let isEmpty = Substring.isEmpty;;
let sub = Substring.sub;;
let full = Substring.full;;
let slice = Substring.extract;;
let subslice = Substring.slice;;
let vector = Substring.string;;
let concat = Substring.concat;;
let getItem = Substring.getc;;
let collate = Substring.collate;;
let rec appi_prime (f, sl, i) = begin
  if (i = ((length sl))) then () else
  begin
    (f (i, (sub (sl, i))));(appi_prime (f, sl, (i + 1)))
    end
  end;;
let rec appi f sl = (appi_prime (f, sl, 0));;
let rec foldli_prime (f, x, sl, i) = begin
  if (i = ((length sl))) then x else
  (foldli_prime (f, (f (i, (sub (sl, i)), x)), sl, (i + 1))) end;;
let rec foldli f init sl = (foldli_prime (f, init, sl, 0));;
let rec foldri_prime (f, x, sl, i) = begin
  if (i = 0) then x else
  (foldli_prime (f, (f ((i - 1), (sub (sl, (i - 1))), x)), sl, (i - 1)))
  end;;
let rec foldri f init sl = (foldri_prime (f, init, sl, (length sl)));;
let rec mapi f sl =
  (CharVector.fromList
  ((foldri ((function 
                      | (i, a, l) -> ((f (i, a)) :: l))) [] sl)));;
let rec findi_prime (f, sl, i) = begin
  if (i = ((length sl))) then None else begin
  if (f (i, (sub (sl, i)))) then (Some (i, (sub (sl, i)))) else
  (findi_prime (f, sl, (i + 1))) end end;;
let rec findi f sl = (findi_prime (f, sl, 0));;
let rec app f sl = (appi ((o f ((fun (_, r) -> r)))) sl);;
let rec map f sl = (mapi ((o f ((fun (_, r) -> r)))) sl);;
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
