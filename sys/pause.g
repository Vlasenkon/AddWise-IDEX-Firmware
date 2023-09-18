; pause.g
; called when a print from SD card is paused

G60 S1


; Disable ToolChange Retraction
echo >"essential/autogen/printretract.g" "; ToolChange Retraction Disabled"

M204 P5000 T5000

M83            ; relative extruder moves
G1 E-5 F{60}*{50}  ; retract 10mm of filament
G91            ; relative positioning
G1 Z100 F18000 ; lift Z
G90            ; absolute positioning
G1 Y150 F6000

M106 P5 S0
M106 S0


M568 P0 A0
M568 P1 A0


; If one of the heaters failed light alarm LEDs or normal pause LEDs otherwise
if heat.heaters[0].state == "fault" || heat.heaters[1].state == "fault" || heat.heaters[2].state == "fault" || heat.heaters[3].state == "fault"
  M98 P"essential/leds/fault.g"  
else
  M98 P"essential/leds/pause.g"