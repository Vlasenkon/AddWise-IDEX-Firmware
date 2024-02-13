; resume.g
; called before a print from SD card is resumed

M106 P5 S1
M106 R1  ; Recover part cooling

T R1                 ; select the tool that was active last time the print was paused

G1 R1 X0 Y0 Z3 F6000 ; go to 5mm above position of the last print move
G1 R1 X0 Y0          ; go back to the last print move
M83                  ; relative extruder moves
G1 E6 F3600          ; extrude 10mm of filament

M98 P"essential/leds/resume.g"