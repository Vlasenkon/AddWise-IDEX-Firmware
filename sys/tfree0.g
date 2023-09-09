G90

M204 P5000 T5000

M98 P"essential/autogen/printretract.g" R1

G60 S2
M106 S0

; Lower Z to 10mm if lower than that for safety
if move.axes[2].machinePosition < 10 && state.status != "processing"  && state.status != "pausing" && state.status != "resuming"
	G90
	G1 F18000 Z10

G90
G1 X{move.axes[0].min} U{move.axes[3].max} F18000