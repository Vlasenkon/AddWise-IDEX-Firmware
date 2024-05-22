; Lower Z to 10mm if lower than that for safety
if move.axes[2].machinePosition < 10 && state.status != "processing"  && state.status != "pausing" && state.status != "resuming"
	G90
	G1 F18000 Z10

G90
G1 Y-70 X-999 U999 F18000

M98 P"0:/user/toolchangeretraction.g" E1
M98 P"0:/sys/nozzlewipe.g" T1

M106 R2