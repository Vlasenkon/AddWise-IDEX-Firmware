;New Home Y

if state.status == "off"
  M80                      ; Turn on power
  G4 S3
M98 P"essential/leds/homeall.g"
M98 P"tfree3.g"

T0 P0
M98 P"0:/macros/System/Calibration/Z Probe/Rotate holder to 0 degree"

G91                        ; use relative positioning
G1 H2 Z20 F6000            ; lift Z relative to current position
G1 H2 X10 U-10 F18000


; Senseless homing Y
M84 Y
G4 S1
M913 Y70               ; drop motor current
M204 P250 T250
M915 Y S3 R0 F0

M574 Y1 S3
G1 H1 Y-400 F6000           ; move quickly to X axis endstop and stop there

M913 Y100
M204 P5000 T5000

; Rough Home X and U
G90
G1 Y168 F18000
G91                     ; relative positioning
G1 H1 X-375 F6000       ; move quickly to X axis endstop and stop there (first pass)
G1 H1 U375 F6000        ; move quickly to U axis endstop and stop there (first pass)
G1 H2 X10 U-10 F6000
G91 ; relative positioning

M84 Y
G4 S1

; 1st pass Home Y
M574 Y2 S1 P"duex.e3stop+duex.e4stop"
G1 H1 Y50 F120

; 2nd pass Move Drive  0
M584 Y0
M574 Y2 S1 P"duex.e3stop"
G1 H1 Y5 F120

;; 3rd pass Move Drive  9
M584 Y9
M574 Y2 S1 P"duex.e4stop"
G1 H1 Y5 F120

; 4th pass Home Y
M584 Y0:9
M574 Y2 S1 P"duex.e3stop+duex.e4stop"
;G1 Y-10 F600
;G1 H1 Y15 F600

G90 ; absolute positioning


; Fine Home X and U
G90
G1 Y170 F6000
G91                     ; relative positioning
G1 H1 X-375 F600       ; move quickly to X axis endstop and stop there (first pass)
G1 H1 U375 F600        ; move quickly to U axis endstop and stop there (first pass)


M400                       ; make sure everything has stopped before we make changes
G90                        ; absolute positioning
M913 Y100                  ; return current to 100%
M204 P5000 T5000           ; Return the accelerations