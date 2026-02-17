[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note:\n * - Dropped deprecated {from,to}LargeWord functions.\n *)|}];;
type nonrec word = word;;
let wordSize = 8;;
let toLarge = ((use { b = "Word8.toLarge"} ) : (word -> Word.word));;
let toLargeX = ((use { b = "Word8.toLargeX"} ) : (word -> Word.word));;
let fromLarge = ((use { b = "Word8.fromLarge"} ) : (Word.word -> word));;
let toInt = ((use { b = "Word8.toInt"} ) : (word -> Int.int));;
let toIntX = ((use { b = "Word8.toIntX"} ) : (word -> Int.int));;
let fromInt = ((use { b = "Word8.fromInt"} ) : (Int.int -> word));;
let toLargeInt = toInt;;
[@@@sml.comment {|(* hm, what if Int <> LargeInt? *)|}];;
let toLargeIntX = toIntX;;
let fromLargeInt = fromInt;;
let notb = ((use { b = "Word8.notb"} ) : (word -> word));;
let orb = ((use { b = "Word8.orb"} ) : (word * word -> word));;
let xorb = ((use { b = "Word8.xorb"} ) : (word * word -> word));;
let andb = ((use { b = "Word8.andb"} ) : (word * word -> word));;
let ( << ) = ((use { b = "Word8.<<"} ) : (word * Word.word -> word));;
let ( >> ) = ((use { b = "Word8.>>"} ) : (word * Word.word -> word));;
let ( ~>> ) = ((use { b = "Word8.~>>"} ) : (word * Word.word -> word));;
let div = (div : (word * word -> word));;
let mod_ = (mod_ : (word * word -> word));;
let rec ( ~- ) w = (notb ((w - 1)));;
let rec compare (i, j) = begin
  if (i < j) then LESS else begin if (i = j) then EQUAL else GREATER end
  end;;
let rec min (i, j) = begin if (i < j) then i else j end;;
let rec max (i, j) = begin if (i > j) then i else j end;;
let rec fmt radix i = (Word.fmt radix ((toLarge i)));;
let rec scan radix getc src =
  begin
  match (Word.scan radix getc src)
  with 
       | None -> None
       | (Some (w, src_prime)) -> begin
           if (w > 0xff) then (raise Overflow) else
           (Some ((fromLarge w), src_prime)) end
  end;;
let toString = (fmt StringCvt.Hex);;
let fromString = (StringCvt.scanString ((scan StringCvt.Hex)));;
