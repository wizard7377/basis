open General.General

module type PRIM_IO = sig 
  type elem
type vector
type vector_slice
type array
type array_slice

type pos

val compare : pos * pos -> order

type reader
  = RD of {
    name : string;
    chunkSize : int;
    readVec : (int -> vector) option;
    readArr : (array_slice -> int) option;
    readVecNB : (int -> vector option) option;
    readArrNB : (array_slice -> int option) option;
    block : (unit -> unit) option;
    canInput : (unit -> bool) option;
    avail : unit -> int option;
    getPos : (unit -> pos) option;
    setPos : (pos -> unit) option;
    endPos : (unit -> pos) option;
    verifyPos : (unit -> pos) option;
    close : unit -> unit; 
    ioDesc : OS_IO.IO.iodesc option 
  }

type writer
  = WR of {
    name : string;
    chunkSize : int;
    writeVec : (vector_slice -> int) option;
    writeArr : (array_slice -> int) option;
    writeVecNB : (vector_slice -> int option) option;
    writeArrNB : (array_slice -> int option) option;
    block : (unit -> unit) option;
    canOutput : (unit -> bool) option;
    getPos : (unit -> pos) option;
    setPos : (pos -> unit) option;
    endPos : (unit -> pos) option;
    verifyPos : (unit -> pos) option;
    close : unit -> unit; 
    ioDesc : OS_IO.IO.iodesc option
  }
val openVector : vector -> reader
val nullRd : unit -> reader
val nullWr : unit -> writer

val augmentReader : reader -> reader
val augmentWriter : writer -> writer
end

open Word8Vector
open Word8Array
open Word8 
open CharVector
open CharArray
open Char
open Position
open Word8VectorSlice
open Word8ArraySlice
open CharVectorSlice
open CharArraySlice
module BinPrimIO : PRIM_IO
  with type array = Word8Array.array
  and type vector = Word8Vector.vector
  and type elem = Word8.word
  and type pos = Position.int = struct 
      type elem = Word8.word
type vector = Word8Vector.vector
type vector_slice = Word8VectorSlice.vector 
type array = Word8Array.array
type array_slice = Word8ArraySlice.vector

type pos = Position.int

let  compare : pos * pos -> order = assert false

type reader
  = RD of {
    name : string;
    chunkSize : int;
    readVec : (int -> vector) option;
    readArr : (array_slice -> int) option;
    readVecNB : (int -> vector option) option;
    readArrNB : (array_slice -> int option) option;
    block : (unit -> unit) option;
    canInput : (unit -> bool) option;
    avail : unit -> int option;
    getPos : (unit -> pos) option;
    setPos : (pos -> unit) option;
    endPos : (unit -> pos) option;
    verifyPos : (unit -> pos) option;
    close : unit -> unit; 
    ioDesc : OS_IO.IO.iodesc option 
  }

type writer
  = WR of {
    name : string;
    chunkSize : int;
    writeVec : (vector_slice -> int) option;
    writeArr : (array_slice -> int) option;
    writeVecNB : (vector_slice -> int option) option;
    writeArrNB : (array_slice -> int option) option;
    block : (unit -> unit) option;
    canOutput : (unit -> bool) option;
    getPos : (unit -> pos) option;
    setPos : (pos -> unit) option;
    endPos : (unit -> pos) option;
    verifyPos : (unit -> pos) option;
    close : unit -> unit; 
    ioDesc : OS_IO.IO.iodesc option
  }
let  openVector : vector -> reader = assert false
let  nullRd : unit -> reader = assert false
let  nullWr : unit -> writer = assert false

let  augmentReader : reader -> reader = assert false
let  augmentWriter : writer -> writer = assert false
end
module TextPrimIO : PRIM_IO
with type array = CharArray.array
      and type vector = CharVector.vector
      and type elem = Char.char = struct 
      type elem = Char.char
type vector = CharVector.vector
type vector_slice = CharVectorSlice.vector 
type array = CharArray.array
type array_slice = CharArraySlice.vector

type pos = Position.int

let  compare : pos * pos -> order = assert false

type reader
  = RD of {
    name : string;
    chunkSize : int;
    readVec : (int -> vector) option;
    readArr : (array_slice -> int) option;
    readVecNB : (int -> vector option) option;
    readArrNB : (array_slice -> int option) option;
    block : (unit -> unit) option;
    canInput : (unit -> bool) option;
    avail : unit -> int option;
    getPos : (unit -> pos) option;
    setPos : (pos -> unit) option;
    endPos : (unit -> pos) option;
    verifyPos : (unit -> pos) option;
    close : unit -> unit; 
    ioDesc : OS_IO.IO.iodesc option 
  }

type writer
  = WR of {
    name : string;
    chunkSize : int;
    writeVec : (vector_slice -> int) option;
    writeArr : (array_slice -> int) option;
    writeVecNB : (vector_slice -> int option) option;
    writeArrNB : (array_slice -> int option) option;
    block : (unit -> unit) option;
    canOutput : (unit -> bool) option;
    getPos : (unit -> pos) option;
    setPos : (pos -> unit) option;
    endPos : (unit -> pos) option;
    verifyPos : (unit -> pos) option;
    close : unit -> unit; 
    ioDesc : OS_IO.IO.iodesc option
  }
let  openVector : vector -> reader = assert false
let  nullRd : unit -> reader = assert false
let  nullWr : unit -> writer = assert false

let  augmentReader : reader -> reader = assert false
let  augmentWriter : writer -> writer = assert false
end