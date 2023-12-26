T0 P0


M83            ; relative extruder moves
G1 E-5 F3600  ; retract 10mm of filament

G91               ; relative positioning
G1 Z50 F18000     ; lift Z relative to current position
G90               ; absolute positioning
G1 Y160 F18000

; Disable Fans
M106 P5 S0
M106 P3 S0
M106 P1 S0

;Cool Down Tools
G10 P0 S0 R0
G10 P1 S0 R0
G10 P2 S0 R0
G10 P3 S0 R0

M140 S0 R0    ; Bed heater off
M141 S0       ; turn off chamber heater

M98 P"essential/leds/end.g"

M98 P"essential/autogen/bedfinishbehavior.g"	; decide what to do with bed after printing is finished