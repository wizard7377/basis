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
  val orb  : int * int -> int
  val xorb : int * int -> int
  val andb : int * int -> int
  val notb : int -> int
  val (<<) : int * Word.word -> int
  val (~>>) : int * Word.word -> int
end

module IntInf (Int : INTEGER) (Word : WORD) : INT_INF = struct 
  include Int
  module Int = Int
  module Word = Word
  let divMod  :  int * int -> int * int = assert false
  let quotRem  :  int * int -> int * int = assert false
  let pow  :  int * Int.int -> int = assert false
  let log2  :  int -> Int.int = assert false
  let orb   :  int * int -> int = assert false
  let xorb  :  int * int -> int = assert false
  let andb  :  int * int -> int = assert false
  let notb  :  int -> int = assert false
  let (<<)  :  int * Word.word -> int = assert false
  let (~>>)  :  int * Word.word -> int = assert false
end