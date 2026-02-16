[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
type nonrec bool = bool;;
let rec not = (function 
                        | true -> false
                        | false -> true);;
let string_sub_ = ((use { b = "String.sub"} ) : (string * int -> char));;
let string_size_ = ((use { b = "String.size"} ) : (string -> int));;
let ord = ((use { b = "Char.ord"} ) : (char -> int));;
let chr = ((use { b = "Char.chr"} ) : (int -> char));;
let rec char_isSpace_ c =
  ((((('t' <= c)) && ((c <= 'r')))) || ((c <= ' ')));;
let rec char_isUpper_ c = ((('A' <= c)) && ((c <= 'Z')));;
let rec char_toLower_ c = begin
  if (char_isUpper_ c) then (chr ((((ord c)) + 32))) else c end;;
let rec stringCvt_dropl_ (p, f, src) =
  begin
  match (f src)
  with 
       | None -> src
       | (Some (c, src_prime)) -> begin
           if (p c) then (stringCvt_dropl_ (p, f, src_prime)) else src end
  end;;
let rec stringCvt_skipWS_ (f, s) = (stringCvt_dropl_ (char_isSpace_, f, s));;
let rec reader s i =
  (try (Some ((string_sub_ (s, i)), (i + 1))) with 
                                                   | Subscript -> None);;
let rec stringCvt_scanString_ f s =
  begin
  match (f ((reader s)) 0) with 
                                | None -> None
                                | (Some (a, _)) -> (Some a)
  end;;
let rec scanTextual (s, i) getc src = begin
  if (i = ((string_size_ s))) then (Some src) else
  begin
  match (getc src)
  with 
       | (Some (c, src_prime)) -> begin
           if (((char_toLower_ c)) = ((string_sub_ (s, i)))) then
           (scanTextual (s, (i + 1)) getc src_prime) else None end
       | None -> None
  end end;;
let rec scan getc src =
  (let src1 = (stringCvt_skipWS_ (getc, src))
   in begin
      match (scanTextual ("true", 0) getc src1)
      with 
           | (Some src2) -> (Some (true, src2))
           | None
               -> begin
                  match (scanTextual ("false", 0) getc src1)
                  with 
                       | (Some src2) -> (Some (false, src2))
                       | None -> None
                  end
      end);;
let fromString = (stringCvt_scanString_ scan);;
let rec toString = (function 
                             | true -> "true"
                             | false -> "false");;
