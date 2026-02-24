open LargeReal
open LargeInt
open General 
open General
open StringCvt
module type TIME = sig
type time
exception Time
val zeroTime : time
val fromReal : float (* LARGEINT ? *) -> time
val toReal : time -> float (* LARGEINT ? *)
val toSeconds      : time -> int (* LARGEINT ? *)
val toMilliseconds : time -> int (* LARGEINT ? *)
val toMicroseconds : time -> int (* LARGEINT ? *)
val toNanoseconds  : time -> int (* LARGEINT ? *)
val fromSeconds      : int (* LARGEINT ? *) -> time
val fromMilliseconds : int (* LARGEINT ? *) -> time
val fromMicroseconds : int (* LARGEINT ? *) -> time
val fromNanoseconds  : int (* LARGEINT ? *) -> time
val ( + ) : time -> time -> time
val ( - ) : time -> time -> time

val compare : time * time -> order
val ( < ) : time -> time -> bool 
val ( <= ) : time -> time -> bool
val ( > ) : time -> time -> bool
val ( >= ) : time -> time -> bool

val now : unit -> time
 
val fmt      : int -> time -> string
val toString : time -> string
val scan       : (char, 'a) StringCvt.reader
                   -> (time, 'a) StringCvt.reader
val fromString : string -> time option
end

module Time : TIME = struct  
  type time = Ptime.t 
  exception Time
  let  zeroTime : time = assert false
let  fromReal : float (* LARGEINT ? *) -> time = assert false
let  toReal : time -> float (* LARGEINT ? *) = assert false
let  toSeconds      : time -> int (* LARGEINT ? *) = assert false
let  toMilliseconds : time -> int (* LARGEINT ? *) = assert false
let  toMicroseconds : time -> int (* LARGEINT ? *) = assert false
let  toNanoseconds  : time -> int (* LARGEINT ? *) = assert false
let  fromSeconds      : int (* LARGEINT ? *) -> time = assert false
let  fromMilliseconds : int (* LARGEINT ? *) -> time = assert false
let  fromMicroseconds : int (* LARGEINT ? *) -> time = assert false
let  fromNanoseconds  : int (* LARGEINT ? *) -> time = assert false
let  ( + ) : time -> time -> time = assert false
let  ( - ) : time -> time -> time = assert false

let  compare : time * time -> order = assert false
let  ( < ) : time -> time -> bool  = assert false
let  ( <= ) : time -> time -> bool = assert false
let  ( > ) : time -> time -> bool = assert false
let  ( >= ) : time -> time -> bool = assert false

let  now : unit -> time = assert false

let  fmt      : int -> time -> string = assert false
let  toString : time -> string = assert false
let scan       : (char, 'a) StringCvt.reader
                   -> (time, 'a) StringCvt.reader = assert false
let  fromString : string -> time option = assert false
  
end