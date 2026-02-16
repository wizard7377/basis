[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note: Incomplete.\n *)|}];;
type nonrec substring = string * int * int;;
type nonrec char = Char.char;;
type nonrec string = String.string;;
let rec substring (s, i, j) =
  (try begin
   if (((i < 0)) || ((((j < 0)) || ((((String.size s)) < ((i + j)))))))
   then (raise Subscript) else (s, i, j) end
   with 
        | Overflow -> (raise Subscript));;
let rec base ss = (ss : substring);;
let string = (o String.substring base);;
let size = (o ((fun (_, _, r) -> r)) base);;
let rec sub ((s, i, n), j) = (String.sub (s, (i + j)));;
let rec extract =
  (function 
            | (s, i, None) -> (substring (s, i, (((String.size s)) - i)))
            | (s, i, (Some j)) -> (substring (s, i, j)));;
let rec full s = (substring (s, 0, (String.size s)));;
let rec isEmpty (s, i, n) = (n = 0);;
let rec getc =
  (function 
            | (s, i, 0) -> None
            | (s, i, n)
                -> (Some ((String.sub (s, i)), (s, (i + 1), (n - 1)))));;
let first = (o (Option.map ((fun (r, _) -> r))) getc);;
let rec int_min_ (i, j) = begin if (i < j) then i else j end;;
let rec int_max_ (i, j) = begin if (i > j) then i else j end;;
let rec triml k (s, i, n) = begin
  if (k < 0) then (raise Subscript) else
  (s, (i + ((int_min_ (k, n)))), (int_max_ ((n - k), 0))) end;;
let rec trimr k (s, i, n) = begin
  if (k < 0) then (raise Subscript) else (s, i, (int_max_ ((n - k), 0)))
  end;;
let rec slice_prime ((s, i, n), j, m) =
  (try begin
   if (((j + m)) > n) then (raise Subscript) else
   (substring (s, (i + j), m)) end with 
                                        | Overflow -> (raise Subscript));;
let rec slice =
  (function 
            | (ss, i, (Some m)) -> (slice_prime (ss, i, m))
            | (ss, i, None) -> (slice_prime (ss, i, (((size ss)) - i))));;
let concat = (o String.concat ((List.map string)));;
let rec concatWith s = (o (String.concatWith s) ((List.map string)));;
let rec explode ss = (String.explode ((string ss)));;
let rec translate f ss = (String.concat ((List.map f ((explode ss)))));;
let rec isPrefix s ss = (String.isPrefix s ((string ss)));;
let rec isSubstring s ss = (String.isSubstring s ((string ss)));;
let rec isSuffix s ss = (String.isSuffix s ((string ss)));;
let rec compare (ss, st) = (String.compare ((string ss), (string st)));;
let rec collate f (ss, st) =
  (String.collate f ((string ss), (string st)));;
let rec splitAt ((s, i, n), j) = begin
  if (((j < 0)) || ((j > n))) then (raise Subscript) else
  ((s, i, j), (s, (i + j), (n - j))) end;;
let rec splitl_prime (f, s, i, n, j) = begin
  if (j = ((i + n))) then ((s, i, n), (s, j, 0)) else begin
  if (f ((String.sub (s, j)))) then (splitl_prime (f, s, i, n, (j + 1)))
  else ((s, i, (j - i)), (s, j, (n - ((j - i))))) end end;;
let rec splitl f (s, i, n) = (splitl_prime (f, s, i, n, i));;
let rec splitr_prime (f, s, i, n, j) = begin
  if (j < i) then ((s, i, 0), (s, i, n)) else begin
  if (f ((String.sub (s, j)))) then (splitr_prime (f, s, i, n, (j - 1)))
  else ((s, i, (((j - i)) + 1)), (s, (j + 1), (n - ((((j - i)) + 1)))))
  end end;;
let rec splitr f (s, i, n) = (splitr_prime (f, s, i, n, (((i + n)) - 1)));;
let rec takel p ss = (((fun (r, _) -> r)) ((splitl p ss)));;
let rec dropl p ss = (((fun (_, r) -> r)) ((splitl p ss)));;
let rec taker p ss = (((fun (_, r) -> r)) ((splitr p ss)));;
let rec dropr p ss = (((fun (r, _) -> r)) ((splitr p ss)));;
let rec position_prime s_prime (s, i, n) = begin
  if (((String.size s_prime)) > n) then (s, (i + n), 0) else begin
  if (isPrefix s_prime (s, i, n)) then (s, i, n) else
  (position_prime s_prime ((triml 1 (s, i, n)))) end end;;
let rec position s_prime (s, i, n) =
  (let (s, k, n_prime) = (position_prime s_prime (s, i, n))
   in ((s, i, (k - i)), (s, k, n_prime)));;
let rec span ((s, i, n), (s_prime, i_prime, n_prime)) = begin
  if (((Bool.not ((s = s_prime)))) || ((((i_prime + n_prime)) < i))) then
  (raise Span) else (s, i, (((i_prime + n_prime)) - i)) end;;
let rec fields_prime (f, s, i, j, n) = begin
  if (j = ((i + n))) then [(s, i, (j - i))] else begin
  if (f ((String.sub (s, j)))) then
  ((s, i, (j - i)) :: (fields_prime (f, s, (j + 1), (j + 1), (n - 1))))
  else (fields_prime (f, s, i, (j + 1), (n - 1))) end end;;
let rec fields f (s, i, n) = (fields_prime (f, s, i, i, n));;
let rec tokens f s =
  (List.filter
  ((function 
             | (s, i, n) -> (Bool.not ((n = 0)))))
  ((fields f s)));;
let rec foldl f a ss = (List.foldl f a ((explode ss)));;
let rec foldr f a ss = (List.foldr f a ((explode ss)));;
let rec app f ss = (List.app f ((explode ss)));;