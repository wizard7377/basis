(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
  *);;
open GENERAL_sig;;
module General = struct
                   type nonrec unit = unit;;
                   type nonrec exn = exn;;
                   exception Bind ;;
                   exception Chr ;;
                   exception Div ;;
                   exception Domain ;;
                   exception Fail of string ;;
                   exception Match ;;
                   exception Overflow ;;
                   exception Size ;;
                   exception Span ;;
                   exception Subscript ;;
                   let rec exnName e = raise ((Fail "TODO"));;
                   let exnMessage = exnName;;
                   type order = | Less 
                                | Equal 
                                | Greater ;;
                   let rec ( ! ) { contents = v} = v;;
                   let ( := ) x__op y__op = x__op := y__op;;
                   let rec o (f, g) a = f (g a);;
                   let rec before (a, b) = a;;
                   let rec ignore a = ();;
                   end;;
open General;;
type order = | Less 
             | Equal 
             | Greater ;;