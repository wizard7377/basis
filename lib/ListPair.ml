[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
exception UnequalLengths ;;
let rec zip =
  (function 
            | ((x1 :: l1_prime), (x2 :: l2_prime))
                -> ((x1, x2) :: (zip (l1_prime, l2_prime)))
            | (_, _) -> []);;
let rec zipEq =
  (function 
            | ((x1 :: l1_prime), (x2 :: l2_prime))
                -> ((x1, x2) :: (zipEq (l1_prime, l2_prime)))
            | ([], []) -> []
            | _ -> (raise UnequalLengths));;
let rec unzip_prime =
  (function 
            | (((x1, x2) :: l_prime), l1, l2)
                -> (unzip_prime (l_prime, (x1 :: l1), (x2 :: l2)))
            | ([], l1, l2) -> ((List.rev l1), (List.rev l2)));;
let rec unzip l = (unzip_prime (l, [], []));;
let rec app f (l1, l2) = (List.app f ((zip (l1, l2))));;
let rec map f (l1, l2) = (List.map f ((zip (l1, l2))));;
let rec appEq arg__0 arg__1 =
  begin
  match (arg__0, arg__1)
  with 
       | (f, ((x1 :: l1_prime), (x2 :: l2_prime)))
           -> begin
                (f (x1, x2));(appEq f (l1_prime, l2_prime))
                end
       | (f, ([], [])) -> ()
       | (f, _) -> (raise UnequalLengths)
  end;;
let rec mapEq arg__2 arg__3 =
  begin
  match (arg__2, arg__3)
  with 
       | (f, ((x1 :: l1_prime), (x2 :: l2_prime)))
           -> ((f (x1, x2)) :: (mapEq f (l1_prime, l2_prime)))
       | (f, ([], [])) -> []
       | (f, _) -> (raise UnequalLengths)
  end;;
let rec nonflat f = (function 
                              | ((a, b), c) -> (f (a, b, c)));;
let rec foldl f c (l1, l2) =
  (List.foldl ((nonflat f)) c ((zip (l1, l2))));;
let rec foldr f c (l1, l2) =
  (List.foldr ((nonflat f)) c ((zip (l1, l2))));;
let rec foldlEq arg__4 arg__5 arg__6 =
  begin
  match (arg__4, arg__5, arg__6)
  with 
       | (f, c, ((x1 :: l1_prime), (x2 :: l2_prime)))
           -> (foldlEq f ((f (x1, x2, c))) (l1_prime, l2_prime))
       | (f, c, ([], [])) -> c
       | (f, c, _) -> (raise UnequalLengths)
  end;;
let rec foldrEq arg__7 arg__8 arg__9 =
  begin
  match (arg__7, arg__8, arg__9)
  with 
       | (f, c, ((x1 :: l1_prime), (x2 :: l2_prime)))
           -> (f (x1, x2, (foldrEq f c (l1_prime, l2_prime))))
       | (f, c, ([], [])) -> c
       | (f, c, _) -> (raise UnequalLengths)
  end;;
let rec all f (l1, l2) = (List.all f ((zip (l1, l2))));;
let rec exists f (l1, l2) = (List.exists f ((zip (l1, l2))));;
let rec allEq arg__10 arg__11 =
  begin
  match (arg__10, arg__11)
  with 
       | (f, ([], [])) -> true
       | (f, ((x :: xs), (y :: ys)))
           -> (((f (x, y))) && ((allEq f (xs, ys))))
       | (f, _) -> false
  end;;
