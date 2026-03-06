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
  type iodesc = Unix.file_descr
  let hash : iodesc -> int = fun fd ->
    Hashtbl.hash fd
  ;;
  let compare : iodesc * iodesc -> order = fun (fd1, fd2) ->
    let h1 = Hashtbl.hash fd1 in
    let h2 = Hashtbl.hash fd2 in
    begin if h1 < h2 then Less
    else begin if h1 = h2 then Equal else Greater end
    end
  ;;
  type iodesc_kind = File | Dir | Symlink | Tty | Pipe | Socket | Device
  let kind : iodesc -> iodesc_kind = fun fd ->
    let st = Unix.fstat fd in
    begin match st.Unix.st_kind with
    | Unix.S_REG -> File
    | Unix.S_DIR -> Dir
    | Unix.S_LNK -> Symlink
    | Unix.S_CHR ->
      begin if Unix.isatty fd then Tty else Device end
    | Unix.S_FIFO -> Pipe
    | Unix.S_SOCK -> Socket
    | Unix.S_BLK -> Device
    end
  ;;
  module Kind = struct
    let file    : iodesc_kind = File
    let dir     : iodesc_kind = Dir
    let symlink : iodesc_kind = Symlink
    let tty     : iodesc_kind = Tty
    let pipe    : iodesc_kind = Pipe
    let socket  : iodesc_kind = Socket
    let device  : iodesc_kind = Device
  end
  type poll_desc = { pd_fd : iodesc; pd_in : bool; pd_out : bool; pd_pri : bool }
  type poll_info = { pi_fd : iodesc; pi_in : bool; pi_out : bool; pi_pri : bool }
  let pollDesc : iodesc -> poll_desc option = fun fd ->
    Some { pd_fd = fd; pd_in = false; pd_out = false; pd_pri = false }
  ;;
  let pollToIODesc : poll_desc -> iodesc = fun pd -> pd.pd_fd
  ;;
  exception Poll
  let pollIn  : poll_desc -> poll_desc = fun pd -> { pd with pd_in = true }
  ;;
  let pollOut : poll_desc -> poll_desc = fun pd -> { pd with pd_out = true }
  ;;
  let pollPri : poll_desc -> poll_desc = fun pd -> { pd with pd_pri = true }
  ;;
  let poll : poll_desc list * Time.time option -> poll_info list = fun (pds, timeout) ->
    let read_fds = Stdlib.List.filter_map (fun pd ->
      begin if pd.pd_in then Some pd.pd_fd else None end) pds in
    let write_fds = Stdlib.List.filter_map (fun pd ->
      begin if pd.pd_out then Some pd.pd_fd else None end) pds in
    let except_fds = Stdlib.List.filter_map (fun pd ->
      begin if pd.pd_pri then Some pd.pd_fd else None end) pds in
    let t = begin match timeout with
    | None -> -1.0
    | Some time -> Time.toReal time
    end in
    let (r, w, e) = Unix.select read_fds write_fds except_fds t in
    Stdlib.List.map (fun pd ->
      { pi_fd = pd.pd_fd;
        pi_in = pd.pd_in && Stdlib.List.mem pd.pd_fd r;
        pi_out = pd.pd_out && Stdlib.List.mem pd.pd_fd w;
        pi_pri = pd.pd_pri && Stdlib.List.mem pd.pd_fd e;
      }) pds
  ;;
  let isIn  : poll_info -> bool = fun pi -> pi.pi_in
  ;;
  let isOut : poll_info -> bool = fun pi -> pi.pi_out
  ;;
  let isPri : poll_info -> bool = fun pi -> pi.pi_pri
  ;;
  let infoToPollDesc : poll_info -> poll_desc = fun pi ->
    { pd_fd = pi.pi_fd; pd_in = pi.pi_in; pd_out = pi.pi_out; pd_pri = pi.pi_pri }
  ;;
end
