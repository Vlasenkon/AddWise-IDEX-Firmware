M80

; Preheat
M98 P"essential/leds/start_cold.g"
M98 P"essential/preheat.g"
M98 P"essential/leds/start_hot.g"
; Save current tool to slot 0
G60 S0

M98 P"initial-homing.g"

;Clean the nozzles
G91
G1 Z5
G90
G1 Y-75 X-999 U999 F18000

G91
G1 X30 U-30 F18000
G1 X-30 U30 F18000
G1 X30 U-30 F18000
G1 X-30 U30 F18000
G90

; Home Z - Axis
G1 Z5
M98 P"homez.g"
M106 P5 S1

G29 ; Run Mesh Bed Leveling

;Purging and Cleaning the nozzles
G90
G1 Y-75 X-999 U999 F18000

G91
M83
T R0
G1 E50 F300
G4 S3

G1 X30 U-30 F18000
G1 X-30 U30 F18000
G1 X30 U-30 F18000
G1 X-30 U30 F18000
G90