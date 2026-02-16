[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Note: Incomplete.\n *)|}];;
module OS =
  struct
    module Path = OS_Path.OS.Path;;
    module FileSys = OS_FileSys.OS.FileSys;;
    module Process = OS_Process.OS.Process;;
    type nonrec syserror = int;;
    exception SysErr of (string * syserror option) ;;
    end;;
[@@@sml.comment {|(* defunct dummy *)|}];;