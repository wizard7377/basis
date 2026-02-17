[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
type nonrec char = char;;
type nonrec string = string;;
let ord = ((use { b = "Char.ord"} ) : (char -> int));;
let chr = ((use { b = "Char.chr"} ) : (int -> char));;
let maxOrd = 255;;
let minChar = (chr 0);;
let maxChar = (chr maxOrd);;
let rec succ c = begin
  if (c = maxChar) then (raise Chr) else (chr ((((ord c)) + 1))) end;;
let rec pred c = begin
  if (c = minChar) then (raise Chr) else (chr ((((ord c)) - 1))) end;;
let string_sub_ = ((use { b = "String.sub"} ) : (string * int -> char));;
let string_size_ = ((use { b = "String.size"} ) : (string -> int));;
let string_str_ = ((use { b = "String.str"} ) : (char -> string));;
let ( ^ ) a b = ((use { b = "String.^"} ) : (string * string -> string)) (a, b);;
let rec conts_prime (s, c, i) =
  (((i >= 0)) &&
    ((((((string_sub_ (s, i))) = c)) || ((conts_prime (s, c, (i - 1)))))));;
let rec contains s c = (conts_prime (s, c, (((string_size_ s)) - 1)));;let rec notContains s c = (Bool.not ((contains s c)));;
let rec isUpper c = ((('A' <= c)) && ((c <= 'Z')));;
let rec isLower c = ((('a' <= c)) && ((c <= 'z')));;
let rec isDigit c = ((('0' <= c)) && ((c <= '9')));;
let rec isAlpha c = (((isUpper c)) || ((isLower c)));;
let rec isAlphaNum c = (((isAlpha c)) || ((isDigit c)));;
let rec isHexDigit c =
  (((isDigit c)) ||
    (((((('a' <= c)) && ((c <= 'f')))) ||
       (((('A' <= c)) && ((c <= 'F')))))));;
let rec isGraph c = ((('!' <= c)) && ((c <= '~')));;
let rec isPrint c = (((isGraph c)) || ((c = ' ')));;
let rec isPunct c = (((isGraph c)) && ((Bool.not ((isAlphaNum c)))));;
let rec isCntrl c = (Bool.not ((isPrint c)));;
let rec isSpace c = ((((('t' <= c)) && ((c <= 'r')))) || ((c = ' ')));;
let rec isAscii c = (((0 <= ((ord c)))) && ((((ord c)) <= 127)));;
let rec toLower c = begin
  if (isUpper c) then (chr ((((ord c)) + 32))) else c end;;
let rec toUpper c = begin
  if (isLower c) then (chr ((((ord c)) - 32))) else c end;;
let rec toControl c =
  ("\\^" ^ ((string_str_ ((chr ((((ord c)) + ((ord '@')))))))));;
let rec toAscii c =
  ((((("\\" ^
        ((string_str_ ((chr ((((div (ord c, 100))) + ((ord '0'))))))))))
      ^
      ((string_str_ ((chr ((((div (mod_ (ord c, 100), 10))) + ((ord '0'))))))))))
    ^ ((string_str_ ((chr ((((mod_ (ord c, 10))) + ((ord '0')))))))));;
let rec toOctAscii c =
  ((((("\\" ^ ((string_str_ ((chr ((((div (ord c, 64))) + ((ord '0'))))))))))
      ^
      ((string_str_ ((chr ((((div (mod_ (ord c, 64), 8))) + ((ord '0'))))))))))
    ^ ((string_str_ ((chr ((((mod_ (ord c, 8))) + ((ord '0')))))))));;
let rec toString =
  (function 
            | '\\' -> "\\\\"
            | '"' -> "\\\""
            | 'a' -> "\\a"
            | 'b' -> "\\b"
            | 't' -> "\\t"
            | '\n' -> "\\n"
            | 'v' -> "\\v"
            | 'f' -> "\\f"
            | 'r' -> "\\r"
            | c -> begin
                if (((ord c)) < 32) then (toControl c) else begin
                if (((ord c)) >= 127) then (toAscii c) else
                (string_str_ c) end end);;
let rec toCString =
  (function 
            | '\\' -> "\\\\"
            | '"' -> "\\\""
            | '?' -> "\\?"
            | '\'' -> "\\'"
            | 'a' -> "\\a"
            | 'b' -> "\\b"
            | 't' -> "\\t"
            | '\n' -> "\\n"
            | 'v' -> "\\v"
            | 'f' -> "\\f"
            | 'r' -> "\\r"
            | c -> begin
                if (isPrint c) then (string_str_ c) else (toOctAscii c)
                end);;
let rec isOctDigit c = ((('0' <= c)) && ((c <= '7')));;
let rec value c =
  (((ord ((toUpper c)))) -
    (begin if (c < 'A') then (ord '0') else (((ord 'A')) - 10) end));;
let ( >>= ) opt f = match opt with None -> None | Some x -> f x;;
let rec scanAscii getc src0 =
  (getc
  src0
  >>=
  ((function 
             | (c1, src1)
                 -> (getc
                    src1
                    >>=
                    ((function 
                               | (c2, src2)
                                   -> (getc
                                      src2
                                      >>=
                                      ((function 
                                                 | (c3, src3) -> begin
                                                     if
                                                     (List.all
                                                     isDigit
                                                     [c1; c2; c3]) then
                                                     (let i =
                                                        (((((100 *
                                                              ((value c1))))
                                                            +
                                                            ((10 *
                                                               ((value
                                                                c2))))))
                                                          + ((value c3)))
                                                      in begin
                                                      if (i <= 255) then
                                                      (Some
                                                       ((chr i), src3))
                                                      else None end)
                                                     else None end)))))))));;
let rec scanUnicode getc src0 =
  (getc
  src0
  >>=
  ((function 
             | (c1, src1)
                 -> (getc
                    src1
                    >>=
                    ((function 
                               | (c2, src2)
                                   -> (getc
                                      src2
                                      >>=
                                      ((function 
                                                 | (c3, src3)
                                                     -> (getc
                                                        src3
                                                        >>=
                                                        ((function 
                                                          
                                                          | (c4, src4)
                                                              -> begin
                                                              if
                                                              (List.all
                                                              isHexDigit
                                                              [c1; c2;
                                                               c3; c4])
                                                              then
                                                              (try 
                                                               (Some
                                                                ((chr
                                                                ((((((((4096
                                                                *
                                                                ((value
                                                                c1)))) +
                                                                ((256 *
                                                                ((value
                                                                c2))))))
                                                                +
                                                                ((16 *
                                                                ((value
                                                                c3))))))
                                                                +
                                                                ((value
                                                                c4))))),
                                                                src4))
                                                               with 
                                                               
                                                               | 
                                                               Chr
                                                                -> None)
                                                              else None
                                                              end))))))))))));;
let rec scanControl getc src =
  (getc
  src
  >>=
  ((function 
             | (c, src_prime) -> begin
                 if (((64 <= ((ord c)))) && ((((ord c)) < 96))) then
                 (Some ((chr ((((ord c)) - 64))), src_prime)) else None
                 end)));;
let rec scanGap getc src =
  (getc
  src
  >>=
  ((function 
             | (c, src_prime) -> begin
                 if (c = '\\') then (Some src_prime) else begin
                 if (isSpace c) then (scanGap getc src_prime) else None
                 end end)));;
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
                                   if (((c1 = '\\')) && ((isSpace c2)))
                                   then
                                   (scanGap
                                   getc
                                   src_prime_prime
                                   >>=
                                   scanOptGap
                                   getc) else None end))))))
