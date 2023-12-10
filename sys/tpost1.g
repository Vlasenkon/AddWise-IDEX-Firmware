;M204 T5000

; Lower Z to 10mm if lower than that for safety
if move.axes[2].machinePosition < 10 && state.status != "processing"  && state.status != "pausing" && state.status != "resuming"
	G90
	G1 F18000 Z10

G90
G1 Y-70 X-999 U999 F18000

M98 P"0:/user/toolchangeretraction.g" E1

G91
G1 X-30 F12000
G1 X30
G1 X-30
G1 X30
G90

M106 R2
G1 R2 Z0

;M204 T5000