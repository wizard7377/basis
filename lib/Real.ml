[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Notes:\n * - Incomplete\n * - toString is currently implemented as primitive (it shouldn't be).\n *)|}];;
type nonrec real = real;;
let ( + ) = ( +. );;
let ( - ) = ( -. );;
let ( * ) = ( *. );;
let ( / ) = ( /. );;
let ( ~- ) x = Float.neg x;;
let abs = Float.abs;;
module Math = Math;;
module IEEE = IEEEReal;;
[@@@sml.comment
  {|(* Not supported by all implementations:\n  val radix                   = use{b = \"Real.radix\"} () : int\n  val precision               = use{b = \"Real.precision\"} () : int\n\n  val maxFinite               = use{b = \"Real.maxFinite\"} () : real\n  val minPos                  = use{b = \"Real.minPos\"} () : real\n  val minNormalPos            = use{b = \"Real.minNormalPos\"} () : real\n*)|}];;
let posInf = (1.0 /. 0.0);;
let negInf = ((-1.0) /. 0.0);;
let rec toLarge x = x;;
let rec fromLarge _ x = x;;
let fromInt = ((use { b = "Real.fromInt"} ) : (Int.int -> real));;
let floor = ((use { b = "Real.floor"} ) : (real -> Int.int));;
let ceil = ((use { b = "Real.ceil"} ) : (real -> Int.int));;
let trunc = ((use { b = "Real.trunc"} ) : (real -> Int.int));;
let round = ((use { b = "Real.round"} ) : (real -> Int.int));;
[@@@sml.comment
  {|(* Not supported by all implementations:\n  val realFloor               = use{b = \"Real.realFloor\"} : real -> real\n  val realCeil                = use{b = \"Real.realCeil\"}  : real -> real\n  val realTrunc               = use{b = \"Real.realTrunc\"} : real -> real\n  val realRound               = use{b = \"Real.realRound\"} : real -> real\n*)|}];;
let rec toInt =
  (function 
            | IEEE.To_neginf -> floor
            | IEEE.To_posinf -> ceil
            | IEEE.To_zero -> trunc
            | IEEE.To_nearest -> round);;
let toLargeInt = toInt;;
let fromLargeInt = fromInt;;
[@@@sml.comment
  {|(*\n  val toDecimal : real -> IEEEReal.decimal_approx\n  val fromDecimal : IEEEReal.decimal_approx -> real\n*)|}];;
[@@@sml.comment
  {|(* Not supported by all implementations:\n  val rem                     = use{b = \"Real.rem\"} : real * real -> real\n*)|}];;
let rec ( *+ ) (x, y, z) = (((x * y)) + z);;
let rec ( *- ) (x, y, z) = (((x * y)) - z);;
let ( == ) = ((use { b = "Real.=="} ) : (real * real -> bool));;
let ( ?= ) = ((use { b = "Real.?="} ) : (real * real -> bool));;
let ( != ) = (o Bool.not ( == ));;
let rec compareReal (i, j) = begin
  if (i < j) then IEEE.Less else begin
  if (( == ) (i, j)) then IEEE.Equal else begin
  if (i > j) then IEEE.Greater else IEEE.Unordered end end end;;
let rec compare (i, j) =
  begin
  match (compareReal (i, j))
  with 
       | IEEE.Less -> LESS
       | IEEE.Equal -> EQUAL
       | IEEE.Greater -> GREATER
       | IEEE.Unordered -> (raise IEEE.Unordered)
  end;;
let isFinite = ((use { b = "Real.isFinite"} ) : (real -> bool));;
let isNan = ((use { b = "Real.isNan"} ) : (real -> bool));;
[@@@sml.comment
  {|(* Not supported by all implementations:\n  val isNormal                = use{b = \"Real.isNormal\"}   : real -> bool\n*)|}];;
let signBit = ((use { b = "Real.signBit"} ) : (real -> bool));;
let checkFloat = ((use { b = "Real.checkFloat"} ) : (real -> real));;
let copySign = ((use { b = "Real.copySign"} ) : (real * real -> real));;
[@@@sml.comment
  {|(* Not supported by all implementations:\n  val nextAfter               = use{b = \"Real.nextAfter\"}  : real * real -> real\n*)|}];;
let rec min (x, y) = begin if (x < y) then x else y end;;
let rec max (x, y) = begin if (x > y) then x else y end;;
let rec sign x = begin
  if (( == ) (x, 0.0)) then 0 else begin if (x > 0.0) then 1 else (-1)
  end end;;
let rec sameSign (x, y) = (((signBit x)) = ((signBit y)));;
let rec unordered (x, y) = (((isNan x)) || ((isNan y)));;
[@@@sml.comment
  {|(*\n  fun class x                 = if isNan x then IEEE.NAN\n                                else if Bool.not(isFinite x) then IEEE.INF\n                                else if ==(x, 0.0) then IEEE.ZERO\n                                else if isNormal x then IEEE.NORMAL\n                                else IEEE.SUBNORMAL\n*)|}];;
[@@@sml.comment
  {|(*\n     val toManExp : real -> {man : real, exp : int}\n     val fromManExp : {man : real, exp : int} -> real\n     val split : real -> {whole : real, frac : real}\n\n     val fmt : StringCvt.realfmt -> real -> string\n*)|}];;
let rec value c = (fromInt ((Stdlib.( - ) (Char.ord c) (Char.ord '0'))));;
let ( >>= ) opt f = match opt with None -> None | Some x -> f x;;
let rec scanSign getc src =
  begin
  match (getc src)
  with 
       | (Some ('-', src_prime)) -> (Some ((-1.0), src_prime))
       | (Some ('~', src_prime)) -> (Some ((-1.0), src_prime))
       | (Some ('+', src_prime)) -> (Some (1.0, src_prime))
       | _ -> (Some (1.0, src))
  end;;
let rec scanTextual ss getc src = begin
  if (((Substring.size ss)) = 0) then (Some src) else
  (getc
  src
  >>=
  ((function 
             | (c, src_prime) -> begin
                 if (((Char.toLower c)) = ((Substring.sub (ss, 0)))) then
                 (scanTextual ((Substring.triml 1 ss)) getc src_prime)
                 else None end)))
  end;;
let rec scanFractional_prime r d getc src =
  begin
  match (getc src)
  with 
       | (Some (c, src_prime)) -> begin
           if (Char.isDigit c) then
           (scanFractional_prime
           ((r + ((d * ((value c))))))
           ((d / 10.0))
           getc
           src_prime) else (r, src) end
       | None -> (r, src)
  end;;
let rec scanFractional getc src =
  (getc
  src
  >>=
  ((function 
             | (c, src_prime) -> begin
                 if (Char.isDigit c) then
                 (Some ((scanFractional_prime 0.0 0.1 getc src))) else
                 None end)));;
let rec scanMantissa_prime r getc src =
  begin
  match (getc src)
  with 
       | (Some ('.', src_prime))
           -> begin
              match (scanFractional getc src_prime)
              with 
                   | (Some (r_prime, src_prime_prime))
                       -> ((r + r_prime), src_prime_prime)
                   | None -> (r, src)
              end
       | (Some (c, src_prime)) -> begin
           if (Char.isDigit c) then
           (scanMantissa_prime
           ((((10.0 * r)) + ((value c))))
           getc
           src_prime) else (r, src) end
       | None -> (r, src)
  end;;
let rec scanMantissa getc src =
  (getc
  src
  >>=
  ((function 
             | (c, src_prime) -> begin
                 if (c = '.') then (scanFractional getc src_prime) else
                 begin
                 if (Char.isDigit c) then
                 (Some ((scanMantissa_prime 0.0 getc src))) else None end
                 end)));;
let rec scanExp_prime_prime exp getc src =
  begin
  match (getc src)
  with 
       | (Some (c, src_prime)) -> begin
           if (Char.isDigit c) then
           (scanExp_prime_prime
           ((((10.0 * exp)) + ((value c))))
           getc
           src_prime) else (Some (exp, src)) end
       | None -> (Some (exp, src))
  end;;
let rec scanExp_prime getc src =
  (scanSign
  getc
  src
  >>=
  ((function 
             | (sign, src1)
                 -> (getc
                    src1
                    >>=
                    ((function 
                               | (c, _) -> begin
                                   if (Char.isDigit c) then
                                   (scanExp_prime_prime
                                   0.0
                                   getc
                                   src1
                                   >>=
                                   ((function 
                                              | (r, src2)
                                                  -> (Some
                                                      ((sign * r), src2)))))
                                   else None end))))));;
let rec scanExp getc src =
  (getc
  src
  >>=
  ((function 
             | (c, src_prime) -> begin
                 if (((c = 'e')) || ((c = 'E'))) then
                 (scanExp_prime getc src_prime) else None end)));;
let rec scan getc src =
  (scanSign
  getc
  ((StringCvt.skipWS getc src))
  >>=
  ((function 
             | (sign, src1)
                 -> begin
                    match (scanTextual
                          ((Substring.full "infinity"))
                          getc
                          src1)
                    with 
                         | (Some src2) -> (Some ((sign * posInf), src2))
                         | None
                             -> begin
                                match (scanTextual
                                      ((Substring.full "inf"))
                                      getc
                                      src1)
                                with 
                                     | (Some src2)
                                         -> (Some
                                             ((sign * posInf), src2))
                                     | None
                                         -> begin
                                            match (scanTextual
                                                  ((Substring.full "nan"))
                                                  getc
                                                  src1)
                                            with 
                                                 | (Some src2)
                                                     -> (Some
                                                         ((0.0 * posInf),
                                                          src2))
                                                 | None
                                                     -> (scanMantissa
                                                        getc
                                                        src1
                                                        >>=
                                                        ((function 
                                                          
                                                          | (man, src2)
                                                              -> 
                                                              begin
                                                              match 
                                                              (scanExp
                                                              getc
                                                              src2)
                                                              with 
                                                              
                                                              | None
                                                                -> 
                                                                (Some
                                                                ((sign *
                                                                man),
                                                                src2))
                                                              | (Some
                                                                (exp,
                                                                src3))
                                                                -> 
                                                                (Some
                                                                (begin
                                                                if
                                                                (( == )
                                                                (man,
                                                                0.0))
                                                                then 0.0
                                                                else
                                                                (((sign *
                                                                man)) *
                                                                ((Math.pow
                                                                (10.0,
                                                                exp))))
                                                                end,
                                                                src3))
                                                              end)))
                                            end
                                end
                    end)));;
let toString = ((use { b = "Real.toString"} ) : (real -> string));;
let fromString = (StringCvt.scanString scan);;
