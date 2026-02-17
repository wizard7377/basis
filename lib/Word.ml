[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note:\n * - Dropped deprecated {from,to}LargeWord functions.\n *)|}];;
type nonrec word = word;;
let wordSize = ((use { b = "Word.wordSize"}  ()) : int);;
let rec toLarge w = w;;
let rec toLargeX w = w;;
let rec fromLarge w = w;;
let toInt = ((use { b = "Word.toInt"} ) : (word -> Int.int));;
let toIntX = ((use { b = "Word.toIntX"} ) : (word -> Int.int));;
let fromInt = ((use { b = "Word.fromInt"} ) : (Int.int -> word));;
let toLargeInt = toInt;;
[@@@sml.comment {|(* mh, if Int <> LargeInt? *)|}];;
let toLargeIntX = toIntX;;
let fromLargeInt = fromInt;;
open StringCvt;;
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
  (begin
   if (i < 10) then (((Char.ord '0')) + i) else
   (((((Char.ord 'A')) + i)) - 10) end));;
let rec value c =
  (((Char.ord ((Char.toUpper c)))) -
    (begin if (c < 'A') then (Char.ord '0') else (((Char.ord 'A')) - 10)
     end));;
let rec fmt_prime =
  (function 
            | (b, 0, cs) -> (String.implode cs)
            | (b, i, cs)
                -> (fmt_prime
                   (b, (div (i, b)), ((digit ((toInt ((mod_ (i, b)))))) :: cs))));;
let rec fmt arg__0 arg__1 =
  begin
  match (arg__0, arg__1)
  with 
       | (radix, 0) -> "0"
       | (radix, i) -> (fmt_prime ((base radix), i, []))
  end;;
let ( >>= ) opt f = match opt with None -> None | Some x -> f x;;
let rec scanPrefix radix getc src =
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
                                   if (Bool.not ((c1 = '0'))) then None
                                   else begin
                                   if
                                   (((radix = Hex)) &&
                                     ((((c2 = 'x')) || ((c2 = 'X')))))
                                   then (Some src2) else begin
                                   if (Bool.not ((c2 = 'w'))) then None
                                   else
                                   (getc
                                   src2
                                   >>=
                                   ((function 
                                              | (c3, src3)
                                                  -> (Some
                                                      (begin
                                                       if
                                                       (((c3 = 'x')) ||
                                                         ((c3 = 'X')))
                                                       then src3 else
                                                       src2 end)))))
                                   end end end))))));;
let rec scanOptPrefix radix getc src =
  begin
  match (scanPrefix radix getc src)
  with 
       | (Some src_prime) -> (Some src_prime)
       | None -> (Some src)
  end;;
let rec scanNum_prime (isDigit, base, w, k) getc src =
  begin
  match (getc src)
  with 
       | (Some (c, src_prime)) -> begin
           if (Bool.not ((isDigit c))) then (Some (w, k, src)) else begin
           if (w > (div ((( ~- ) 1), base))) then (raise Overflow) else
           (scanNum_prime
           (isDigit, base, (((base * w)) + ((fromInt ((value c))))),
            (k + 1))
           getc
           src_prime) end end
       | None -> (Some (w, k, src))
  end;;
let rec scanNum (isDigit, base) getc src =
  (scanNum_prime
  (isDigit, base, 0, 0)
  getc
  src
  >>=
  ((function 
             | (w, k, src_prime) -> begin
                 if (k > 0) then (Some (w, src_prime)) else None end)));;
let rec scan radix getc src =
  (scanOptPrefix
  radix
  getc
  ((skipWS getc src))
  >>=
  ((function 
             | src1
                 -> begin
                    match (scanNum
                          ((isDigit radix), (base radix))
                          getc
                          src1)
                    with 
                         | (Some (num, src2)) -> (Some (num, src2))
                         | None
                             -> (scanNum ((isDigit radix), 0) getc src)
                    end)));;
let toString = (fmt StringCvt.Hex);;
let fromString = (StringCvt.scanString ((scan StringCvt.Hex)));;
let notb = ((use { b = "Word.notb"} ) : (word -> word));;
let orb = ((use { b = "Word.orb"} ) : (word * word -> word));;
let xorb = ((use { b = "Word.xorb"} ) : (word * word -> word));;
let andb = ((use { b = "Word.andb"} ) : (word * word -> word));;
let ( << ) = ((use { b = "Word.<<"} ) : (word * word -> word));;
let ( >> ) = ((use { b = "Word.>>"} ) : (word * word -> word));;
let ( ~>> ) = ((use { b = "Word.~>>"} ) : (word * word -> word));;
let div = (div : (word * word -> word));;
let mod_ = (mod_ : (word * word -> word));;
let rec ( ~- ) w = (notb ((w - 1)));;
let rec compare (i, j) = begin
  if (i < j) then LESS else begin if (i = j) then EQUAL else GREATER end
  end;;
let rec min (i, j) = begin if (i < j) then i else j end;;
let rec max (i, j) = begin if (i > j) then i else j end;;
