M291 R"Please wait while the nozzle is being heated up" P"This may take a few minutes." S1 T10
M98 P"0:/sys/led/start_cold.g"

M83 ; Extruder to relative mode

;Load Speed
var ss = 0
if !exists(param.S)
  set var.ss = 600
else
  set var.ss = 200

M400
G60 S0 ; Remember last tool selected

if {state.status != "processing" || state.status != "pausing" || state.status != "paused" || state.status != "resuming"} && {!move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed || !move.axes[3].homed}
  G28


T R0 ; Select tool from memory slot
if move.axes[0].homed && move.axes[1].homed && move.axes[2].homed && move.axes[3].homed
  G90
  G1 F18000 Y0 X0 F18000
  
  if move.axes[2].machinePosition < 420
    G1 F18000 Z420



M116 P{state.restorePoints[2].toolNumber} S15; Wait for the temperatures to be reached
M98 P"0:/sys/led/start_hot.g"




M291 R"Feed the filament, material will be extruded" P"Press ""Extrude"" to start or ""Cancel"" to stop." S4 K{"Extrude","Cancel"}
if input = 0
  G1 E200 F{var.ss} ; Extrude
else
  M99


M400

while input = 0
  M291 R"Do you see new filament extruding?" P"Press ""Yes"" if filament is extruding or ""No"" to extrude more." S4 K{"No","Yes"}
  if input = 0
    G1 E50 F{var.ss} ; Extrude
    M400





M98 P"0:/sys/nozzlewipe.g" ; wipe curently active nozzle

if state.status == "processing" || state.status == "pausing" || state.status == "paused" || state.status == "resuming"
  ; Skip
else
  G10 S0 R0 ; Turn off the heater
  M84 E0:1