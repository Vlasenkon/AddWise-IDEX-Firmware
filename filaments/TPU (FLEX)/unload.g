M291 R"Please wait while the nozzle is being heated up" P" " T5 ; Display message
G10 S200 ; Heat up the current tool to 100C
M116 S15; Wait for the temperatures to be reached
M291 R"Retracting Filament" P" " T5 ; Display another message
G1 E-20 F300 ; Retract 20mm of filament at 300mm/min
G1 E-100 F300 ; Retract 480mm of filament at 3000mm/min
M400 ; Wait for the moves to finish
G10 S0 ; Turn off the heater
M84 E0:1 ; Turn off extruder drives 1 and 2