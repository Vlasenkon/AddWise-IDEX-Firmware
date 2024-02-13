M98 P"homey.g"

; Home X and Y
;G91
;G1 H2 X5 U-5 F18000
;G90
G1 Y165 F18000

G91                  ; relative positioning
G1 H1 X-400 F6000    ; move quickly to X axis endstop and stop there (first pass)
G1 H1 U400 F6000     ; move quickly to X axis endstop and stop there (first pass)
G1 H2 X5 U-5 F18000  ; go back a few mm
G1 H1 X-400 F240     ; move slowly to X axis endstop once more (second pass)
G1 H1 U400 F240      ; move slowly to X axis endstop once more (second pass)
G90                  ; absolute positioning

;Fast Home Z
T0
M558 P9 C"^zprobe.in" H30 F1200 T18000
M98 P"essential/autogen/ProbeOffset.g"


G90                      ; absolute positioning
G1 X-19.50 Y23.00 F18000 ; go to first probe point
G30                      ; home Z by probing the bed

;Fast Bed Leveling
G1 U999 F18000
G30 P0 X36.3 Y-34.3 Z-99999         ; probe near an adjusting screw
G30 P1 X-36.3 Y-34.3 Z-99999   ; probe near an adjusting screw
G30 P2 X0 Y50 Z-99999 S3 ; probe near an adjusting screw and report adjustments needed

M558 P9 C"^zprobe.in" H5 F240 T18000
M98 P"essential/autogen/ProbeOffset.g"

;True Bed Leveling
G32

G1 X-999 U999 Y160 Z100 F18000