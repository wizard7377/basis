include GENERAL_sig.GENERAL
[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
module type GENERAL = sig
                      type unit 
                      type exn 
                      type word 
                      type real
                      type char
                      type string
                      type substring
                      type 'a array
                      type 'a vector
                      type 'a option
                      type 'a list 
                      type order 
                      exception Bind 
                      exception Match 
                      exception Chr 
                      exception Div 
                      exception Domain 
                      exception Fail of (string) 
                      exception Overflow 
                      exception Size 
                      exception Span 
                      exception Subscript 
                      val exnName : (exn -> string)
                      val exnMessage : (exn -> string)
                      val ( ! ) : ('a ref -> 'a)
                      val ( := ) : ('a ref * 'a -> unit)
                      val ( @ ) : ('a list * 'a list -> 'a list)
                      val ( ^ ) : (string * string -> string)
                      val app : ('a -> unit) * 'a list -> unit
                      val before : ('a * unit -> 'a)
                    val ceil : real -> int
                    val chr : int -> char
                    val concat : string list -> string
                    val explode : string -> char list
                    val floor : real -> int
                    val getOpt : ('a option * 'a) -> 'a
                    val hd : 'a list -> 'a
                    val ignore : ('a -> unit)
                    val implode : char list -> string
                    val isSome : 'a option -> bool
                    val length : 'a list -> int
                    val map : ('a -> 'b) * 'a list -> 'b list
                    val not : bool -> bool
                    val null : 'a list -> bool
                        val o : (('b -> 'c) * ('a -> 'b) -> 'a -> 'c)
                        val ord : char -> int
                        val print : string -> unit
                        val real : int -> real
                        val rev : 'a list -> 'a list
                        val round : real -> int

                        val size : 'a array -> int
                        val str : char -> string
                            val substring : (string * int * int -> substring)
                            val tl : 'a list -> 'a list
                            val trunc : real -> int
                            val use : string -> unit
                            val valOf : 'a option -> 'a
                                val vector : 'a list -> 'a vector

                          
                      end;;
