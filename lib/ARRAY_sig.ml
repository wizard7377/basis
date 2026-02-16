[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
module type ARRAY = sig
                    type nonrec 'a array
                    [@@@sml.comment {|(*= 'a array*)|}]
                    type nonrec 'a vector = 'a Vector.vector
                    val maxLen : int
                    val array : (int * 'a -> 'a array)
                    val fromList : ('a list -> 'a array)
                    val tabulate : (int * (int -> 'a) -> 'a array)
                    val length : ('a array -> int)
                    val sub : ('a array * int -> 'a)
                    val update : ('a array * int * 'a -> unit)
                    val vector : ('a array -> 'a vector)
                    type nonrec 'a __0 = { src: 'a array ; dst: 'a array ;
                      di: int }
                    val copy : ('a __0 -> unit)
                    type nonrec 'a __1 = { src: 'a vector ; dst: 'a array ;
                      di: int }
                    val copyVec : ('a __1 -> unit)
                    val appi : ((int * 'a -> unit) -> 'a array -> unit)
                    val app : (('a -> unit) -> 'a array -> unit)
                    val modifyi : ((int * 'a -> 'a) -> 'a array -> unit)
                    val modify : (('a -> 'a) -> 'a array -> unit)
                    val
                      foldli : ((int * 'a * 'b -> 'b) -> 'b -> 'a array -> 'b)
                    val
                      foldri : ((int * 'a * 'b -> 'b) -> 'b -> 'a array -> 'b)
                    val foldl : (('a * 'b -> 'b) -> 'b -> 'a array -> 'b)
                    val foldr : (('a * 'b -> 'b) -> 'b -> 'a array -> 'b)
                    val
                      findi : ((int * 'a -> bool) ->
                               'a
                               array ->
                               int * 'a
                               option)
                    val find : (('a -> bool) -> 'a array -> 'a option)
                    val exists : (('a -> bool) -> 'a array -> bool)
                    val all : (('a -> bool) -> 'a array -> bool)
                    val
                      collate : (('a * 'a -> order) ->
                                 'a array * 'a array ->
                                 order)
                    end;;