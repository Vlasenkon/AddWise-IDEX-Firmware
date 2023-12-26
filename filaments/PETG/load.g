M291 R"Please wait while the nozzle is being heated up" P" " T5 ; Display message
G10 S240 ; Set current tool temperature

if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed || !move.axes[3].homed
  G28

G60 S2 ; Remember last tool selected
T-1  ; Deselect all tools
T R2 ; Select tool from memory slot

M116 S15; Wait for the temperatures to be reached

M291 R"Feed the filament, material will be extruded" P"Click ok when to start extruding" S3 ; Display new message
M83 ; Extruder to relative mode
G1 E20 F300 ; Feed filament
G1 E50 F1800 ; Feed filament
G1 E100 F300 ; Feed filament
G60 S2 ; Remember last tool selected
T-1  ; Deselect all tools
T R2 ; Select tool from memory slot
G10 S0 ; Turn off the heater again
M84 E0:1

while true
  M291 P"Should more filament be extruded?" S3 ; Display new message
  G10 S240 ; Set current tool temperature
  G1 E100 F300 ; Feed filament
  G60 S2 ; Remember last tool selected
  T-1  ; Deselect all tools
  T R2 ; Select tool from memory slot
  G10 S0 ; Turn off the heater again
  M84 E0:1