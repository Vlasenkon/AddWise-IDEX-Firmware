M80
G4 S3
M280 P0 S160 I1

M98 P"tfree3.g"
M98 P"0:/sys/led/homeall.g"

T0 P0

G91                        ; use relative positioning

G1 H2 X10 U-10 F18000

M84 Y
G4 S1

M913 Y70 		           ; drop motor current
M204 P250 T250
M915 Y S8 R0 F0 	       ; set X and Y to sensitivity 3, do nothing when stall, unfiltered

G1 H2 Z20 F6000            ; lift Z relative to current position
G1 H1 Y500 F6000         ; move quickly to X axis endstop and stop there


M913 Y100
G1 Y-20 F6000         ; move quickly to X axis endstop and stop there

M84 Y
G4 s1

M913 Y70
G1 H1 Y500 F18000         ; move quickly to X axis endstop and stop there



M400                       ; make sure everything has stopped before we make changes
G90                        ; absolute positioning
M913 Y100                  ; return current to 100%
M204 P5000 T5000