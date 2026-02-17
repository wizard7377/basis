[@@@sml.comment {|(*
 * SML Basis Library runtime pervasives for OCaml compilation.
 * Provides types, exceptions, and values assumed by the SML-to-OCaml translator.
 *)|}];;

(* SML types not native to OCaml *)
type word = int;;
type real = float;;
type 'a vector = 'a list;;

(* SML order type — used pervasively across modules *)
type order = LESS | EQUAL | GREATER;;

(* SML exceptions not native to OCaml *)
exception Bind;;
exception Chr;;
exception Div;;
exception Domain;;
exception Match;;
exception Overflow;;
exception Size;;
exception Subscript;;
exception Empty;;
exception Fail of string;;
exception Span;;

(* SML use primitive — stub that returns Obj.magic to satisfy any type *)
type use_spec = { b : string };;
let use (_spec : use_spec) : 'a = Obj.magic (fun () -> failwith "SML primitive not implemented");;

(* SML integer division and modulus *)
let div (a, b) = a / b;;
let mod_ (a, b) = a mod b;;

(* SML function composition *)
let o f g a = f (g a);;
