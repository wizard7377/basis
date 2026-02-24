open! List
open! Option
open! Vector
open! TextIO
open! Bool
open! Char
open! String

(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library top-level values
 *
 * Note: Overloaded values are all primitive.
 *)
open General
open Exceptions

let getOpt = Option.getOpt
let isSome = Option.isSome
let valOf = Option.valOf
let not = Bool.not
let ord = Char.ord
let chr = Char.chr
let size = String.size
let str = String.str
let concat = String.concat
let implode = String.implode
let explode = String.explode
let substring = String.substring
let null = List.null
let hd = List.hd
let tl = List.tl
let length = List.length
let rev = List.rev
let app = List.app
let map = List.map
let foldr = List.foldr
let foldl = List.foldl
let print = TextIO.print
let vector = Vector.fromList
let rec use s = raise (General.Fail "TODO")
