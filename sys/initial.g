; Preheat
M98 P"essential/leds/start_cold.g"
M98 P"essential/preheat.g"
M98 P"essential/leds/start_hot.g"

; Turn E-Cooling Fan on
M106 P5 S1

; Save selectrd tool to slot 0
G60 S0

; Home the machine
M98 P"homeall.g" Z1 S1 L1

; Run Mesh Compensation
G29


;Purging and Cleaning the nozzles
G90
G1 Y-70 X-999 U999 F18000


; Purge
T R0        ; Load previously selected tool and purge 50mm of filament
M83
G1 E50 F300
G4 S1

; Clean the nozzles
G91
G1 F18000

if state.currentTool == 0
  G1  X30
  G1 X-30
  G1  X30
  G1 X-30
  echo "0"
elif state.currentTool == 1
  G1 X-30
  G1  X30
  G1 X-30
  G1  X30
  echo "1"
elif state.currentTool == 3
  G1  X30
  G1 X-30
  G1  X30
  G1 X-30
  echo "3"

G90


; Enable ToolChange Retraction
echo >"essential/autogen/printretract.g" "; ToolChange Retraction Enabled"
echo >>"essential/autogen/printretract.g" "M83"

echo >>"essential/autogen/printretract.g" "if exists(param.R) && heat.heaters[state.currentTool].current > heat.coldRetractTemperature"
echo >>"essential/autogen/printretract.g" "  M116 P{state.currentTool} S20"
echo >>"essential/autogen/printretract.g" "  G1 E-25 F3000"

echo >>"essential/autogen/printretract.g" "elif exists(param.E) && heat.heaters[state.currentTool].current > heat.coldExtrudeTemperature"
echo >>"essential/autogen/printretract.g" "  M116 P{state.currentTool} S100"
echo >>"essential/autogen/printretract.g" "  G1 E30 F600"