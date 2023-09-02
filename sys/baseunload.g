M291 R"Please wait while the nozzle is being heated up" P" " T5 ; Display message

if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed || !move.axes[3].homed
  G28

G1 F18000 Z400 Y-70 X-999 U999
M400

M116 S15; Wait for the temperatures to be reached
M291 R"Retracting Filament" P" " T5 ; Display another message
G1 E-20 F300 ; Retract 20mm of filament at 300mm/min
G1 E-100 F3000 ; Retract 480mm of filament at 3000mm/min
M400 ; Wait for the moves to finish

G10 S0 R0 ; Turn off the heater
M84 E0:1