(* 
 * (c) Andreas Rossberg 2002-2025
 *
 * Standard ML Basis Library
  *);;
open General;;
open Char;;
open String;;
open Substring;;
open MONO_VECTOR_sig;;
open MONO_ARRAY_sig;;
open MONO_VECTOR_SLICE_sig;;
open MONO_ARRAY_SLICE_sig;;
module type TEXT = sig
                   module Char : CHAR
                   module String : STRING
                   module Substring : SUBSTRING
                   module CharVector : MONO_VECTOR
                   module CharArray : MONO_ARRAY
                   module CharVectorSlice : MONO_VECTOR_SLICE
                   module CharArraySlice : MONO_ARRAY_SLICE
                   end;;
(* 
 * (c) Andreas Rossberg 2002-2025
 *
 * Standard ML Basis Library
  *);;
module Text = struct
                module Char = Char;;
                module String = String;;
                module Substring = Substring;;
                module CharVector = CharVector;;
                module CharArray = CharArray;;
                module CharVectorSlice = CharVectorSlice;;
                module CharArraySlice = CharArraySlice;;
                end;;