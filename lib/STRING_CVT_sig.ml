[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
module type STRING_CVT = sig
                         type radix = | Bin 
                                      | Oct 
                                      | Dec 
                                      | Hex 
                         type realfmt =
                           | Sci of (int option) 
                           | Fix of (int option) 
                           | Gen of (int option) 
                           | Exact 
                         type nonrec ('a, 'b) reader = ('b -> 'a * 'b option)
                         val padLeft : (char -> int -> string -> string)
                         val padRight : (char -> int -> string -> string)
                         val
                           splitl : ((char -> bool) ->
                                     (char, 'a)
                                     reader ->
                                     'a ->
                                     string * 'a)
                         val
                           takel : ((char -> bool) ->
                                    (char, 'a)
                                    reader ->
                                    'a ->
                                    string)
                         val
                           dropl : ((char -> bool) ->
                                    (char, 'a)
                                    reader ->
                                    'a ->
                                    'a)
                         val skipWS : ((char, 'a) reader -> 'a -> 'a)
                         type nonrec cs
                         val
                           scanString : (((char, cs)
                                          reader ->
                                          ('a, cs)
                                          reader) ->
                                         string ->
                                         'a
                                         option)
                         end;;