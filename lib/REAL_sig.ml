[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note: Incomplete.\n *)|}];;
module LargeReal = struct
                     type nonrec real = real;;
                     end;;
module LargeInt = struct
                    type nonrec int = int;;
                    end;;
module type REAL = sig
                   type nonrec real
                   module Math : sig
                     type nonrec real
                     val pi : real
                     val e : real
                     val sqrt : (real -> real)
                     val sin : (real -> real)
                     val cos : (real -> real)
                     val tan : (real -> real)
                     val asin : (real -> real)
                     val acos : (real -> real)
                     val atan : (real -> real)
                     val atan2 : (real * real -> real)
                     val exp : (real -> real)
                     val pow : (real * real -> real)
                     val ln : (real -> real)
                     val log10 : (real -> real)
                     val sinh : (real -> real)
                     val cosh : (real -> real)
                     val tanh : (real -> real)
                   end
                   [@@@sml.comment
                     {|(*\n  val radix : int\n  val precision : int\n  val maxFinite : real\n  val minPos : real\n  val minNormalPos : real\n*)|}]
                   val posInf : real
                   val negInf : real
                   val ( + ) : (real * real -> real)
                   val ( - ) : (real * real -> real)
                   val ( * ) : (real * real -> real)
                   val ( / ) : (real * real -> real)
                   [@@@sml.comment
                     {|(*\n  val rem : real * real -> real\n*)|}]
                   val ( *+ ) : (real * real * real -> real)
                   val ( *- ) : (real * real * real -> real)
                   val ( ~- ) : (real -> real)
                   val abs : (real -> real)
                   val min : (real * real -> real)
                   val max : (real * real -> real)
                   val sign : (real -> int)
                   val signBit : (real -> bool)
                   val sameSign : (real * real -> bool)
                   val copySign : (real * real -> real)
                   val compare : (real * real -> order)
                   val compareReal : (real * real -> IEEEReal.real_order)
                   val ( < ) : (real * real -> bool)
                   val ( <= ) : (real * real -> bool)
                   val ( > ) : (real * real -> bool)
                   val ( >= ) : (real * real -> bool)
                   val ( == ) : (real * real -> bool)
                   val ( != ) : (real * real -> bool)
                   val op_qmark_eq : (real * real -> bool)
                   val unordered : (real * real -> bool)
                   val isFinite : (real -> bool)
                   val isNan : (real -> bool)
                   [@@@sml.comment
                     {|(*\n  val isNormal : real -> bool\n  val class : real -> IEEEReal.float_class\n  val fmt : StringCvt.realfmt -> real -> string\n*)|}]
                   val toString : (real -> string)
                   val
                     scan : ((char, 'a)
                             StringCvt.reader ->
                             (real, 'a)
                             StringCvt.reader)
                   val fromString : (string -> real option)
                   [@@@sml.comment
                     {|(*\n  val toManExp : real -> {man : real, exp : int}\n  val fromManExp : {man : real, exp : int} -> real\n  val split : real -> {whole : real, frac : real}\n  val realMod : real -> real\n  val nextAfter : real * real -> real\n*)|}]
                   val checkFloat : (real -> real)
                   [@@@sml.comment
                     {|(*\n  val realFloor : real -> real\n  val realCeil : real -> real\n  val realTrunc : real -> real\n  val realRound : real -> real\n*)|}]
                   val floor : (real -> int)
                   val ceil : (real -> int)
                   val trunc : (real -> int)
                   val round : (real -> int)
                   val toInt : (IEEEReal.rounding_mode -> real -> int)
                   val
                     toLargeInt : (IEEEReal.rounding_mode ->
                                   real ->
                                   LargeInt.int)
                   val fromInt : (int -> real)
                   val fromLargeInt : (LargeInt.int -> real)
                   val toLarge : (real -> LargeReal.real)
                   val
                     fromLarge : (IEEEReal.rounding_mode ->
                                  LargeReal.real ->
                                  real)
                   end;;
[@@@sml.comment
  {|(*\n  val toDecimal : real -> IEEEReal.decimal_approx\n  val fromDecimal : IEEEReal.decimal_approx -> real option\n*)|}];;