; resume.g
; called before a print from SD card is resumed

M204 P5000 T5000

M568 P0 A1
M568 P1 A1

T-1
T R1                 ; select the tool that was active last time the print was paused
M116 S5
M83                  ; relative extruder moves
G1 E50 F{60}*{3}     ; extrude filament
T-1
T R1                 ; select the tool that was active last time the print was paused



M106 P5 S1
M106 R1  ; Recover part cooling

M208 Z-1 S1         ; set axis minima to allow for wider range of Z - Offset


G1 R1 Z2 F18000       ; go above the position of the last print move
G1 R1 X0 Y0 F18000    ; go back to the last print move
G1 R1 Z0              ; go back to the last print move

M98 P"0:/sys/toolchangeretraction.g" ; Enable ToolChange Retraction

M98 P"0:/sys/led/resume.g"