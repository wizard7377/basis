[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note: Incomplete.\n *)|}];;
type nonrec string = string;;
type nonrec char = Char.char;;
let maxSize = ((use { b = "String.maxSize"}  ()) : int);;
let size = ((use { b = "String.size"} ) : (string -> int));;
let sub = ((use { b = "String.sub"} ) : (string * int -> char));;
let str = ((use { b = "String.str"} ) : (char -> string));;
let ( ^ ) a b = ((use { b = "String.^"} ) : (string * string -> string)) (a, b);;
let rec concat = (function 
                           | [] -> ""
                           | (s :: l) -> (s ^ ((concat l))));;
let rec concatWith arg__0 arg__1 =
  begin
  match (arg__0, arg__1)
  with 
       | (s, []) -> ""
       | (s, (s_prime :: [])) -> s_prime
       | (s, (s_prime :: l)) -> (((s_prime ^ s)) ^ ((concatWith s l)))
  end;;
let rec explode_prime (s, i, l) = begin
  if (i < 0) then l else
  (explode_prime (s, (i - 1), ((sub (s, i)) :: l))) end;;
let rec explode s = (explode_prime (s, (((size s)) - 1), []));;
let rec implode l = (concat ((List.map str l)));;
let rec map f s = (implode ((List.map f ((explode s)))));;
let rec substring_prime (s, i, j, cs) = begin
  if (i > j) then (implode cs) else
  (substring_prime (s, i, (j - 1), ((sub (s, j)) :: cs))) end;;
let rec substring (s, i, j) =
  (try (substring_prime (s, i, (((i - 1)) + j), []))
   with 
        | Overflow -> (raise Subscript));;
let rec extract =
  (function 
            | (s, i, None) -> (substring (s, i, (((size s)) - i)))
            | (s, i, (Some j)) -> (substring (s, i, j)));;
let rec translate f s = (concat ((List.map f ((explode s)))));;
let rec fields_prime (f, s, i, j) = begin
  if (j = ((size s))) then [(substring (s, i, (j - i)))] else begin
  if (f ((sub (s, j)))) then
  ((substring (s, i, (j - i)))
   :: (fields_prime (f, s, (j + 1), (j + 1))))
  else (fields_prime (f, s, i, (j + 1))) end end;;
let rec fields f s = (fields_prime (f, s, 0, 0));;
let rec tokens f s =
  (List.filter ((function 
                          | s -> (Bool.not ((s = ""))))) ((fields f s)));;
let rec isPrefix_prime (s1, s2, i) =
  (((i = ((size s1)))) ||
    ((((i < ((size s2)))) &&
       ((((((sub (s1, i))) = ((sub (s2, i))))) &&
          ((isPrefix_prime (s1, s2, (i + 1)))))))));;
let rec isPrefix s1 s2 = (isPrefix_prime (s1, s2, 0));;
let rec isSuffix_prime (s1, s2, i) =
  (((i = ((size s1)))) ||
    ((((i < ((size s2)))) &&
       ((((((sub (s1, (((((size s1)) - i)) - 1)))) =
            ((sub (s2, (((((size s2)) - i)) - 1))))))
          && ((isSuffix_prime (s1, s2, (i + 1)))))))));;
let rec isSuffix s1 s2 = (isSuffix_prime (s1, s2, 0));;
let rec isSubstring_prime_prime (s1, s2, i, j) =
  (((j = ((size s1)))) ||
    ((((((sub (s1, i))) = ((sub (s2, (i + j)))))) &&
       ((isSubstring_prime_prime (s1, s2, i, (j + 1)))))));;
let rec isSubstring_prime (s1, s2, i) =
  (((((i + ((size s1)))) < ((size s2)))) &&
    ((((isSubstring_prime_prime (s1, s2, i, 0))) ||
       ((isSubstring_prime (s1, s2, (i + 1)))))));;
let rec isSubstring s1 s2 = (isSubstring_prime (s1, s2, 0));;
let rec collate_prime (f, s, t, i) =
  begin
  match ((i = ((size s))), (i = ((size t))))
  with 
       | (true, true) -> EQUAL
       | (true, false) -> LESS
       | (false, true) -> GREATER
       | (false, false)
           -> begin
              match (f ((sub (s, i)), (sub (t, i))))
              with 
                   | EQUAL -> (collate_prime (f, s, t, (i + 1)))
                   | other -> other
              end
  end;;
let rec collate f (s, t) = (collate_prime (f, s, t, 0));;
let compare = (collate Char.compare);;
let toString = (translate Char.toString);;
let toCString = (translate Char.toCString);;
let ( >>= ) opt f = match opt with None -> None | Some x -> f x;;
let rec scanGap getc src =
  (getc
  src
  >>=
  ((function 
             | (c, src_prime) -> begin
                 if (c = '\\') then (Some src_prime) else begin
                 if (Char.isSpace c) then (scanGap getc src_prime) else
                 None end end)));;
let rec scanOptGap_prime getc src =
  (getc
  src
  >>=
  ((function 
             | (c1, src_prime)
                 -> (getc
                    src_prime
                    >>=
                    ((function 
                               | (c2, src_prime_prime) -> begin
                                   if
                                   (((c1 = '\\')) && ((Char.isSpace c2)))
                                   then
                                   (scanGap
                                   getc
                                   src_prime_prime
                                   >>=
                                   scanOptGap
                                   getc) else None end))))))
and scanOptGap getc src =
  (Some ((Option.getOpt ((scanOptGap_prime getc src), src))));;
let rec scan_prime cs getc src =
  begin
  match (Char.scan getc src)
  with 
       | (Some (c, src_prime)) -> (scan_prime ((c :: cs)) getc src_prime)
       | None -> (Some (cs, src))
  end;;
let rec scan getc src =
  (scan_prime
  []
  getc
  src
  >>=
  ((function 
             | (cs, src_prime)
                 -> (scanOptGap
                    getc
                    src_prime
                    >>=
                    ((function 
                               | src_prime_prime
                                   -> (Some
                                       ((implode ((List.rev cs))),
                                        src_prime_prime))))))));;
let rec reader s i =
  (try (Some ((sub (s, i)), (i + 1))) with 
                                           | Subscript -> None);;
let rec scanString f s =
  (Option.map
  ((fun (r, _) -> r))
  (((f ((reader s)) 0) : ('a * int) option)));;
let fromString = (scanString scan);;

[@@@sml.comment
  {|(*\n  val fromCString : String.string -> string option\n*)|}];;