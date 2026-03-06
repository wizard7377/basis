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
type date = {
  d_year : int;
  d_month : month;
  d_day : int;
  d_hour : int;
  d_minute : int;
  d_second : int;
  d_weekDay : weekday;
  d_yearDay : int;
  d_offset : Time.time option;
  d_isDst : bool option;
}

exception Date

let month_of_int n =
  begin match n with
  | 0 -> Jan | 1 -> Feb | 2 -> Mar | 3 -> Apr
  | 4 -> May | 5 -> Jun | 6 -> Jul | 7 -> Aug
  | 8 -> Sep | 9 -> Oct | 10 -> Nov | 11 -> Dec
  | _ -> raise Date
  end
;;

let int_of_month m =
  begin match m with
  | Jan -> 0 | Feb -> 1 | Mar -> 2 | Apr -> 3
  | May -> 4 | Jun -> 5 | Jul -> 6 | Aug -> 7
  | Sep -> 8 | Oct -> 9 | Nov -> 10 | Dec -> 11
  end
;;

let weekday_of_int n =
  begin match n with
  | 0 -> Sun | 1 -> Mon | 2 -> Tue | 3 -> Wed
  | 4 -> Thu | 5 -> Fri | 6 -> Sat
  | _ -> raise Date
  end
;;

let date_of_tm (tm : Unix.tm) (off : Time.time option) : date =
  { d_year = tm.Unix.tm_year + 1900;
    d_month = month_of_int tm.Unix.tm_mon;
    d_day = tm.Unix.tm_mday;
    d_hour = tm.Unix.tm_hour;
    d_minute = tm.Unix.tm_min;
    d_second = tm.Unix.tm_sec;
    d_weekDay = weekday_of_int tm.Unix.tm_wday;
    d_yearDay = tm.Unix.tm_yday;
    d_offset = off;
    d_isDst = begin if tm.Unix.tm_isdst then Some true else Some false end;
  }
;;

let date : date__ -> date = fun d ->
  begin if d.month < 0 || d.month > 11 then raise Date
  else begin if d.day < 1 || d.day > 31 then raise Date
  else begin if d.hour < 0 || d.hour > 23 then raise Date
  else begin if d.minute < 0 || d.minute > 59 then raise Date
  else begin if d.second < 0 || d.second > 61 then raise Date
  else
    let tm = { Unix.tm_sec = d.second;
               tm_min = d.minute;
               tm_hour = d.hour;
               tm_mday = d.day;
               tm_mon = d.month;
               tm_year = d.year - 1900;
               tm_wday = 0; tm_yday = 0; tm_isdst = false } in
    let (t, normalized) = Unix.mktime tm in
    ignore t;
    date_of_tm normalized d.offset
  end end end end end
;;

let year    : date -> int = fun d -> d.d_year
;;
let month   : date -> month = fun d -> d.d_month
;;
let day     : date -> int = fun d -> d.d_day
;;
let hour    : date -> int = fun d -> d.d_hour
;;
let minute  : date -> int = fun d -> d.d_minute
;;
let second  : date -> int = fun d -> d.d_second
;;
let weekDay : date -> weekday = fun d -> d.d_weekDay
;;
let yearDay : date -> int = fun d -> d.d_yearDay
;;
let offset  : date -> Time.time option = fun d -> d.d_offset
;;
let isDst   : date -> bool option = fun d -> d.d_isDst
;;

let localOffset : unit -> Time.time = fun () ->
  let t = Unix.gettimeofday () in
  let utc = Unix.gmtime t in
  let (local_t, _) = Unix.mktime utc in
  Time.fromReal (t -. local_t)
;;

let fromTimeLocal : Time.time -> date = fun t ->
  let tm = Unix.localtime (Time.toReal t) in
  date_of_tm tm None
;;

let fromTimeUniv : Time.time -> date = fun t ->
  let tm = Unix.gmtime (Time.toReal t) in
  date_of_tm tm (Some Time.zeroTime)
;;