and scanOptGap getc src =
  (Some ((Option.getOpt ((scanOptGap_prime getc src), src))));;
let rec scanEscape getc src =
  (getc
  src
  >>=
  ((function 
             | (c, src_prime) -> begin
                 if (isDigit c) then (scanAscii getc src) else begin
                 if (isSpace c) then
                 (scanGap getc src_prime >>= scan_prime getc) else
                 begin
                 match c
                 with 
                      | 'a' -> (Some ('a', src_prime))
                      | 'b' -> (Some ('b', src_prime))
                      | 't' -> (Some ('t', src_prime))
                      | 'n' -> (Some ('\n', src_prime))
                      | 'v' -> (Some ('v', src_prime))
                      | 'f' -> (Some ('f', src_prime))
                      | 'r' -> (Some ('r', src_prime))
                      | '\\' -> (Some ('\\', src_prime))
                      | '"' -> (Some ('"', src_prime))
                      | '^' -> (scanControl getc src_prime)
                      | 'u' -> (scanUnicode getc src_prime)
                      | _ -> None
                 end end end)))
and scan_prime getc src =
  (getc
  src
  >>=
  ((function 
             | (c, src_prime) -> begin
                 if (c = '\\') then (scanEscape getc src_prime) else
                 begin
                 if (isPrint c) then (Some (c, src_prime)) else None end
                 end)));;
