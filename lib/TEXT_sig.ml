[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2002-2025\n *\n * Standard ML Basis Library\n *)|}];;
module type TEXT = sig
                   module Char : sig end
                   module String : sig end
                   module Substring : sig end
                   module CharVector : sig end
                   module CharArray : sig end
                   module CharVectorSlice : sig end
                   module CharArraySlice : sig end
                   end;;