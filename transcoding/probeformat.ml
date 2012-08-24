open Printf

let probe () = 
  let res = ref [] in 
  let currentline = ref [] in 
  (try
     while true do
       let line = input_line stdin in
       if line <> "[/STREAM]" then 
         currentline := line :: !currentline 
       else
         (res := !res @ [!currentline];
          currentline := [])
     done;
   with
     _ -> ());
  (*printf "%i\n" (List.length !res);*)
  let isaudioaac = List.for_all (fun l -> not (List.mem "codec_type=audio" l) || List.mem "codec_name=aac" l) !res in  
  let isvideoh264 = List.for_all (fun l -> not (List.mem "codec_type=video" l) || List.mem "codec_name=h264" l) !res in  
  (*printf "isaudioaac = %B; isvideoh264 = %B\n" isaudioaac isvideoh264;*)
  if not isaudioaac then printf "a";
  if not isvideoh264 then printf "v";;

probe ();;


