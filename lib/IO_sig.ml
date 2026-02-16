[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *)|}];;
module type IO = sig
                 type nonrec __0 = { name: string ; function_: string ;
                   cause: exn }
                 exception Io of (__0) 
                 exception BlockingNotSupported 
                 exception NonblockingNotSupported 
                 exception RandomAccessNotSupported 
                 exception ClosedStream 
                 type buffer_mode = | No_buf 
                                    | Line_buf 
                                    | Block_buf 
                 end;;