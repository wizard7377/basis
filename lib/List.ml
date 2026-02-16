[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
type nonrec 'a list = 'a list;;
exception Empty = Empty;;
let rec null = (function 
                         | [] -> true
                         | _ -> false);;
let rec length =
  (function 
            | [] -> 0
            | (x :: l_prime) -> (1 + ((length l_prime))));;
let rec hd = (function 
                       | (x :: l_prime) -> x
                       | _ -> (raise Empty));;
let rec tl = (function 
                       | (x :: l_prime) -> l_prime
                       | _ -> (raise Empty));;
let rec last =
  (function 
            | (x :: []) -> x
            | (x :: l_prime) -> (last l_prime)
            | [] -> (raise Empty));;
let rec getItem =
  (function 
            | (x :: l_prime) -> (Some (x, l_prime))
            | [] -> None);;
let rec nth =
  (function 
            | ((x :: l_prime), 0) -> x
            | ((x :: l_prime), i) -> (nth (l_prime, (i - 1)))
            | ([], i) -> (raise Subscript));;
let rec rev_prime =
  (function 
            | ([], xs) -> xs
            | ((x :: l_prime), xs) -> (rev_prime (l_prime, (x :: xs))));;
let rec rev l = (rev_prime (l, []));;
let rec ( @ ) l1 l2 =
  begin
  match l1
  with 
       | [] -> l2
       | (x :: l1_prime) -> (x :: (l1_prime @ l2))
  end;;
let rec revAppend =
  (function 
            | ([], l2) -> l2
            | ((x :: l1_prime), l2) -> (revAppend (l1_prime, (x :: l2))));;
let rec concat =
  (function 
            | [] -> []
            | (xs :: l_prime) -> (xs @ ((concat l_prime))));;
let rec take =
  (function 
            | (l, 0) -> []
            | ((x :: l_prime), i) -> (x :: (take (l_prime, (i - 1))))
            | ([], i) -> (raise Subscript));;
let rec drop =
  (function 
            | (l, 0) -> l
            | ((x :: l_prime), i) -> (drop (l_prime, (i - 1)))
            | ([], i) -> (raise Subscript));;
let rec app arg__2 arg__3 =
  begin
  match (arg__2, arg__3)
  with 
       | (f, []) -> ()
       | (f, (x :: l_prime)) -> begin
                                  (f x);(app f l_prime)
                                  end
  end;;
let rec map arg__4 arg__5 =
  begin
  match (arg__4, arg__5)
  with 
       | (f, []) -> []
       | (f, (x :: l_prime)) -> ((f x) :: (map f l_prime))
  end;;
let rec mapPartial arg__6 arg__7 =
  begin
  match (arg__6, arg__7)
  with 
       | (f, []) -> []
       | (f, (x :: l_prime))
           -> begin
              match (f x)
              with 
                   | None -> (mapPartial f l_prime)
                   | (Some y) -> (y :: (mapPartial f l_prime))
              end
  end;;
let rec find arg__8 arg__9 =
  begin
  match (arg__8, arg__9)
  with 
       | (f, []) -> None
       | (f, (x :: l_prime)) -> begin
           if (f x) then (Some x) else (find f l_prime) end
  end;;
let rec filter arg__10 arg__11 =
  begin
  match (arg__10, arg__11)
  with 
       | (f, []) -> []
       | (f, (x :: l_prime)) -> begin
           if (f x) then (x :: (filter f l_prime)) else
           (filter f l_prime) end
  end;;
let rec partition arg__12 arg__13 =
  begin
  match (arg__12, arg__13)
  with 
       | (f, []) -> ([], [])
       | (f, (x :: l_prime))
           -> (let (l1, l2) = (partition f l_prime) in begin
               if (f x) then ((x :: l1), l2) else (l1, (x :: l2)) end)
  end;;
let rec foldl arg__14 arg__15 arg__16 =
  begin
  match (arg__14, arg__15, arg__16)
  with 
       | (f, b, []) -> b
       | (f, b, (x :: l_prime)) -> (foldl f ((f (x, b))) l_prime)
  end;;
let rec foldr arg__17 arg__18 arg__19 =
  begin
  match (arg__17, arg__18, arg__19)
  with 
       | (f, b, []) -> b
       | (f, b, (x :: l_prime)) -> (f (x, (foldr f b l_prime)))
  end;;
let rec exists arg__20 arg__21 =
  begin
  match (arg__20, arg__21)
  with 
       | (f, []) -> false
       | (f, (x :: l_prime)) -> (((f x)) || ((exists f l_prime)))
  end;;
let rec all f l = (Bool.not ((exists ((o Bool.not f)) l)));;
let rec tabulate_prime (n, f, i, l) = begin
  if (i = n) then (rev l) else
  (tabulate_prime (n, f, (i + 1), ((f i) :: l))) end;;
let rec tabulate (n, f) = begin
  if (n < 0) then (raise Size) else (tabulate_prime (n, f, 0, [])) end;;
let rec collate arg__22 arg__23 =
  begin
  match (arg__22, arg__23)
  with 
       | (f, ([], [])) -> EQUAL
       | (f, ([], l2)) -> LESS
       | (f, (l1, [])) -> GREATER
       | (f, ((x1 :: l1_prime), (x2 :: l2_prime)))
           -> begin
              match (f (x1, x2))
              with 
                   | EQUAL -> (collate f (l1_prime, l2_prime))
                   | other -> other
              end
  end;;
