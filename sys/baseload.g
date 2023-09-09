M291 R"Please wait while the nozzle is being heated up" P" " S1 T5 ; Display message

G60 S2 ; Remember last tool selected

if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed || !move.axes[3].homed
  G28

G1 F18000 Z400 Y-70 X{move.axes[0].min} U{move.axes[3].max} F18000
M400

M116 S15; Wait for the temperatures to be reached


M291 R"Feed the filament, material will be extruded" P" " S4 K{"Extrude","Cancel",} ; Display user prompt
  if input = 0
    M83 ; Extruder to relative mode
    G1 E20 F300 ; Feed filament
    G1 E50 F1800 ; Feed filament
    G1 E100 F300 ; Feed filament
    while true
      M291 R"Should more filament be extruded?" P" " S4 K{"Extrude","Cancel",} ; Display user prompt
      if input = 0
        G1 E100 F300 ; Feed filament
        M400
          continue
      else
          break


G60 S2 ; Remember last tool selected
T-1  ; Deselect all tools
T R2 ; Select tool from memory slot

G10 S0 R0 ; Turn off the heater
M84 E0:1