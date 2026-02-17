[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note:\n * - Dropped deprecated {from,to}LargeWord functions.\n *)|}];;
module Word = struct
                type nonrec word = word;;
                end;;
module LargeWord = struct
                     type nonrec word = word;;
                     end;;
module LargeInt = struct
                    type nonrec int = int;;
                    end;;
module type WORD = sig
                   type nonrec word
                   val wordSize : int
                   val toLarge : (word -> LargeWord.word)
                   val toLargeX : (word -> LargeWord.word)
                   val fromLarge : (LargeWord.word -> word)
                   val toLargeInt : (word -> LargeInt.int)
                   val toLargeIntX : (word -> LargeInt.int)
                   val fromLargeInt : (LargeInt.int -> word)
                   val toInt : (word -> Int.int)
                   val toIntX : (word -> Int.int)
                   val fromInt : (Int.int -> word)
                   val orb : (word * word -> word)
                   val xorb : (word * word -> word)
                   val andb : (word * word -> word)
                   val notb : (word -> word)
                   val ( << ) : (word * Word.word -> word)
                   val ( >> ) : (word * Word.word -> word)
                   val ( ~>> ) : (word * Word.word -> word)
                   val ( + ) : (word * word -> word)
                   val ( - ) : (word * word -> word)
                   val ( * ) : (word * word -> word)
                   val div : (word * word -> word)
                   val mod_ : (word * word -> word)
                   val ( ~- ) : (word -> word)
                   val compare : (word * word -> order)
                   val ( > ) : (word * word -> bool)
                   val ( < ) : (word * word -> bool)
                   val ( >= ) : (word * word -> bool)
                   val ( <= ) : (word * word -> bool)
                   val min : (word * word -> word)
                   val max : (word * word -> word)
                   val fmt : (StringCvt.radix -> word -> string)
                   val toString : (word -> string)
                   val
                     scan : (StringCvt.radix ->
                             (char, 'a)
                             StringCvt.reader ->
                             (word, 'a)
                             StringCvt.reader)
                   val fromString : (string -> word option)
                   end;;