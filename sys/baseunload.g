M291 R"Please wait while the nozzle is being heated up" P" " T5 ; Display message

M98 P"0:/sys/led/start_cold.g"


;Unload Speed
if !exists(param.S)
  var ss = 1200
else
  var ss = 200


M400
G60 S2 ; Remember last tool selected

if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed || !move.axes[3].homed
  G28

T R2 ; Select tool from memory slot

G90
G1 F18000 Z425 Y-70 X{move.axes[0].min} U{move.axes[3].max} F18000
M400

M116 S15; Wait for the temperatures to be reached
M98 P"0:/sys/led/start_hot.g"
  
M291 R"Retracting Filament" P" " T5 ; Display  message
G1 E-20 F{var.ss} ; Retract
G1 E-100 F{var.ss} ; Retract
M400 ; Wait for the moves to finish

G10 S0 R0 ; Turn off the heater
M84 E0:1