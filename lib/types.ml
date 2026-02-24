(*
 * (c) Andreas Rossberg 2001-2025
 *
 * Standard ML Basis Library top-level types
 *
 * Note:
 * - Vector, array, and substring types are declared with the modules.
 *)
type nonrec unit = unit
type nonrec int = int
type nonrec word = int
type nonrec real = float
type nonrec char = char
type nonrec string = string
type nonrec exn = exn
type nonrec 'a ref = 'a ref
type nonrec bool = bool
type nonrec 'a list = 'a list
type 'a option = None | Some of 'a
type order = Less | Equal | Greater
