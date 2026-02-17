[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note: Incomplete.\n *)|}];;
module OS = struct
              module Path = OS_Path.OS.Path;;
              module FileSys =
                struct
                  let getDir =
                    ((use { b = "OS.FileSys.getDir"} ) : (unit -> string));;
                  let chDir =
                    ((use { b = "OS.FileSys.chDir"} ) : (string -> unit));;
                  let mkDir =
                    ((use { b = "OS.FileSys.mkDir"} ) : (string -> unit));;
                  let rmDir =
                    ((use { b = "OS.FileSys.rmDir"} ) : (string -> unit));;
                  let isDir =
                    ((use { b = "OS.FileSys.isDir"} ) : (string -> bool));;
                  end;;
              end;;