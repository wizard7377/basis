[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
type nonrec 'a vector = 'a vector;;
let maxLen = ((use { b = "Vector.maxLen"}  ()) : int);;
let rec length x =
  ((((use { b = "Vector.length"} ) : ('a vector -> int))) x);;
let rec sub x =
  ((((use { b = "Vector.sub"} ) : ('a vector * int -> 'a))) x);;
let rec fromList x =
  ((((use { b = "Vector.fromList"} ) : ('a list -> 'a vector))) x);;
let rec tabulate (n, f) = (fromList ((List.tabulate (n, f))));;
let rec update (vec, i, x) =
  (tabulate
  ((length vec),
   (function 
             | i_prime -> begin
                 if (i = i_prime) then x else (sub (vec, i_prime)) end)));;
let rec foldli_prime (f, x, vec, i) = begin
  if (i = ((length vec))) then x else
  (foldli_prime (f, (f (i, (sub (vec, i)), x)), vec, (i + 1))) end;;
let rec foldli f init vec = (foldli_prime (f, init, vec, 0));;
let rec foldri_prime (f, x, vec, i) = begin
  if (i = 0) then x else
  (foldri_prime
  (f, (f ((i - 1), (sub (vec, (i - 1))), x)), vec, (i - 1))) end;;
let rec foldri f init vec = (foldri_prime (f, init, vec, (length vec)));;
let rec foldl f init vec =
  (foldli ((function 
                     | (_, a, x) -> (f (a, x)))) init vec);;
let rec foldr f init vec =
  (foldri ((function 
                     | (_, a, x) -> (f (a, x)))) init vec);;
let rec app f vec =
  (List.app f ((foldr ((function 
                                 | (a, l) -> (a :: l))) [] vec)));;
let rec appi f vec =
  (List.app
  f
  ((foldri ((function 
                      | (i, a, l) -> ((i, a) :: l))) [] vec)));;
let rec map f vec =
  (fromList
  ((List.map f ((foldr ((function 
                                  | (a, l) -> (a :: l))) [] vec)))));;
let rec mapi f vec =
  (fromList
  ((List.map
   f
   ((foldri ((function 
                       | (i, a, l) -> ((i, a) :: l))) [] vec)))));;
let rec findi_prime (f, vec, i) = begin
  if (i = ((length vec))) then None else begin
  if (f (i, (sub (vec, i)))) then (Some (i, (sub (vec, i)))) else
  (findi_prime (f, vec, (i + 1))) end end;;
let rec findi f vec = (findi_prime (f, vec, 0));;
let rec find f vec =
  (Option.map
  ((fun (_, r) -> r))
  ((findi ((o f ((fun (_, r) -> r)))) vec)));;
let rec exists f vec = (Option.isSome ((find f vec)));;
let rec all f vec = (Bool.not ((exists ((o Bool.not f)) vec)));;
let rec collate_prime (f, vec1, vec2, i) =
  begin
  match ((i = ((length vec1))), (i = ((length vec2))))
  with 
       | (true, true) -> EQUAL
       | (true, false) -> LESS
       | (false, true) -> GREATER
       | (false, false)
           -> begin
              match (f ((sub (vec1, i)), (sub (vec2, i))))
              with 
                   | EQUAL -> (collate_prime (f, vec1, vec2, (i + 1)))
                   | other -> other
              end
  end;;
let rec collate f (vec1, vec2) = (collate_prime (f, vec1, vec2, 0));;
let rec concat l =
  (fromList ((List.concat ((List.map ((foldr (fun (a, b) -> a :: b) [])) l)))));;