let toTime : date -> Time.time = fun d ->
  let tm = { Unix.tm_sec = d.d_second;
             tm_min = d.d_minute;
             tm_hour = d.d_hour;
             tm_mday = d.d_day;
             tm_mon = int_of_month d.d_month;
             tm_year = d.d_year - 1900;
             tm_wday = 0; tm_yday = 0; tm_isdst = false } in
  let (t, _) = Unix.mktime tm in
  begin match d.d_offset with
  | None -> Time.fromReal t
  | Some off ->
    let local_off = Time.toReal (localOffset ()) in
    Time.fromReal (t -. local_off +. Time.toReal off)
  end
;;

let compare : date * date -> order = fun (d1, d2) ->
  Time.compare (toTime d1, toTime d2)
;;

let weekday_name w =
  begin match w with
  | Sun -> "Sun" | Mon -> "Mon" | Tue -> "Tue" | Wed -> "Wed"
  | Thu -> "Thu" | Fri -> "Fri" | Sat -> "Sat"
  end
;;

let month_name m =
  begin match m with
  | Jan -> "Jan" | Feb -> "Feb" | Mar -> "Mar" | Apr -> "Apr"
  | May -> "May" | Jun -> "Jun" | Jul -> "Jul" | Aug -> "Aug"
  | Sep -> "Sep" | Oct -> "Oct" | Nov -> "Nov" | Dec -> "Dec"
  end
;;

let fmt : string -> date -> string = fun fmtstr d ->
  let buf = Buffer.create 64 in
  let len = Stdlib.String.length fmtstr in
  let rec loop i =
    begin if i >= len then ()
    else begin match Stdlib.String.get fmtstr i with
    | '%' when i + 1 < len ->
      let c = Stdlib.String.get fmtstr (i + 1) in
      begin match c with
      | 'a' -> Buffer.add_string buf (weekday_name d.d_weekDay)
      | 'A' -> Buffer.add_string buf (begin match d.d_weekDay with
        | Sun -> "Sunday" | Mon -> "Monday" | Tue -> "Tuesday"
        | Wed -> "Wednesday" | Thu -> "Thursday" | Fri -> "Friday"
        | Sat -> "Saturday" end)
      | 'b' | 'h' -> Buffer.add_string buf (month_name d.d_month)
      | 'B' -> Buffer.add_string buf (begin match d.d_month with
        | Jan -> "January" | Feb -> "February" | Mar -> "March"
        | Apr -> "April" | May -> "May" | Jun -> "June"
        | Jul -> "July" | Aug -> "August" | Sep -> "September"
        | Oct -> "October" | Nov -> "November" | Dec -> "December" end)
      | 'd' -> Buffer.add_string buf (Printf.sprintf "%02d" d.d_day)
      | 'H' -> Buffer.add_string buf (Printf.sprintf "%02d" d.d_hour)
      | 'I' ->
        let h = begin if d.d_hour = 0 then 12
                 else begin if d.d_hour > 12 then d.d_hour - 12
                 else d.d_hour end end in
        Buffer.add_string buf (Printf.sprintf "%02d" h)
      | 'j' -> Buffer.add_string buf (Printf.sprintf "%03d" (d.d_yearDay + 1))
      | 'm' -> Buffer.add_string buf (Printf.sprintf "%02d" (int_of_month d.d_month + 1))
      | 'M' -> Buffer.add_string buf (Printf.sprintf "%02d" d.d_minute)
      | 'p' -> Buffer.add_string buf (begin if d.d_hour < 12 then "AM" else "PM" end)
      | 'S' -> Buffer.add_string buf (Printf.sprintf "%02d" d.d_second)
      | 'Y' -> Buffer.add_string buf (Printf.sprintf "%04d" d.d_year)
      | 'y' -> Buffer.add_string buf (Printf.sprintf "%02d" (d.d_year mod 100))
      | '%' -> Buffer.add_char buf '%'
      | 'n' -> Buffer.add_char buf '\n'
      | 't' -> Buffer.add_char buf '\t'
      | _ -> Buffer.add_char buf '%'; Buffer.add_char buf c
      end;
      loop (i + 2)
    | c -> Buffer.add_char buf c; loop (i + 1)
    end end
  in
  loop 0;
  Buffer.contents buf
;;

let toString : date -> string = fun d ->
  fmt "%a %b %d %H:%M:%S %Y" d
;;

let scan : (char, 'a) StringCvt.reader -> (date, 'a) StringCvt.reader = fun _getc _src ->
  None
;;

let fromString : string -> date option = fun _s ->
  None
;;
end
