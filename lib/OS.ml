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

  (*  defunct dummy  *)
  module FileSys : OS_FILE_SYS = struct
    let getDir : unit -> string = raise (General.Fail "TODO")
    let chDir : string -> unit = raise (General.Fail "TODO")
    let mkDir : string -> unit = raise (General.Fail "TODO")
    let rmDir : string -> unit = raise (General.Fail "TODO")
    let isDir : string -> bool = raise (General.Fail "TODO")
  end

  module Path = struct
    exception Path
    exception InvalidArc

    let currentArc = "."
    let parentArc = ".."
    let rec validVolume _ = raise (General.Fail "TODO")
    let rec fromString s = raise (General.Fail "TODO")
    let rec validArc arc = raise (General.Fail "TODO")
    let rec toString p = raise (General.Fail "TODO")
    let rec getVolume s = ""
    let rec getParent s = raise (General.Fail "TODO")
    let rec splitDirFile s = raise (General.Fail "TODO")
    let rec joinDirFile p = raise (General.Fail "TODO")
    let rec splitBaseExt s = raise (General.Fail "TODO")
    let rec joinBaseExt p = raise (General.Fail "TODO")
    let rec dir s = raise (General.Fail "TODO")
    let rec file s = raise (General.Fail "TODO")
    let rec base s = raise (General.Fail "TODO")
    let rec ext s = raise (General.Fail "TODO")
    let rec mkCanonical s = raise (General.Fail "TODO")
    let rec isCanonical s = raise (General.Fail "TODO")
    let rec isAbsolute s = raise (General.Fail "TODO")
    let rec isRelative s = raise (General.Fail "TODO")
    let rec isRoot s = raise (General.Fail "TODO")
    let rec concat (s1, s2) = raise (General.Fail "TODO")
    let rec mkAbsolute p = raise (General.Fail "TODO")
    let rec mkRelative p = raise (General.Fail "TODO")
    let rec fromUnixPath s = s
    let rec toUnixPath s = s
  end

  module Process = struct
    type nonrec status = int

    let success = 0
    let failure = 1
    let rec isSuccess st = st = 0
    let rec terminate (st : status) = (raise (General.Fail "TODO") : 'a)
    let exit = terminate
  end
end
