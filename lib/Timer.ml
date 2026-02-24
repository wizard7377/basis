open Time 
type tpair__ = {
  usr : Time.time;
  sys : Time.time
}
type cpu_times__ = {
  nongc : tpair__;
  gc : tpair__
}
module type TIMER = sig

type cpu_timer
type real_timer
val startCPUTimer : unit -> cpu_timer
val checkCPUTimes : cpu_timer
                      -> cpu_times__
val checkCPUTimer : cpu_timer
                      -> tpair__
val checkGCTime : cpu_timer -> Time.time
val totalCPUTimer : unit -> cpu_timer
val startRealTimer : unit -> real_timer
val checkRealTimer : real_timer -> Time.time
val totalRealTimer : unit -> real_timer

end 