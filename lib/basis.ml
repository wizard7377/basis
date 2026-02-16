[@@@sml.comment
  {|(*\n * (c) Andreas Rossberg 2001-2025\n *\n * Standard ML Basis Library\n *\n * Notes:\n * - We only implement required structures (and their signatures).\n * - Modules commented out are not yet implemented.\n *)|}];;
let use : (string -> unit) = fun _ -> ();;
let _ =
  begin
    (use "infix.sml");
    begin
      (use "types.sml");
      begin
        (use "exceptions.sml");
        begin
          (use "GENERAL-sig.sml");
          begin
            (use "General.sml");
            begin
              (use "OPTION-sig.sml");
              begin
                (use "Option.sml");
                begin
                  (use "BOOL-sig.sml");
                  begin
                    (use "Bool.sml");
                    begin
                      (use "LIST-sig.sml");
                      begin
                        (use "List.sml");
                        begin
                          (use "LIST_PAIR-sig.sml");
                          begin
                            (use "ListPair.sml");
                            begin
                              (use "CHAR-sig.sml");
                              begin
                                (use "Char.sml");
                                begin
                                  (use "STRING-sig.sml");
                                  begin
                                    (use "String.sml");
                                    begin
                                      (use "SUBSTRING-sig.sml");
                                      begin
                                        (use "Substring.sml");
                                        begin
                                          (use "STRING_CVT-sig.sml");
                                          begin
                                            (use "StringCvt.sml");
                                            begin
                                              (use "INTEGER-sig.sml");
                                              begin
                                                (use "Int.sml");
                                                begin
                                                  (use "LargeInt.sml");
                                                  begin
                                                    (use "Position.sml");
                                                    begin
                                                      (use "WORD-sig.sml");
                                                      begin
                                                        (use "Word.sml");
                                                        begin
                                                          (use "Word8.sml");
                                                          begin
                                                            (use
                                                            "LargeWord.sml");
                                                            begin
                                                              (use
                                                              "IEEE_REAL-sig.sml");
                                                              begin
                                                                (use
                                                                "IEEEReal.sml");
                                                                begin
                                                                  (use
                                                                  "MATH-sig.sml");
                                                                  begin
                                                                    (use
                                                                    "Math.sml");
                                                                    begin
                                                                    (use
                                                                    "REAL-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "Real.sml");
                                                                    begin
                                                                    (use
                                                                    "LargeReal.sml");
                                                                    begin
                                                                    (use
                                                                    "TIME-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "Time.sml");
                                                                    begin
                                                                    (use
                                                                    "VECTOR-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "Vector.sml");
                                                                    begin
                                                                    (use
                                                                    "MONO_VECTOR-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "Word8Vector.sml");
                                                                    begin
                                                                    (use
                                                                    "CharVector.sml");
                                                                    begin
                                                                    (use
                                                                    "VECTOR_SLICE-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "VectorSlice.sml");
                                                                    begin
                                                                    (use
                                                                    "MONO_VECTOR_SLICE-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "Word8VectorSlice.sml");
                                                                    begin
                                                                    (use
                                                                    "CharVectorSlice.sml");
                                                                    begin
                                                                    (use
                                                                    "ARRAY-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "Array.sml");
                                                                    begin
                                                                    (use
                                                                    "MONO_ARRAY-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "Word8Array.sml");
                                                                    begin
                                                                    (use
                                                                    "CharArray.sml");
                                                                    begin
                                                                    (use
                                                                    "ARRAY_SLICE-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "ArraySlice.sml");
                                                                    begin
                                                                    (use
                                                                    "MONO_ARRAY_SLICE-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "Word8ArraySlice.sml");
                                                                    begin
                                                                    (use
                                                                    "CharArraySlice.sml");
                                                                    begin
                                                                    (use
                                                                    "BYTE-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "Byte.sml");
                                                                    begin
                                                                    (use
                                                                    "TEXT-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "Text.sml");
                                                                    begin
                                                                    (use
                                                                    "IO-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "IO.sml");
                                                                    begin
                                                                    (use
                                                                    "STREAM_IO-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "IMPERATIVE_IO-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "TEXT_STREAM_IO-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "TEXT_IO-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "TextIO.sml");
                                                                    begin
                                                                    (use
                                                                    "OS_FILE_SYS-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "OS_PATH-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "OS_PROCESS-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "OS-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "OS_Path.sml");
                                                                    begin
                                                                    (use
                                                                    "OS_FileSys.sml");
                                                                    begin
                                                                    (use
                                                                    "OS_Process.sml");
                                                                    begin
                                                                    (use
                                                                    "OS.sml");
                                                                    begin
                                                                    (use
                                                                    "COMMAND_LINE-sig.sml");
                                                                    begin
                                                                    (use
                                                                    "CommandLine.sml");
                                                                    begin
                                                                    (use
                                                                    "values.sml");
                                                                    ()
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end
                                                                    end

                                                                  end
                                                                
                                                                end
                                                              
                                                              end
                                                            
                                                            end
                                                          
                                                          end
                                                        
                                                        end
                                                      
                                                      end
                                                    
                                                    end
                                                  
                                                  end
                                                
                                                end
                                              
                                              end
                                            
                                            end
                                          
                                          end
                                        
                                        end
                                      
                                      end
                                    
                                    end
                                  
                                  end
                                
                                end
                              
                              end
                            
                            end
                          
                          end
                        
                        end
                      
                      end
                    
                    end
                  
                  end
                
                end
              
              end
            
            end
          
          end
        
        end
      
      end
    
    end
  [@sml.comment {|(*use \"PRIM_IO-sig.sml\";*)|}][@sml.comment
                                                   {|(*use \"BinPrimIO.sml\";*)|}]
  [@sml.comment {|(*use \"TextPrimIO.sml\";*)|}][@sml.comment
                                                  {|(*use \"BIN_IO-sig.sml\";*)|}]
  [@sml.comment {|(*use \"BinIO.sml\";*)|}][@sml.comment
                                             {|(*use \"OS_IO-sig.sml\";*)|}]
  [@sml.comment {|(*use \"OS_IO.sml\";*)|}][@sml.comment
                                             {|(*use \"DATE-sig.sml\";*)|}]
  [@sml.comment {|(*use \"Date.sml\";*)|}][@sml.comment
                                            {|(*use \"TIMER-sig.sml\";*)|}]
  [@sml.comment {|(*use \"Timer.sml\";*)|}];;