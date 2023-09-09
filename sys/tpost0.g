; tpost0.g
; called after tool 0 has been selected

M204 P5000 T5000

; Lower Z to 10mm if lower than that for safety
if move.axes[2].machinePosition < 10 && state.status != "processing"  && state.status != "pausing" && state.status != "resuming"
	G90
	G1 F18000 Z10

G90
G1 Y-70 U999 X-999 F18000

M98 P"essential/autogen/printretract.g" E1

G91
G1 X30
G1 X-30
G1 X30
G1 X-30
G90
G4 S1

M106 S0
M106 R2