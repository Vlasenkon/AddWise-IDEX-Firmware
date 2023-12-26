M291 R"Wait for Extruders to reach required temperature" P" " S0

T1 P0
T0 P0
G10 P0 S270 R270
G10 P1 S270 R270

G28

M116 P0 S10
M116 P1 S10

G29 S2

T0
G1 U999 F18000

G1 X0 Y-120 Z0.2 F18000
G92 Z1.2

M291 R"1/2" P"Position a sheet of paper under the nozzle, move Z axis with small increments until you feel slight resistance when dragging a paper sheet." S3
M291 R"2/2" P"When optimal Z height is found, click 'Test Right Tool', undo 2 screws and manually move hotend up or down until you feel the same resistance when dragging paper sheet." S3