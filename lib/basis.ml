[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Notes:\n * - We only implement required structures (and their signatures).\n * - Modules commented out are not yet implemented.\n *)|}];;
module Types = Types 
module Infix = Infix
module Exceptions = Exceptions
module type GENERAL = GENERAL_sig.GENERAL
module General = General
module type OPTION = OPTION_sig.OPTION
module Option = Option
module type BOOL = BOOL_sig.BOOL
module Bool = Bool
module type LIST = LIST_sig.LIST
module List = List

module type LIST_PAIR = LIST_PAIR_sig.LIST_PAIR
module ListPair = ListPair
module type CHAR = CHAR_sig.CHAR
module Char = Char
module type STRING = STRING_sig.STRING
module String = String
module type SUBSTRING = SUBSTRING_sig.SUBSTRING
module Substring = Substring
module type STRING_CVT = STRING_CVT_sig.STRING_CVT
module StringCvt = StringCvt
module type INTEGER = INTEGER_sig.INTEGER
module Int = Int
module LargeInt = LargeInt
module Position = Position
module type WORD = WORD_sig.WORD
module Word = Word
module Word8 = Word8
module LargeWord = LargeWord
module type IEEE_REAL = IEEE_REAL_sig.IEEE_REAL
module IEEEReal = IEEEReal
module type MATH = MATH_sig.MATH
module Math = Math
module type REAL = REAL_sig.REAL
module Real = Real
module LargeReal = LargeReal
module type TIME = TIME_sig.TIME
module Time = Time
module type VECTOR = VECTOR_sig.VECTOR
module Vector = Vector
module type MONO_VECTOR = MONO_VECTOR_sig.MONO_VECTOR
module Word8Vector = Word8Vector
module CharVector = CharVector
module type VECTOR_SLICE = VECTOR_SLICE_sig.VECTOR_SLICE
module VectorSlice = VectorSlice
module type MONO_VECTOR_SLICE = MONO_VECTOR_SLICE_sig.MONO_VECTOR_SLICE
module Word8VectorSlice = Word8VectorSlice
module CharVectorSlice = CharVectorSlice
module type ARRAY = ARRAY_sig.ARRAY
module Array = Array
module type MONO_ARRAY = MONO_ARRAY_sig.MONO_ARRAY
module Word8Array = Word8Array
module CharArray = CharArray
module type ARRAY_SLICE = ARRAY_SLICE_sig.ARRAY_SLICE
module ArraySlice = ArraySlice
module type MONO_ARRAY_SLICE = MONO_ARRAY_SLICE_sig.MONO_ARRAY_SLICE
module Word8ArraySlice = Word8ArraySlice
module CharArraySlice = CharArraySlice
module type BYTE = BYTE_sig.BYTE
module Byte = Byte
module type TEXT = TEXT_sig.TEXT
module Text = Text.Text
module type IO = IO_sig.IO
module IO = IO
module type STREAM_IO = STREAM_IO_sig.STREAM_IO
module type IMPERATIVE_IO = IMPERATIVE_IO_sig.IMPERATIVE_IO
module type TEXT_STREAM_IO = TEXT_STREAM_IO_sig.TEXT_STREAM_IO
module type TEXT_IO = TEXT_IO_sig.TEXT_IO
module TextIO = TextIO
module type OS_FILE_SYS = OS_FILE_SYS_sig.OS_FILE_SYS
module type OS_PATH = OS_PATH_sig.OS_PATH
module type OS_PROCESS = OS_PROCESS_sig.OS_PROCESS
module type OS = OS_sig.OS
module OS = OS.OS
module type COMMAND_LINE = COMMAND_LINE_sig.COMMAND_LINE
module CommandLine = CommandLine
module Values = Values
[@@@sml.comment {|(*use "PRIM_IO-sig.sml";*)|}]
[@@@sml.comment {|(*use "BinPrimIO.sml";*)|}]
[@@@sml.comment {|(*use "TextPrimIO.sml";*)|}]
[@@@sml.comment {|(*use "BIN_IO-sig.sml";*)|}]
[@@@sml.comment {|(*use "BinIO.sml";*)|}]
[@@@sml.comment {|(*use "OS_IO-sig.sml";*)|}]
[@@@sml.comment {|(*use "OS_IO.sml";*)|}]
[@@@sml.comment {|(*use "DATE-sig.sml";*)|}]
[@@@sml.comment {|(*use "Date.sml";*)|}]
[@@@sml.comment {|(*use "TIMER-sig.sml";*)|}]
[@@@sml.comment {|(*use "Timer.sml";*)|}]
