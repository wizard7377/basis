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
  type time = float
  exception Time

  let zeroTime : time = 0.0
  let fromReal : float -> time = fun r ->
    begin if r < 0.0 then raise Time
    else r
    end
  ;;
  let toReal : time -> float = fun t -> t
  ;;
  let toSeconds (t : time) : int = int_of_float t
  ;;
  let toMilliseconds (t : time) : int = int_of_float (t *. 1000.0)
  ;;
  let toMicroseconds (t : time) : int = int_of_float (t *. 1000000.0)
  ;;
  let toNanoseconds (t : time) : int = int_of_float (t *. 1000000000.0)
  ;;
  let fromSeconds (n : int) : time = float_of_int n
  ;;
  let fromMilliseconds (n : int) : time = float_of_int n /. 1000.0
  ;;
  let fromMicroseconds (n : int) : time = float_of_int n /. 1000000.0
  ;;
  let fromNanoseconds (n : int) : time = float_of_int n /. 1000000000.0
  ;;
  let ( + ) : time -> time -> time = fun a b -> a +. b
  ;;
  let ( - ) : time -> time -> time = fun a b ->
    let r = a -. b in
    begin if r < 0.0 then raise Time
    else r
    end
  ;;

  let compare : time * time -> order = fun (a, b) ->
    begin if a < b then Less
    else begin if a = b then Equal else Greater end
    end
  ;;
  let ( < ) : time -> time -> bool = fun a b -> Stdlib.( < ) a b
  ;;
  let ( <= ) : time -> time -> bool = fun a b -> Stdlib.( <= ) a b
  ;;
  let ( > ) : time -> time -> bool = fun a b -> Stdlib.( > ) a b
  ;;
  let ( >= ) : time -> time -> bool = fun a b -> Stdlib.( >= ) a b
  ;;

  let now : unit -> time = fun () -> Unix.gettimeofday ()
  ;;

  let fmt : int -> time -> string = fun n t ->
    let s = Printf.sprintf "%.*f" (Stdlib.max 0 n) t in
    s
  ;;
  let toString : time -> string = fun t -> fmt 3 t
  ;;
  let scan : (char, 'a) StringCvt.reader -> (time, 'a) StringCvt.reader = fun getc src ->
    let src = StringCvt.skipWS getc src in
    let is_digit c = Stdlib.( >= ) c '0' && Stdlib.( <= ) c '9' in
    let rec scanDigits src acc has_digit =
      begin match getc src with
      | Some (c, src') when is_digit c ->
        scanDigits src' (acc ^ Stdlib.String.make 1 c) true
      | _ -> (acc, src, has_digit)
      end
    in
    let (whole, src, has_whole) = scanDigits src "" false in
    begin match getc src with
    | Some ('.', src') ->
      let (frac, src'', has_frac) = scanDigits src' "" false in
      begin if has_whole || has_frac then
        begin match float_of_string_opt (whole ^ "." ^ frac) with
        | Some f -> Some (f, src'')
        | None -> None
        end
      else None
      end
    | _ ->
      begin if has_whole then
        begin match float_of_string_opt whole with
        | Some f -> Some (f, src)
        | None -> None
        end
      else None
      end
    end
  ;;
  let fromString : string -> time option = fun s ->
    StringCvt.scanString scan s
  ;;

end
