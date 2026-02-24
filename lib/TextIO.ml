(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note: Incomplete.
  *);;
open General;;
open TEXT_IO_sig;;
open TEXT_STREAM_IO_sig;;
module TextIO = struct
                  open General;;
                  open TEXT_STREAM_IO_sig;;
                  module StreamIO = struct
                                      type nonrec vector = string;;
                                      type nonrec elem = char;;
                                      end;;
                  type nonrec vector = StreamIO.vector;;
                  type nonrec elem = StreamIO.elem;;
                  type nonrec instream = int;;
                  type nonrec outstream = int;;
                  let rec stdIn () = raise ((Fail "TODO"));;
                  let rec stdOut () = raise ((Fail "TODO"));;
                  let rec stdErr () = raise ((Fail "TODO"));;
                  let rec openIn s = raise ((Fail "TODO"));;
                  let rec openOut s = raise ((Fail "TODO"));;
                  let rec openAppend s = raise ((Fail "TODO"));;
                  let rec closeIn s = raise ((Fail "TODO"));;
                  let rec closeOut s = raise ((Fail "TODO"));;
                  let rec input s = raise ((Fail "TODO"));;
                  let rec input1 s = raise ((Fail "TODO"));;
                  let rec inputN (s, n) = raise ((Fail "TODO"));;
                  let rec inputAll s = raise ((Fail "TODO"));;
                  let rec inputLine s = raise ((Fail "TODO"));;
                  let rec endOfStream s = raise ((Fail "TODO"));;
                  let rec output (os, v) = raise ((Fail "TODO"));;
                  let rec output1 (os, e) = raise ((Fail "TODO"));;
                  let rec flushOut os = raise ((Fail "TODO"));;
                  let rec print s = raise ((Fail "TODO"));;
                  let rec outputSubstr (os, ss) = raise ((Fail "TODO"));;
                  end;;
(* 
  fun scanStream scanFn strm  =
      let
        val instrm = getInstream strm
      in
        case (scanFn StreamIO.input1 instrm) of
          NONE => NONE
        | SOME(v, instrm') => ( setInstream (strm, instrm'); SOME v )
      end
 *);;