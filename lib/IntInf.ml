open Int
open Word

module type INT_INF = sig
  include INTEGER
  module Int : INTEGER
  module Word : WORD

  val divMod : int * int -> int * int
  val quotRem : int * int -> int * int
  val pow : int * Int.int -> int
  val log2 : int -> Int.int
  val orb : int * int -> int
  val xorb : int * int -> int
  val andb : int * int -> int
  val notb : int -> int
  val ( << ) : int * Word.word -> int
  val ( ~>> ) : int * Word.word -> int
end

module IntInf (Int : INTEGER) (Word : WORD) : INT_INF = struct
  include Int
  module Int = Int
  module Word = Word

  let divMod : int * int -> int * int = fun (a, b) -> (div (a, b), mod_ (a, b))
  let quotRem : int * int -> int * int = fun (a, b) -> (quot (a, b), rem (a, b))

  let pow : int * Int.int -> int =
   fun (base, exp) ->
    let e = Int.toInt exp in
    begin if Stdlib.( < ) e 0 then raise Exceptions.Domain
    else
      let one = fromInt 1 in
      let rec loop b e =
        begin if e = 0 then one
        else begin
          if e = 1 then b
          else
            let half = loop b (e / 2) in
            begin if e mod 2 = 0 then half * half else half * half * b
            end
        end
        end
      in
      loop base e
    end

  let log2 : int -> Int.int =
   fun i ->
    let n = toInt i in
    begin if Stdlib.( <= ) n 0 then raise Exceptions.Domain
    else
      let rec loop n k =
        begin if n = 1 then k else loop (n / 2) (Stdlib.( + ) k 1)
        end
      in
      Int.fromInt (loop n 0)
    end

  let orb : int * int -> int = fun (a, b) -> fromInt (toInt a lor toInt b)
  let xorb : int * int -> int = fun (a, b) -> fromInt (toInt a lxor toInt b)
  let andb : int * int -> int = fun (a, b) -> fromInt (toInt a land toInt b)
  let notb : int -> int = fun a -> fromInt (lnot (toInt a))

  let ( << ) : int * Word.word -> int =
   fun (i, w) -> fromInt (toInt i lsl Word.toInt w)

  let ( ~>> ) : int * Word.word -> int =
   fun (i, w) -> fromInt (toInt i asr Word.toInt w)
end
