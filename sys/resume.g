; resume.g
; called before a print from SD card is resumed

M204 P5000 T5000

M98 P"essential/autogen/pausetemp.g"
M116 S5


T-1
T R1                 ; select the tool that was active last time the print was paused
M83                  ; relative extruder moves
G1 E25 F{60}*{10}    ; extrude filament
T-1
T R1                 ; select the tool that was active last time the print was paused



M106 P5 S1
M106 R1  ; Recover part cooling


G1 R1 X0 Y0 Z1 F18000 ; go to 5mm above position of the last print move
G1 R1 X0 Y0 Z0        ; go back to the last print move


M98 P"essential/leds/resume.g"



; Enable ToolChange Retraction
echo >"essential/autogen/printretract.g" "; ToolChange Retraction Enabled"
echo >>"essential/autogen/printretract.g" "M83"

echo >>"essential/autogen/printretract.g" "if exists(param.R) && heat.heaters[state.currentTool].current > heat.coldRetractTemperature"
echo >>"essential/autogen/printretract.g" "  M116 P{state.currentTool} S20"
echo >>"essential/autogen/printretract.g" "  G1 E-25 F3000"

echo >>"essential/autogen/printretract.g" "elif exists(param.E) && heat.heaters[state.currentTool].current > heat.coldExtrudeTemperature"
echo >>"essential/autogen/printretract.g" "  M116 P{state.currentTool} S100"
echo >>"essential/autogen/printretract.g" "  G1 E30 F600"