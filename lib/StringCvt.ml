[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
type nonrec cs = int;;
type nonrec ('a, 'b) reader = ('b -> 'a * 'b option);;
type radix = | Bin 
             | Oct 
             | Dec 
             | Hex ;;
type realfmt =
  | Sci of (int option) 
  | Fix of (int option) 
  | Gen of (int option) 
  | Exact ;;
let ( ^ ) = String.( ^ );;
let rec clamp i = begin if (i < 0) then 0 else i end;;
let rec padding c i =
  (String.implode ((List.tabulate ((clamp i), (function 
                                                        | _ -> c)))));;
let rec padLeft c i s = (((padding c ((i - ((String.size s)))))) ^ s);;
let rec padRight c i s = (s ^ ((padding c ((i - ((String.size s)))))));;
let rec splitl_prime (p, f, src, cs) =
  begin
  match (f src)
  with 
       | None -> ((String.implode ((List.rev cs))), src)
       | (Some (c, src_prime)) -> begin
           if (p c) then (splitl_prime (p, f, src_prime, (c :: cs))) else
           ((String.implode ((List.rev cs))), src) end
  end;;
let rec splitl p f src = (splitl_prime (p, f, src, []));;
let rec takel p f s = (((fun (r, _) -> r)) ((splitl p f s)));;
let rec dropl p f s = (((fun (_, r) -> r)) ((splitl p f s)));;
let rec skipWS f s = (dropl Char.isSpace f s);;
let rec reader s i =
  (try (Some ((String.sub (s, i)), (i + 1))) with 
                                                  | Subscript -> None);;
let rec scanString f s =
  (Option.map
  ((fun (r, _) -> r))
  (((f ((reader s)) 0) : ('a * cs) option)));;
