M291 R"Please wait while the nozzle is being heated up" P" " S1 T10 ; Display message
M98 P"0:/sys/led/start_cold.g"

;Load Speed
var ss = 0
if !exists(param.S)
  set var.ss = 600
else
  set var.ss = 200

M400
G60 S0 ; Remember last tool selected


T R0 ; Select tool from memory slot
if move.axes[0].homed && move.axes[1].homed && move.axes[2].homed && move.axes[3].homed ;if XYU Homed
  G90
  G1 F18000 Z425 Y0 X-50 U50 F18000
  M400


M116 P{state.restorePoints[2].toolNumber} S15; Wait for the temperatures to be reached
M98 P"0:/sys/led/start_hot.g"


M291 R"Feed the filament, material will be extruded" P" " S4 K{"Extrude","Cancel",} ; Display user prompt
  if input = 0
    M83 ; Extruder to relative mode
    G1 E10 F{var.ss} ; Extrude
    G1 E200 F{var.ss} ; Extrude
    while true
      M400
      M291 R"Should more filament be extruded?" P" " S4 K{"Extrude","Done",} ; Display user prompt
      if input = 0
        G1 E100 F{var.ss} ; Extrude
        M400
          continue
  else
    break


M98 P"0:/sys/nozzlewipe.g" ; wipe curently active nozzle

if state.status == "processing" || state.status == "pausing" || state.status == "paused" || state.status == "resuming"
  ; Skip
else
  G10 S0 R0 ; Turn off the heater
  M84 E0:1