(* 
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library
 *
 * Note: Incomplete.
  *);;
open General;;
open OS_FILE_SYS_sig;;
open OS_PATH_sig;;
open OS_PROCESS_sig;;
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
                 end;;
(* 
  val errorMsg : syserror -> string
  val errorName : syserror -> string
  val syserror : string -> syserror option
 *);;