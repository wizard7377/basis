[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
type nonrec 'a option = 'a option;;
exception Option ;;
let rec getOpt = (function 
                           | ((Some v), a) -> v
                           | (None, a) -> a);;
let rec isSome = (function 
                           | (Some v) -> true
                           | None -> false);;
let rec valOf = (function 
                          | (Some v) -> v
                          | None -> (raise Option));;
let rec filter f a = begin if (f a) then (Some a) else None end;;
let rec join = (function 
                         | None -> None
                         | (Some v) -> v);;
let rec app arg__0 arg__1 =
  begin
  match (arg__0, arg__1) with 
                              | (f, None) -> ()
                              | (f, (Some v)) -> (f v)
  end;;
let rec map arg__2 arg__3 =
  begin
  match (arg__2, arg__3)
  with 
       | (f, None) -> None
       | (f, (Some v)) -> (Some ((f v)))
  end;;
let rec mapPartial f = (o join ((map f)));;
let rec compose (f, g) = (o (map f) g);;
let rec composePartial (f, g) = (o (mapPartial f) g);;
