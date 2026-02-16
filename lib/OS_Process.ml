[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2013-2025\n *\n * Standard ML Basis Library\n *)|}];;
module OS = struct
              module Path = OS_Path.OS.Path;;
              module FileSys = OS_FileSys.OS.FileSys;;
              module Process =
                struct
                  type nonrec status = int;;
                  let success = 0;;
                  let failure = 1;;
                  let rec isSuccess st = (st = 0);;
                  let rec terminate st =
                    ((((use { b = "OS.Process.terminate"} ) : (status -> 'a)))
                    st);;
                  let exit = terminate;;
                  end;;
              end;;