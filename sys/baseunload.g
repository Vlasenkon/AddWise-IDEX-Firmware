M291 R"Please wait while the nozzle is being heated up" P"This may take a few minutes." S1 T10

M98 P"0:/sys/led/start_cold.g"


;Unload Speed
var ss = 0
if !exists(param.S)
  set var.ss = 1200
else
  set var.ss = 200


M400
G60 S0 ; Remember last tool selected

T R0 ; Select tool from memory slot
if move.axes[0].homed && move.axes[1].homed && move.axes[2].homed && move.axes[3].homed ;if XYU Homed
  G90
  G1 F18000 Z425 F18000
  M400

M116 P{state.currentTool} S15; Wait for the temperatures to be reached
M98 P"0:/sys/led/start_hot.g"
  
M291 R"Retracting Filament" P" " S0 T15 ; Display  message
G1 E20 F{var.ss} ; Extrude
G1 E-20 F600 ; Retract
G1 E-100 F1800 ; Retract
M400 ; Wait for the moves to finish

M98 P"0:/sys/nozzlewipe.g" ; wipe curently active nozzle

if state.status == "processing" || state.status == "pausing" || state.status == "paused" || state.status == "resuming"
  ; Skip
else
  G10 S0 R0 ; Turn off the heater
  M84 E0:1