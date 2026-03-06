(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note: Incomplete.
 *)
open General
open OS_FileSys
open OS_Path
open OS_Process

module type OS = sig
  module FileSys : OS_FILE_SYS
  module Path : OS_PATH
  module Process : OS_PROCESS

  (* 
  open General 
structure IO : OS_IO
 *)
  type nonrec syserror

  exception SysErr of string * syserror option
end

(* 
  val errorMsg : syserror -> string
  val errorName : syserror -> string
  val syserror : string -> syserror option
 *)
(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note: Incomplete.
  *)
open Exceptions

module OS = struct
  type nonrec syserror = int

  exception SysErr of string * syserror option

  module FileSys : OS_FILE_SYS = struct
    let getDir () = Sys.getcwd ()
    let chDir s = Sys.chdir s
    let mkDir s = Unix.mkdir s 0o755
    let rmDir s = Unix.rmdir s
    let isDir s = Sys.is_directory s
  end

  module Path = struct
    exception Path
    exception InvalidArc

    let currentArc = "."
    let parentArc = ".."

    type nonrec path_rec = { isAbs : bool; vol : string; arcs : string list }
    type nonrec dir_file = { dir : string; file : string }
    type nonrec base_ext = { base : string; ext : string option }
    type nonrec abs_rel = { path : string; relativeTo : string }

    let rec isArcSep c = c = '/'
    let rec isExtSep c = c = '.'

    let rec splitLast = function
      | [] -> None
      | x :: xs ->
        begin match splitLast xs with
        | None -> Some ([], x)
        | Some (ys, y) -> Some (x :: ys, y)
        end

    let rec validVolume (p : path_rec) = p.vol = ""

    let rec fromString s =
      begin match String.String.fields isArcSep s with
      | [""] -> { isAbs = false; vol = ""; arcs = [] }
      | "" :: arcs -> { isAbs = true; vol = ""; arcs = arcs }
      | arcs -> { isAbs = false; vol = ""; arcs = arcs }
      end

    let rec validArc arc =
      begin match fromString arc with
      | { isAbs = false; vol = ""; arcs } -> List.List.length arcs <= 1
      | _ -> false
      end

    let rec toString { isAbs; vol; arcs } =
      begin if Bool.Bool.not isAbs && (begin match arcs with "" :: _ -> true | _ -> false end) then raise Path
      else begin if Bool.Bool.not (validVolume { isAbs = isAbs; vol = vol; arcs = [] }) then raise Path
      else begin if Bool.Bool.not (List.List.all validArc arcs) then raise InvalidArc
      else vol ^ (begin if isAbs then "/" else "" end) ^ String.String.concatWith "/" arcs
      end end end

    let rec getVolume _ = ""

    let rec getParent s =
      begin if s = "/" then s
      else
        let { isAbs; vol; arcs } = fromString s in
        begin match splitLast arcs with
        | None -> ".."
        | Some (_, "") -> s ^ ".."
        | Some (_, ".") -> s ^ "."
        | Some (_, "..") -> s ^ "/.."
        | Some ([], _) -> toString { isAbs = isAbs; vol = vol; arcs = ["."] }
        | Some (arcs, _) -> toString { isAbs = isAbs; vol = vol; arcs = arcs }
        end
      end

    let rec splitDirFile s =
      let { isAbs; vol; arcs } = fromString s in
      begin match splitLast arcs with
      | None ->
        { dir = toString { isAbs = isAbs; vol = vol; arcs = [] }; file = "" }
      | Some (arcs, arc) ->
        { dir = toString { isAbs = isAbs; vol = vol; arcs = arcs }; file = arc }
      end

    let rec joinDirFile (p : dir_file) =
      let { isAbs; vol; arcs } = fromString p.dir in
      let arcs =
        begin if List.List.null arcs && p.file = "" then [] else arcs @ [p.file] end
      in
      toString { isAbs = isAbs; vol = vol; arcs = arcs }

    let rec splitArcBaseExt arc =
      let (base_ss, ext_ss) =
        Substring.Substring.splitr (fun c -> Bool.Bool.not (isExtSep c)) (Substring.Substring.full arc)
      in
      begin if Substring.Substring.isEmpty ext_ss || Substring.Substring.size base_ss <= 1 then
        None
      else
        Some (
          Substring.Substring.string (Substring.Substring.trimr 1 base_ss),
          Substring.Substring.string ext_ss
        )
      end

    let rec splitBaseExt s =
      let { isAbs; vol; arcs } = fromString s in
      begin match splitLast arcs with
      | None ->
        { base = toString { isAbs = isAbs; vol = vol; arcs = [] }; ext = None }
      | Some (arcs, arc) ->
        begin match splitArcBaseExt arc with
        | None -> { base = s; ext = None }
        | Some (b, e) ->
          { base = toString { isAbs = isAbs; vol = vol; arcs = arcs @ [b] };
            ext = Some e }
        end
      end

    let rec joinBaseExt (p : base_ext) =
      begin match p.ext with
      | None -> p.base
      | Some "" -> p.base
      | Some arc -> p.base ^ "." ^ arc
      end

    let rec dir s = (splitDirFile s).dir
    let rec file s = (splitDirFile s).file
    let rec base s = (splitBaseExt s).base
    let rec ext s = (splitBaseExt s).ext

    let rec mkCanonicalArcs (isAbs, arcs, arcs') =
      begin match (isAbs, arcs, arcs') with
      | false, [], [] -> ["."]
      | _, [], _ -> List.List.rev arcs'
      | _, "" :: rest, _ -> mkCanonicalArcs (isAbs, rest, arcs')
      | _, "." :: rest, _ -> mkCanonicalArcs (isAbs, rest, arcs')
      | true, ".." :: rest, [] -> mkCanonicalArcs (true, rest, [])
      | _, ".." :: rest, ".." :: _ -> mkCanonicalArcs (true, rest, ".." :: ".." :: arcs')
      | _, ".." :: rest, _ :: arcs_rest -> mkCanonicalArcs (isAbs, rest, arcs_rest)
      | _, arc :: rest, _ -> mkCanonicalArcs (isAbs, rest, arc :: arcs')
      end

    let rec mkCanonical s =
      let { isAbs; vol; arcs } = fromString s in
      let arcs' = mkCanonicalArcs (isAbs, arcs, []) in
      toString { isAbs = isAbs; vol = vol; arcs = arcs' }

    let rec isCanonical s = s = mkCanonical s
    let rec isAbsolute s = (fromString s).isAbs
    let rec isRelative s = Bool.Bool.not (isAbsolute s)
    let rec isRoot s = s = "/" || s = "/."

    let rec concatArcs (arcs1, arcs2) =
      begin match splitLast arcs1 with
      | None -> arcs2
      | Some (arcs1', "") -> arcs1' @ arcs2
      | Some _ -> arcs1 @ arcs2
      end

    let rec concat (s1, s2) =
      let p1 = fromString s1 and p2 = fromString s2 in
      begin if p2.isAbs then raise Path
      else begin if p2.vol = "" || p1.vol = p2.vol then
        toString { isAbs = p1.isAbs; vol = p1.vol; arcs = concatArcs (p1.arcs, p2.arcs) }
      else raise Path
      end end

    let rec mkAbsolute (p : abs_rel) =
      begin if isRelative p.relativeTo then raise Path
      else begin if isAbsolute p.path then p.path
      else mkCanonical (concat (p.relativeTo, p.path))
      end end

    let rec stripCommonPrefix = function
      | x :: xs, y :: ys ->
        begin if x = y then stripCommonPrefix (xs, ys) else (x :: xs, y :: ys) end
      | xs, ys -> (xs, ys)

    let rec mkRelative (p : abs_rel) =
      let abs = mkCanonical p.relativeTo in
      let p1 = fromString p.path in
      let p2 = fromString abs in
      let arcs1 = begin match p1.arcs with [""] -> [] | _ -> p1.arcs end in
      begin if Bool.Bool.not p2.isAbs then raise Path
      else begin if Bool.Bool.not p1.isAbs then p.path
      else begin if Bool.Bool.not (p1.vol = p2.vol) then raise Path
      else begin match stripCommonPrefix (arcs1, p2.arcs) with
      | [], [] -> "."
      | arcs1', arcs2' ->
        toString { isAbs = false; vol = p1.vol;
          arcs = List.List.map (fun _ -> parentArc) arcs2' @ arcs1' }
      end end end end

    let rec fromUnixPath s = s
    let rec toUnixPath s = s
  end

  module Process = struct
    type nonrec status = int

    let success = 0
    let failure = 1
    let rec isSuccess st = st = 0
    let rec terminate (st : status) = (Stdlib.exit st : 'a)
    let exit = terminate
  end
end
