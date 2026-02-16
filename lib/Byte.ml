[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2002-2025\n *\n * Standard ML Basis Library\n *)|}];;
let rec byteToChar i = (Char.chr ((Word8.toInt i)));;
let rec charToByte c = (Word8.fromInt ((Char.ord c)));;
let rec stringToBytes s =
  (Word8Vector.tabulate
  ((CharVector.length s),
   (function 
             | i -> (charToByte ((CharVector.sub (s, i)))))));;
let rec bytesToString v =
  (CharVector.tabulate
  ((Word8Vector.length v),
   (function 
             | i -> (byteToChar ((Word8Vector.sub (v, i)))))));;
let rec unpackStringVec sl =
  (CharVector.tabulate
  ((Word8VectorSlice.length sl),
   (function 
             | i -> (byteToChar ((Word8VectorSlice.sub (sl, i)))))));;
let rec unpackString sl =
  (CharVector.tabulate
  ((Word8ArraySlice.length sl),
   (function 
             | i -> (byteToChar ((Word8ArraySlice.sub (sl, i)))))));;
let rec packString (arr, i, ss) =
  (Word8Array.copyVec
  { src = (stringToBytes ((Substring.string ss))); dst = arr; di = i} );;
