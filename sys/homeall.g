; Home Y
M98 P"homey.g" L1

;; Home X and U
;G1 Y160 F18000
;G91                     ; relative positioning
;G1 H1 X-375 F6000       ; move quickly to X axis endstop and stop there (first pass)
;G1 H1 U375 F6000        ; move quickly to U axis endstop and stop there (first pass)
;G1 H2 X5 U-5 F18000     ; go back a few mm
;G1 H1 X-10 F240         ; move slowly to X axis endstop once more (second pass)
;G1 H1 U10 F240          ; move slowly to U axis endstop once more (second pass)
;G90                     ; absolute positioning



if exists(param.L) && exists(param.S)
  M98 P"bed.g" L1 S1 Z1
elif exists(param.L)
  M98 P"bed.g" L1 Z1
elif exists(param.S)
  M98 P"bed.g" S1 Z1
else
  M98 P"bed.g" Z1
 

if !exists(param.S)
  G1 X{move.axes[0].min} U{move.axes[3].max} F18000 Y150 Z100 F18000