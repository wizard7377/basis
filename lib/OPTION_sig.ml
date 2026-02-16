[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
module type OPTION = sig
                     type nonrec 'a option = 'a option
                     exception Option 
                     val getOpt : ('a option * 'a -> 'a)
                     val isSome : ('a option -> bool)
                     val valOf : ('a option -> 'a)
                     val filter : (('a -> bool) -> 'a -> 'a option)
                     val join : (('a option) option -> 'a option)
                     val app : (('a -> unit) -> 'a option -> unit)
                     val map : (('a -> 'b) -> 'a option -> 'b option)
                     val
                       mapPartial : (('a -> 'b option) ->
                                     'a
                                     option ->
                                     'b
                                     option)
                     val
                       compose : (('a -> 'b) * ('c -> 'a option) ->
                                  'c ->
                                  'b
                                  option)
                     val
                       composePartial : (('a -> 'b option) *
                                         ('c -> 'a option) ->
                                         'c ->
                                         'b
                                         option)
                     end;;