let rec scan getc src =
  (scan_prime
  getc
  src
  >>=
  ((function 
             | (c, src_prime)
                 -> (scanOptGap
                    getc
                    src_prime
                    >>=
                    ((function 
                               | src_prime_prime
                                   -> (Some (c, src_prime_prime))))))));;
let rec scanCAscii_prime arg__2 arg__3 arg__4 arg__5 =
  begin
  match (arg__2, arg__3, arg__4, arg__5)
  with 
       | (i, 3, getc, src) -> (Some (i, 3, src))
       | (i, k, getc, src)
           -> begin
              match (getc src)
              with 
                   | None -> (Some (i, k, src))
                   | (Some (c, src_prime)) -> begin
                       if (isOctDigit c) then
                       (scanCAscii_prime
                       ((((8 * i)) + ((value c))))
                       ((k + 1))
                       getc
                       src_prime) else (Some (i, k, src)) end
              end
  end;;
let rec scanCAscii getc src =
  (scanCAscii_prime
  0
  0
  getc
  src
  >>=
  ((function 
             | (i, k, src_prime) -> begin
                 if (k = 0) then None else
                 (try (Some ((chr i), src_prime)) with 
                                                       | Chr -> None)
                 end)));;
let rec scanCUnicode_prime i k getc src =
  begin
  match (getc src)
  with 
       | None -> (Some (i, k, src))
       | (Some (c, src_prime)) -> begin
           if (isHexDigit c) then
           (scanCUnicode_prime
           ((((16 * i)) + ((value c))))
           ((k + 1))
           getc
           src_prime) else (Some (i, k, src)) end
  end;;
let rec scanCUnicode getc src =
  (((try (scanCUnicode_prime 0 0 getc src) with 
                                                | Overflow -> None))
  >>=
  ((function 
             | (i, k, src_prime) -> begin
                 if (k = 0) then None else
                 (try (Some ((chr i), src_prime)) with 
                                                       | Chr -> None)
                 end)));;
let rec scanCEscape getc src =
  (getc
  src
  >>=
  ((function 
             | (c, src_prime) -> begin
                 if (isDigit c) then (scanCAscii getc src) else
                 begin
                 match c
                 with 
                      | 'a' -> (Some ('a', src_prime))
                      | 'b' -> (Some ('b', src_prime))
                      | 't' -> (Some ('t', src_prime))
                      | 'n' -> (Some ('\n', src_prime))
                      | 'v' -> (Some ('v', src_prime))
                      | 'f' -> (Some ('f', src_prime))
                      | 'r' -> (Some ('r', src_prime))
                      | '?' -> (Some ('?', src_prime))
                      | '\\' -> (Some ('\\', src_prime))
                      | '"' -> (Some ('"', src_prime))
                      | '\'' -> (Some ('\'', src_prime))
                      | '^' -> (scanControl getc src_prime)
                      | 'x' -> (scanCUnicode getc src_prime)
                      | _ -> None
                 end end)));;
let rec scanC getc src =
  (getc
  src
  >>=
  ((function 
             | (c, src_prime) -> begin
                 if (c = '\\') then (scanCEscape getc src_prime) else
                 begin
                 if (isPrint c) then (Some (c, src_prime)) else None end
                 end)));;
let rec reader s i =
  (try (Some ((string_sub_ (s, i)), (i + 1))) with 
                                                   | Subscript -> None);;
let rec scanString f s =
  (Option.map
  ((fun (r, _) -> r))
  (((f ((reader s)) 0) : ('a * int) option)));;
let fromString = (scanString scan);;
let fromCString = (scanString scanC);;
let compare_ (a, b) = Stdlib.compare a b;;
let rec compare (c1, c2) = begin
  if (Stdlib.( < ) c1 c2) then LESS else begin if (c1 = c2) then EQUAL else GREATER
  end end;;
