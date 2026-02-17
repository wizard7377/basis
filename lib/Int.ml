[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
type nonrec int = int;;
let precision = ((use { b = "Int.precision"}  ()) : int option);;
let minInt = ((use { b = "Int.minInt"}  ()) : int option);;
let maxInt = ((use { b = "Int.maxInt"}  ()) : int option);;
let rec toLarge i = i;;
let rec fromLarge i = i;;
let rec toInt i = i;;
let rec fromInt i = i;;
let abs = (abs : (int -> int));;
let ( ~- ) = (( ~- ) : (int -> int));;
let div = (div : (int * int -> int));;
let mod_ = (mod_ : (int * int -> int));;
let quot = ((use { b = "Int.quot"} ) : (int * int -> int));;
let rem = ((use { b = "Int.rem"} ) : (int * int -> int));;
let rec min (i, j) = begin if (i < j) then i else j end;;
let rec max (i, j) = begin if (i > j) then i else j end;;
let rec sign =
  (function 
            | 0 -> 0
            | i -> begin if (i > 0) then 1 else (-1) end);;
let rec sameSign (i, j) = (((sign i)) = ((sign j)));;
open StringCvt;;
[@@@sml.comment
  {|(* fmt and scan both use inverted signs to cope with minInt *)|}];;
let rec base = (function 
                         | Bin -> 2
                         | Oct -> 8
                         | Dec -> 10
                         | Hex -> 16);;
let rec isDigit =
  (function 
            | Bin -> (function 
                                | c -> ((('0' <= c)) && ((c <= '1'))))
            | Oct -> (function 
                                | c -> ((('0' <= c)) && ((c <= '7'))))
            | Dec -> Char.isDigit
            | Hex -> Char.isHexDigit);;
let rec digit i =
  (Char.chr
  ((i +
     (begin if (i < 10) then (Char.ord '0') else (((Char.ord 'A')) - 10)
      end))));;
let rec value c =
  (((Char.ord ((Char.toUpper c)))) -
    (begin if (c < 'A') then (Char.ord '0') else (((Char.ord 'A')) - 10)
     end));;
let rec fmt_prime =
  (function 
            | (b, 0, cs) -> (String.implode cs)
            | (b, i, cs)
                -> (fmt_prime
                   (b, (quot (i, b)),
                    ((digit ((- ((rem (i, b)))))) :: cs))));;
let rec fmt arg__0 arg__1 =
  begin
  match (arg__0, arg__1)
  with 
       | (radix, 0) -> "0"
       | (radix, i) -> begin
           if (i > 0) then (fmt_prime ((base radix), (- i), [])) else
           ("~" ^ (fmt_prime ((base radix), i, []))) end
  end;;
let ( >>= ) opt f = match opt with None -> None | Some x -> f x;;
let rec scanSign getc src =
  begin
  match (getc src)
  with 
       | (Some ('-', src_prime)) -> (Some (1, src_prime))
       | (Some ('~', src_prime)) -> (Some (1, src_prime))
       | (Some ('+', src_prime)) -> (Some ((-1), src_prime))
       | _ -> (Some ((-1), src))
  end;;
let rec scanHexPrefix getc src =
  (getc
  src
  >>=
  ((function 
             | (c1, src1)
                 -> (getc
                    src1
                    >>=
                    ((function 
                               | (c2, src2) -> begin
                                   if
                                   (((c1 = '0')) &&
                                     ((((c2 = 'x')) || ((c2 = 'X')))))
                                   then (Some src2) else None end))))));;
let rec scanPrefix radix getc src = begin
  if (Bool.not ((radix = Hex))) then (Some src) else
  begin
  match (scanHexPrefix getc src)
  with 
       | (Some src_prime) -> (Some src_prime)
       | None -> (Some src)
  end end;;
let rec scanNum_prime (isDigit, base, i, k) getc src =
  begin
  match (getc src)
  with 
       | (Some (c, src_prime)) -> begin
           if (isDigit c) then
           (scanNum_prime
           (isDigit, base, (((base * i)) - ((value c))), (k + 1))
           getc
           src_prime) else (Some (i, k, src)) end
       | None -> (Some (i, k, src))
  end;;
let rec scanNum (isDigit, base) getc src =
  (scanNum_prime
  (isDigit, base, 0, 0)
  getc
  src
  >>=
  ((function 
             | (i, k, src_prime) -> begin
                 if (k > 0) then (Some (i, src_prime)) else None end)));;
let rec scan radix getc src =
  (scanSign
  getc
  ((skipWS getc src))
  >>=
  ((function 
             | (sign, src1)
                 -> (scanPrefix
                    radix
                    getc
                    src1
                    >>=
                    ((function 
                               | src2
                                   -> begin
                                      match (scanNum
                                            ((isDigit radix),
                                             (base radix))
                                            getc
                                            src2)
                                      with 
                                           | (Some (num, src3))
                                               -> (Some
                                                   ((sign * num), src3))
                                           | None
                                               -> (scanNum
                                                  ((isDigit radix), 0)
                                                  getc
                                                  src1)
                                      end))))));;
let toString = (fmt StringCvt.Dec);;
let fromString = (StringCvt.scanString ((scan StringCvt.Dec)));;
let rec compare (i, j) = begin
  if (i < j) then LESS else begin if (i = j) then EQUAL else GREATER end
  end;;
