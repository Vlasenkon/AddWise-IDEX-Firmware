; pause.g
; called when a print from SD card is paused

; Disable ToolChange Retraction
echo >"essential/autogen/printretract.g" "; ToolChange Retraction Disabled"

; Save Tool Temperature
echo >"essential/autogen/pausetemp.g" "G10 P0 S"^{heat.heaters[0].active}^" R"^{heat.heaters[0].standby}^""
echo >>"essential/autogen/pausetemp.g" "G10 P1 S"^{heat.heaters[1].active}^" R"^{heat.heaters[1].standby}^""
echo >>"essential/autogen/pausetemp.g" "G10 P2 S"^{heat.heaters[2].active}^" R"^{heat.heaters[2].standby}^""
echo >>"essential/autogen/pausetemp.g" "G10 P3 S"^{heat.heaters[3].active}^" R"^{heat.heaters[3].standby}^""

; Redure Tool Temperature
var tt = 100
G10 P0 S{heat.heaters[0].active-var.tt} R{heat.heaters[0].standby-var.tt}
G10 P1 S{heat.heaters[1].active-var.tt} R{heat.heaters[1].standby-var.tt}
G10 P2 S{heat.heaters[2].active-var.tt} R{heat.heaters[2].standby-var.tt}
G10 P3 S{heat.heaters[3].active-var.tt} R{heat.heaters[3].standby-var.tt}


M204 P5000 T5000

M83            ; relative extruder moves
G1 E-25 F{60}*{50}  ; retract 10mm of filament
G91            ; relative positioning
G1 Z100 F18000 ; lift Z
G90            ; absolute positioning
G1 Y150 F6000

M106 P5 S0
M106 S0

; If one of the heaters failed light alarm LEDs or normal pause LEDs otherwise
if heat.heaters[0].state == "fault" || heat.heaters[1].state == "fault" || heat.heaters[2].state == "fault" || heat.heaters[3].state == "fault"
  M98 P"essential/leds/fault.g"  
else
  M98 P"essential/leds/pause.g"