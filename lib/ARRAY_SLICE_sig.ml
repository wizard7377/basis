[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2002-2025\n *\n * Standard ML Basis Library\n *)|}];;
module type ARRAY_SLICE = sig
                          type nonrec 'a slice
                          val length : ('a slice -> int)
                          val sub : ('a slice * int -> 'a)
                          val update : ('a slice * int * 'a -> unit)
                          val
                            slice : ('a Array.array * int * int option ->
                                     'a
                                     slice)
                          val full : ('a Array.array -> 'a slice)
                          val
                            subslice : ('a slice * int * int option ->
                                        'a
                                        slice)
                          val base : ('a slice -> 'a Array.array * int * int)
                          val vector : ('a slice -> 'a vector)
                          type nonrec 'a __0 = { src: 'a slice ;
                            dst: 'a Array.array ; di: int }
                          val copy : ('a __0 -> unit)
                          type nonrec 'a __1 = { src: 'a VectorSlice.slice ;
                            dst: 'a Array.array ; di: int }
                          val copyVec : ('a __1 -> unit)
                          val isEmpty : ('a slice -> bool)
                          val getItem : ('a slice -> 'a * 'a slice option)
                          val appi : ((int * 'a -> unit) -> 'a slice -> unit)
                          val app : (('a -> unit) -> 'a slice -> unit)
                          val
                            modifyi : ((int * 'a -> 'a) -> 'a slice -> unit)
                          val modify : (('a -> 'a) -> 'a slice -> unit)
                          val
                            foldli : ((int * 'a * 'b -> 'b) ->
                                      'b ->
                                      'a
                                      slice ->
                                      'b)
                          val
                            foldri : ((int * 'a * 'b -> 'b) ->
                                      'b ->
                                      'a
                                      slice ->
                                      'b)
                          val
                            foldl : (('a * 'b -> 'b) -> 'b -> 'a slice -> 'b)
                          val
                            foldr : (('a * 'b -> 'b) -> 'b -> 'a slice -> 'b)
                          val
                            findi : ((int * 'a -> bool) ->
                                     'a
                                     slice ->
                                     int * 'a
                                     option)
                          val find : (('a -> bool) -> 'a slice -> 'a option)
                          val exists : (('a -> bool) -> 'a slice -> bool)
                          val all : (('a -> bool) -> 'a slice -> bool)
                          val
                            collate : (('a * 'a -> order) ->
                                       'a slice * 'a slice ->
                                       order)
                          end;;