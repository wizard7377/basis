[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Notes:\n * - Only valid for Unix-like APIs.\n * - There are several inconsistencies in the spec, particularly with respect\n *   to canonical paths.\n *)|}];;
module OS = struct
              module Path =
                struct
                  let ( ^ ) = String.( ^ );;
                  let ( @ ) = List.( @ );;
                  type path_info = { isAbs : bool; vol : string; arcs : string list };;
                  type dir_file = { dir : string; file : string };;
                  type base_ext = { base : string; ext : string option };;
                  type arc_base_ext = { abase : string; aext : string };;
                  type path_rel = { path : string; relativeTo : string };;
                  let rec splitLast =
                    (function 
                              | [] -> None
                              | (x :: xs)
                                  -> begin
                                     match (splitLast xs)
                                     with 
                                          | None -> (Some ([], x))
                                          | (Some (ys, y))
                                              -> (Some ((x :: ys), y))
                                     end);;
                  exception Path ;;
                  exception InvalidArc ;;
                  let currentArc = ".";;
                  let parentArc = "..";;
                  let rec isArcSep c = (c = '/');;
                  let rec isExtSep c = (c = '.');;
                  let rec validVolume =
                    (function 
                              | { isAbs; vol = ""; arcs = _} -> true
                              | _ -> false);;
                  let rec fromString s =
                    begin
                    match (String.fields isArcSep s)
                    with 
                         | ("" :: [])
                             -> { isAbs = false; vol = ""; arcs = []} 
                         | ("" :: arcs) -> { isAbs = true; vol = ""; arcs} 
                         | arcs -> { isAbs = false; vol = ""; arcs} 
                    end;;
                  let rec validArc arc =
                    begin
                    match (fromString arc)
                    with 
                         | { isAbs = false; vol = ""; arcs} -> (((List.length arcs)) <= 1)
                         | _ -> false
                    end;;
                  let rec toString =
                    (function 
                              | { isAbs = false; vol; arcs = ("" :: _)}
                                  -> (raise Path)
                              | { isAbs; vol; arcs} -> begin
                                  if
                                  (Bool.not ((validVolume { isAbs; vol; arcs = [] } )))
                                  then (raise Path) else begin
                                  if (Bool.not ((List.all validArc arcs)))
                                  then (raise InvalidArc) else
                                  (((vol ^
                                      (begin if isAbs then "/" else "" end)))
                                    ^ ((String.concatWith "/" arcs)))
                                  end end);;
                  let rec getVolume s = "";;
                  let rec getParent s = begin
                    if (s = "/") then s else
                    (let { isAbs; vol; arcs} =
                       (fromString s)
                     in begin
                        match (splitLast arcs)
                        with 
                             | None -> ".."
                             | (Some (_, "")) -> (s ^ "..")
                             | (Some (_, ".")) -> (s ^ ".")
                             | (Some (_, "..")) -> (s ^ "/..")
                             | (Some ([], _))
                                 -> (toString { isAbs; vol; arcs = ["."]} )
                             | (Some (arcs, _))
                                 -> (toString { isAbs; vol; arcs} )
                        end)
                    end;;
                  let rec splitDirFile s =
                    (let { isAbs; vol; arcs} =
                       (fromString s)
                     in begin
                        match (splitLast arcs)
                        with 
                             | None
                                 -> {
                                    dir
                                    = (toString { isAbs; vol; arcs = []} );
                                    file = ""}
                                    
                             | (Some (arcs, arc))
                                 -> {
                                    dir = (toString { isAbs; vol; arcs} );
                                    file = arc}
                                    
                        end);;
                  let rec joinDirFile { dir; file} =
                    (let { isAbs; vol; arcs} =
                       (fromString dir)
                     in (let arcs = begin
                           if (((List.null arcs)) && ((file = ""))) then []
                           else (arcs @ [file]) end
                         in (toString { isAbs; vol; arcs} )));;
                  let rec splitArcBaseExt arc =
                    (let (base, ext) =
                       (Substring.splitr
                       ((o Bool.not isExtSep))
                       ((Substring.full arc)))
                     in begin
                     if
                     (((Substring.isEmpty ext)) ||
                       ((((Substring.size base)) <= 1)))
                     then None else
                     (Some
                      {
                      abase = (Substring.string ((Substring.trimr 1 base)));
                      aext = (Substring.string ext)}
                      )
                     end);;
                  let rec splitBaseExt s =
                    (let { isAbs; vol; arcs} =
                       (fromString s)
                     in begin
                        match (splitLast arcs)
                        with 
                             | None
                                 -> {
                                    base
                                    = (toString { isAbs; vol; arcs = []} );
                                    ext = None}
                                    
                             | (Some (arcs, arc))
                                 -> begin
                                    match (splitArcBaseExt arc)
                                    with 
                                         | None -> { base = s; ext = None} 
                                         | (Some { abase = base; aext = ext})
                                             -> {
                                                base
                                                = (toString
                                                  {
                                                  isAbs;
                                                  vol;
                                                  arcs = (arcs @ [base])}
                                                  );
                                                ext = (Some ext)}
                                                
                                    end
                        end);;
                  let rec joinBaseExt =
                    (function 
                              | { base; ext = None} -> base
                              | { base; ext = (Some "")}
                                  -> base
                              | { base; ext = (Some arc)}
                                  -> (((base ^ ".")) ^ arc));;
                  let dir = (o ((fun r -> r.dir)) splitDirFile);;
                  let file = (o ((fun r -> r.file)) splitDirFile);;
                  let base = (o ((fun r -> r.base)) splitBaseExt);;
                  let ext = (o ((fun r -> r.ext)) splitBaseExt);;
                  let rec mkCanonicalArcs =
                    (function 
                              | (((false, [], []))[@sml.comment
                                                       {|(*isAbs*)|}])
                                  -> ["."]
                              | (isAbs, [], arcs_prime)
                                  -> (List.rev arcs_prime)
                              | (isAbs, ("" :: arcs), arcs_prime)
                                  -> (mkCanonicalArcs
                                     (isAbs, arcs, arcs_prime))
                              | (isAbs, ("." :: arcs), arcs_prime)
                                  -> (mkCanonicalArcs
                                     (isAbs, arcs, arcs_prime))
                              | (true, (".." :: arcs), [])
                                  -> (mkCanonicalArcs (true, arcs, []))
                              | (isAbs, (".." :: arcs), (".." :: arcs_prime))
                                  -> (mkCanonicalArcs
                                     (true, arcs,
                                      (".." :: ".." :: arcs_prime)))
                              | (isAbs, (".." :: arcs), (_ :: arcs_prime))
                                  -> (mkCanonicalArcs
                                     (isAbs, arcs, arcs_prime))
                              | (isAbs, (arc :: arcs), arcs_prime)
                                  -> (mkCanonicalArcs
                                     (isAbs, arcs, (arc :: arcs_prime))));;
                  let rec mkCanonical s =
                    (let { isAbs; vol; arcs} =
                       (fromString s)
                     in (let arcs_prime = (mkCanonicalArcs (isAbs, arcs, []))
                         in (toString { isAbs; vol; arcs = arcs_prime} )));;
                  let rec isCanonical s = (s = ((mkCanonical s)));;
                  let rec isAbsolute s =
                    (((fun r -> r.isAbs)) ((fromString s)));;
                  let rec isRelative s = (Bool.not ((isAbsolute s)));;
                  let rec isRoot s = (((s = "/")) || ((s = "/.")));;
                  let rec concatArcs (arcs1, arcs2) =
                    begin
                    match (splitLast arcs1)
                    with 
                         | None -> arcs2
                         | (Some (arcs1_prime, "")) -> (arcs1_prime @ arcs2)
                         | (Some _) -> (arcs1 @ arcs2)
                    end;;
                  let rec concat (s1, s2) =
                    begin
                    match ((fromString s1), (fromString s2))
                    with 
                         | (_, { isAbs = true; vol = _; arcs = _}) -> (raise Path)
                         | ({ isAbs; vol = vol1; arcs = arcs1},
                            { isAbs = _; vol = vol2; arcs = arcs2})
                             -> begin
                             if (((vol2 = "")) || ((vol1 = vol2))) then
                             (toString
                             {
                             isAbs;
                             vol = vol1;
                             arcs = (concatArcs (arcs1, arcs2))}
                             ) else (raise Path) end
                    end;;
                  let rec mkAbsolute { path; relativeTo} = begin
                    if (isRelative relativeTo) then (raise Path) else begin
                    if (isAbsolute path) then path else
                    (mkCanonical ((concat (relativeTo, path)))) end end;;
                  let rec stripCommonPrefix =
                    (function 
                              | ((x :: xs), (y :: ys)) -> begin
                                  if (x = y) then
                                  (stripCommonPrefix (xs, ys)) else
                                  ((x :: xs), (y :: ys)) end
                              | (xs, ys) -> (xs, ys));;
                  let rec mkRelative { path; relativeTo} =
                    (let abs = (mkCanonical relativeTo)
                     in (let
                           { isAbs = isAbs1; vol = vol1; arcs = arcs1}
                           = (fromString path)
                         in (let
                               { isAbs = isAbs2; vol = vol2; arcs = arcs2}
                               = (fromString abs)
                             in (let arcs1 =
                                   begin
                                   match arcs1
                                   with 
                                        | ("" :: []) -> []
                                        | _ -> arcs1
                                   end
                                 in begin
                                 if (Bool.not isAbs2) then (raise Path) else
                                 begin
                                 if (Bool.not isAbs1) then path else begin
                                 if (Bool.not ((vol1 = vol2))) then
                                 (raise Path) else
                                 begin
                                 match (stripCommonPrefix (arcs1, arcs2))
                                 with 
                                      | ([], []) -> "."
                                      | (arcs1_prime, arcs2_prime)
                                          -> (toString
                                             {
                                             isAbs = false;
                                             vol = vol1;
                                             arcs
                                             = (((List.map
                                                 ((function 
                                                            | _ -> parentArc))
                                                 arcs2_prime)) @ arcs1_prime)}
                                             )
                                 end end end end))));;
                  let rec fromUnixPath s = s;;
                  let rec toUnixPath s = s;;
                  end;;
              end;;