(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *)
open General

module type IO = sig
  type nonrec __0 = { name : string; function_ : string; cause : exn }

  exception Io of __0
  exception BlockingNotSupported
  exception NonblockingNotSupported
  exception RandomAccessNotSupported
  exception ClosedStream

  type buffer_mode = No_buf | Line_buf | Block_buf
end

(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *)
module IO = struct
  type nonrec __0 = { name : string; function_ : string; cause : exn }

  exception Io of __0
  exception BlockingNotSupported
  exception NonblockingNotSupported
  exception RandomAccessNotSupported
  exception ClosedStream

  type buffer_mode = No_buf | Line_buf | Block_buf
end
