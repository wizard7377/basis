[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
module LargeReal = struct
                     type nonrec real = real;;
                     end;;
module LargeInt = struct
                    type nonrec int = int;;
                    end;;
module StringCvt = struct
                     type nonrec ('a, 'b) reader = ('b -> ('a * 'b) option);;
                     end;;
module type TIME = sig
                   type nonrec time
                   exception Time
                   val zeroTime : time
                   val fromReal : (LargeReal.real -> time)
                   val toReal : (time -> LargeReal.real)
                   val toSeconds : (time -> LargeInt.int)
                   val toMilliseconds : (time -> LargeInt.int)
                   val toMicroseconds : (time -> LargeInt.int)
                   val toNanoseconds : (time -> LargeInt.int)
                   val fromSeconds : (LargeInt.int -> time)
                   val fromMilliseconds : (LargeInt.int -> time)
                   val fromMicroseconds : (LargeInt.int -> time)
                   val fromNanoseconds : (LargeInt.int -> time)
                   val ( + ) : (time * time -> time)
                   val ( - ) : (time * time -> time)
                   val compare : (time * time -> order)
                   val ( < ) : (time * time -> bool)
                   val ( <= ) : (time * time -> bool)
                   val ( > ) : (time * time -> bool)
                   val ( >= ) : (time * time -> bool)
                   val now : (unit -> time)
                   val fmt : (int -> time -> string)
                   val toString : (time -> string)
                   val
                     scan : ((char, 'a)
                             StringCvt.reader ->
                             (time, 'a)
                             StringCvt.reader)
                   val fromString : (string -> time option)
                   end;;
