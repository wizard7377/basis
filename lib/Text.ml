[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2002-2025\n *\n * Standard ML Basis Library\n *)|}];;
module Text =
  struct
    module Char = Char;;
    module String = String;;
    module Substring = Substring;;
    module CharVector = CharVector;;
    module CharArray = CharArray;;
    module CharVectorSlice = CharVectorSlice;;
    module CharArraySlice = CharArraySlice;;
    end;;
[@@@sml.comment
  {|(* redundant and illegal\n  where type String.string = String.string\n  where type Substring.substring = Substring.substring\n*)|}];;