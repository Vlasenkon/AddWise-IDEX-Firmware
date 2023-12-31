; Home Y
M98 P"homey.g" L1

M204 T2000

; Home X and U
G1 Y162 F18000
G91                     ; relative positioning
G1 H1 X-375 U375 F6000  ; move quickly to both axis endstops and stop there (first pass)
G1 H1 X-375 F6000       ; move quickly to X axis endstop and stop there (first pass)
G1 H1 U375 F6000        ; move quickly to U axis endstop and stop there (first pass)
G1 H2 X5 U-5 F18000     ; go back a few mm
G1 H1 X-10 F240         ; move slowly to X axis endstop once more (second pass)
G1 H1 U10 F240          ; move slowly to U axis endstop once more (second pass)
G90                     ; absolute positioning



if exists(param.L) && exists(param.S)
  M98 P"bed.g" L1 S1 Z1
elif exists(param.L)
  M98 P"bed.g" L1 Z1
elif exists(param.S)
  M98 P"bed.g" S1 Z1
else
  M98 P"bed.g" Z1
if result !=0
  M98 P"0:/sys/led/fault.g"
  echo >>"Cancelled due to True Bed Leveling Error"
  abort "Cancelled due to True Bed Leveling Error"

if !exists(param.S)
  G1 X-999 U999 F18000 Y150 Z100 F18000

M204 T5000