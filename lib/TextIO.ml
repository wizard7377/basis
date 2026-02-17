[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note: Incomplete.\n *)|}];;
module StreamIO =
  struct
    type nonrec vector = CharVector.vector;;
    type nonrec elem = Char.char;;
    end;;
type nonrec vector = StreamIO.vector;;
type nonrec elem = StreamIO.elem;;
type nonrec instream = int;;
type nonrec outstream = int;;
let stdIn = ((use { b = "TextIO.stdIn"}  ()) : instream);;
let stdOut = ((use { b = "TextIO.stdOut"}  ()) : outstream);;
let stdErr = ((use { b = "TextIO.stdErr"}  ()) : outstream);;
let openIn = ((use { b = "TextIO.openIn"} ) : (string -> instream));;
let openOut = ((use { b = "TextIO.openOut"} ) : (string -> outstream));;
let openAppend =
  ((use { b = "TextIO.openAppend"} ) : (string -> outstream));;
let closeIn = ((use { b = "TextIO.closeIn"} ) : (instream -> unit));;
let closeOut = ((use { b = "TextIO.closeOut"} ) : (outstream -> unit));;
let input = ((use { b = "TextIO.input"} ) : (instream -> vector));;
let input1 = ((use { b = "TextIO.input1"} ) : (instream -> elem option));;
let inputN = ((use { b = "TextIO.inputN"} ) : (instream * int -> vector));;
let inputAll = ((use { b = "TextIO.inputAll"} ) : (instream -> vector));;
let inputLine =
  ((use { b = "TextIO.inputLine"} ) : (instream -> string option));;
let endOfStream =
  ((use { b = "TextIO.endOfStream"} ) : (instream -> bool));;
let output =
  ((use { b = "TextIO.output"} ) : (outstream * vector -> unit));;
let output1 =
  ((use { b = "TextIO.output1"} ) : (outstream * elem -> unit));;
let flushOut = ((use { b = "TextIO.flushOut"} ) : (outstream -> unit));;
let rec print s = begin
                    (output (stdOut, s));(flushOut stdOut)
                    end;;
let rec outputSubstr (os, ss) = (output (os, (Substring.string ss)));;
[@@@sml.comment
  {|(*\n  fun scanStream scanFn strm  =\n      let\n        val instrm = getInstream strm\n      in\n        case (scanFn StreamIO.input1 instrm) of\n          NONE => NONE\n        | SOME(v, instrm') => ( setInstream (strm, instrm'); SOME v )\n      end\n*)|}];;