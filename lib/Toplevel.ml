include General.General
open General
open List
open String
open Real
open Char
open Option
open Vector
open TextIO
open Bool

let ( ! ) : 'a ref -> 'a = General.( ! )
let ( := ) : 'a ref -> 'a -> unit = General.( := )
let ( @ ) : 'a list -> 'a list -> 'a list = List.( @ )
let ( ^ ) : string -> string -> string = String.( ^ )
let app : ('a -> unit) -> 'a list -> unit = List.app
let before : 'a * unit -> 'a = General.before
let ceil : Real.real -> int = Real.ceil
let chr : int -> char = Char.chr
let concat : string list -> string = String.concat
let exnMessage : exn -> string = General.exnMessage
let exnName : exn -> string = General.exnName
let explode : string -> char list = String.explode
let floor : Real.real -> int = Real.floor
let foldl : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b = List.foldl
let foldr : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b = List.foldr
let getOpt : 'a option * 'a -> 'a = Option.getOpt
let hd : 'a list -> 'a = List.hd
let ignore : 'a -> unit = General.ignore
let implode : char list -> string = String.implode
let isSome : 'a option -> bool = Option.isSome
let length : 'a list -> int = List.length
let map : ('a -> 'b) -> 'a list -> 'b list = List.map
let not : bool -> bool = Bool.not
let null : 'a list -> bool = List.null
let o : ('a -> 'b) * ('c -> 'a) -> 'c -> 'b = General.o
let ord : char -> int = Char.ord
let print : string -> unit = TextIO.print
let real : int -> Real.real = Real.fromInt
let ref : 'a -> 'a ref = fun x -> ref x
let rev : 'a list -> 'a list = List.rev
let round : Real.real -> int = Real.round
let size : string -> int = String.size
let str : char -> string = String.str
let substring : string * int * int -> string = String.substring
let tl : 'a list -> 'a list = List.tl
let trunc : Real.real -> int = Real.trunc
let use : string -> unit = assert false
let valOf : 'a option -> 'a = Option.valOf
let vector : 'a list -> 'a vector = Vector.fromList
