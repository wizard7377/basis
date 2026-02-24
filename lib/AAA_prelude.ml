(*  Prelude: pre-register General's constructors for the converter  *)
module General = struct
  type order = Less | Equal | Greater

  exception Subscript
  exception Chr
  exception Overflow
  exception Fail of string
end

type nonrec word = int
type nonrec real = float
