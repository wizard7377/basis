open Time
open General.General
open StringCvt
type date__ = {
  year : int;
  month : int;
  day : int;
  hour : int;
  minute : int;
  second : int;
  offset : Time.time option
}
module type DATE = sig 
  type weekday = Mon | Tue | Wed | Thu | Fri | Sat | Sun
type month
  = Jan
  | Feb
  | Mar
  | Apr
  | May
  | Jun
  | Jul
  | Aug
  | Sep
  | Oct
  | Nov
  | Dec
type date

exception Date


val date : date__ -> date

val year    : date -> int
val month   : date -> month
val day     : date -> int
val hour    : date -> int
val minute  : date -> int
val second  : date -> int
val weekDay : date -> weekday
val yearDay : date -> int
val offset  : date -> Time.time option
val isDst   : date -> bool option

val localOffset : unit -> Time.time

val fromTimeLocal : Time.time -> date
val fromTimeUniv  : Time.time -> date
val toTime : date -> Time.time

val compare : date * date -> order

val fmt      : string -> date -> string
val toString : date -> string
val scan       : (char, 'a) StringCvt.reader
                   -> (date, 'a) StringCvt.reader
val fromString : string -> date option
end

module Date : DATE = struct 
  type weekday = Mon | Tue | Wed | Thu | Fri | Sat | Sun
type month
  = Jan
  | Feb
  | Mar
  | Apr
  | May
  | Jun
  | Jul
  | Aug
  | Sep
  | Oct
  | Nov
  | Dec
type date

exception Date


let  date : date__ -> date = assert false

let  year    : date -> int = assert false
let  month   : date -> month = assert false
let  day     : date -> int = assert false
let  hour    : date -> int = assert false
let  minute  : date -> int = assert false
let  second  : date -> int = assert false
let  weekDay : date -> weekday = assert false
let  yearDay : date -> int = assert false
let  offset  : date -> Time.time option = assert false
let  isDst   : date -> bool option = assert false

let  localOffset : unit -> Time.time = assert false

let  fromTimeLocal : Time.time -> date = assert false
let  fromTimeUniv  : Time.time -> date = assert false
let  toTime : date -> Time.time = assert false

let  compare : date * date -> order = assert false

let  fmt      : string -> date -> string = assert false
let  toString : date -> string = assert false
let scan       : (char, 'a) StringCvt.reader
                   -> (date, 'a) StringCvt.reader = assert false
let  fromString : string -> date option = assert false
end
