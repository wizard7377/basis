[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
type nonrec time = real;;
exception Time;;
let zeroTime = 0.0;;
let rec toReal t = t;;
let rec fromReal t = begin
  if (((Real.isNan t)) || ((Bool.not ((Real.isFinite t))))) then (raise Time)
  else t end;;
let rec toSeconds t = (Real.trunc t);;
let rec toMilliseconds t = (Real.trunc (t *. 1e3));;
let rec toMicroseconds t = (Real.trunc (t *. 1e6));;
let rec toNanoseconds t = (Real.trunc (t *. 1e9));;
let rec fromSeconds n = (Real.fromInt n);;
let rec fromMilliseconds n = ((Real.fromInt n) /. 1e3);;
let rec fromMicroseconds n = ((Real.fromInt n) /. 1e6);;
let rec fromNanoseconds n = ((Real.fromInt n) /. 1e9);;
let rec pow10 n = begin
  if (Stdlib.( <= ) n 0) then 1
  else (Stdlib.( * ) 10 ((pow10 (Stdlib.( - ) n 1)))) end;;
let rec fmt_digits (n, i) = begin
  if (Stdlib.( <= ) n 0) then "" else
  (((fmt_digits ((Stdlib.( - ) n 1), (div (i, 10))))) ^
   ((Int.toString ((mod_ (i, 10)))))) end;;
let rec fmt n t =
  let sign = begin if (t < 0.0) then "~" else "" end in
  let t_prime = (Float.abs t) in
  let whole = (Real.trunc t_prime) in
  begin
  if (Stdlib.( <= ) n 0) then (sign ^ ((Int.toString whole))) else
  let frac = (t_prime -. ((Real.fromInt whole))) in
  let digits = (Real.trunc (frac *. ((Real.fromInt ((pow10 n)))))) in
  (sign ^ ((Int.toString whole)) ^ "." ^ ((fmt_digits (n, digits))))
  end;;
let toString = (fmt 3);;
let ( + ) (t1, t2) = (t1 +. t2);;
let ( - ) (t1, t2) = begin
  let t = (t1 -. t2) in begin
  if (t < 0.0) then (raise Time) else t end end;;
let rec compare (t1, t2) = begin
  if (t1 < t2) then LESS else begin
  if (Real.( == ) (t1, t2)) then EQUAL else GREATER end end;;
let ( < ) (t1, t2) = (t1 < t2);;
let ( <= ) (t1, t2) = (t1 <= t2);;
let ( > ) (t1, t2) = (t1 > t2);;
let ( >= ) (t1, t2) = (t1 >= t2);;
let now = ((use { b = "Time.now"} ) : (unit -> time));;
let ( >>= ) opt f = match opt with None -> None | Some x -> f x;;
let rec scanSign getc src =
  begin
  match (getc src)
  with
       | (Some ('~', src_prime)) -> (Some (true, src_prime))
       | (Some ('-', src_prime)) -> (Some (true, src_prime))
       | (Some ('+', src_prime)) -> (Some (false, src_prime))
       | _ -> (Some (false, src))
  end;;
let rec scanDigits_prime (r, getc, src) =
  begin
  match (getc src)
  with
       | (Some (c, src_prime)) -> begin
           if (Char.isDigit c) then
           (scanDigits_prime
           (((r *. 10.0) +. ((Real.fromInt ((Stdlib.( - ) ((Char.ord c)) ((Char.ord '0'))))))),
            getc, src_prime))
           else (r, src) end
       | None -> (r, src)
  end;;
let rec scanDigits getc src =
  (getc
  src
  >>=
  ((function
             | (c, src_prime) -> begin
                 if (Char.isDigit c) then
                 (Some ((scanDigits_prime (0.0, getc, src)))) else None end)));;
let rec scanFrac_prime (r, d, getc, src) =
  begin
  match (getc src)
  with
       | (Some (c, src_prime)) -> begin
           if (Char.isDigit c) then
           (scanFrac_prime
           (((r +. (d *. ((Real.fromInt ((Stdlib.( - ) ((Char.ord c)) ((Char.ord '0'))))))))),
            (d /. 10.0), getc, src_prime))
           else (r, src) end
       | None -> (r, src)
  end;;
let rec scanFrac getc src =
  (getc
  src
  >>=
  ((function
             | ('.', src_prime)
                 -> (getc
                    src_prime
                    >>=
                    ((function
                               | (c, _) -> begin
                                   if (Char.isDigit c) then
                                   (Some ((scanFrac_prime (0.0, 0.1, getc, src_prime))))
                                   else None end)))
             | _ -> None)));;
let rec scan getc src =
  (scanSign
  getc
  ((StringCvt.skipWS getc src))
  >>=
  ((function
             | (neg, src1)
                 -> (scanDigits
                    getc
                    src1
                    >>=
                    ((function
                               | (whole, src2)
                                   -> begin
                                      match (scanFrac getc src2)
                                      with
                                           | (Some (frac, src3))
                                               -> let t = (whole +. frac) in
                                                  begin
                                                  if neg then (raise Time)
                                                  else (Some (t, src3)) end
                                           | None
                                               -> begin
                                                  if neg then (raise Time)
                                                  else (Some (whole, src2))
                                                  end
                                      end))))));;
let fromString = (StringCvt.scanString scan);;
