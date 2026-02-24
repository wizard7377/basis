open General.General
open Time 
module type OS_IO = sig 
  type iodesc
val hash : iodesc -> int
val compare : iodesc * iodesc -> order
type iodesc_kind
val kind : iodesc -> iodesc_kind
module Kind : sig
    val file    : iodesc_kind
    val dir     : iodesc_kind
    val symlink : iodesc_kind
    val tty     : iodesc_kind
    val pipe    : iodesc_kind
    val socket  : iodesc_kind
    val device  : iodesc_kind
  end
type poll_desc
type poll_info
val pollDesc : iodesc -> poll_desc option
val pollToIODesc : poll_desc -> iodesc
exception Poll
val pollIn  : poll_desc -> poll_desc
val pollOut : poll_desc -> poll_desc
val pollPri : poll_desc -> poll_desc
val poll : poll_desc list * Time.time option
             -> poll_info list
val isIn  : poll_info -> bool
val isOut : poll_info -> bool
val isPri : poll_info -> bool
val infoToPollDesc : poll_info -> poll_desc
end

module IO : OS_IO = struct
  type iodesc = int
  let hash : iodesc -> int = assert false
  let compare : iodesc * iodesc -> order = assert false
  type iodesc_kind = File | Dir | Symlink | Tty | Pipe | Socket | Device
  let kind : iodesc -> iodesc_kind = assert false
  module Kind = struct
    let file    : iodesc_kind = File
    let dir     : iodesc_kind = Dir
    let symlink : iodesc_kind = Symlink
    let tty     : iodesc_kind = Tty
    let pipe    : iodesc_kind = Pipe
    let socket  : iodesc_kind = Socket
    let device  : iodesc_kind = Device
  end
  type poll_desc = int
  type poll_info = int
  let pollDesc : iodesc -> poll_desc option = assert false
  let pollToIODesc : poll_desc -> iodesc = assert false
  exception Poll
  let pollIn  : poll_desc -> poll_desc = assert false
  let pollOut : poll_desc -> poll_desc = assert false
  let pollPri : poll_desc -> poll_desc = assert false
  let poll : poll_desc list * Time.time option -> poll_info list = assert false
  let isIn  : poll_info -> bool = assert false
  let isOut : poll_info -> bool = assert false
  let isPri : poll_info -> bool = assert false
  let infoToPollDesc : poll_info -> poll_desc = assert false
end