M98 P"essential/leds/start_cold.g"
M106 P5 S1 ; Turn E-Cooling Fan on





var S0 = tools[0].active[0]
var S1 = tools[1].active[0]
var R0 = tools[0].standby[0]
var R1 = tools[1].standby[0]

; Preheat
if var.S0 > 0 && var.S1 > 0
  T3 P0
  M568 P0 S{var.S0} R{var.S0}
  M568 P1 S{var.S1} R{var.S1}
  M568 P2 S{var.S0, var.S1} R{var.S0, var.S1}
  M568 P3 S{var.S0, var.S1} R{var.S0, var.S1}
  if !exists(param.W)
    M116 P3 S20


elif var.S0 > 0
  T0 P0
  M568 P0 S{var.S0} R{var.S0}
  if !exists(param.W)
    M116 P0 S20


elif var.S1 > 0
  T1 P0
  M568 P1 S{var.S1} R{var.S1}
  if !exists(param.W)
    M116 P1 S20


else
  abort "Print cancelled due to Selected Temperature Error"
  M98 P"essential/leds/fault.g"
  echo >>"0:/sys/eventlog.txt" "Print cancelled due to Selected Temperature Error"
  T0 P0
  M568 P0 S{0} R{0}
  M568 P1 S{0} R{0}
  M568 P2 S{0, 0} R{0, 0}
  M568 P3 S{0, 0} R{0, 0}



if !exists(param.W)
  M116 H2 S10
  M98 P"essential/autogen/chamberwait.g"


M98 P"essential/leds/start_hot.g"


G60 S0 ; Save selectrd tool to slot 0

M98 P"homeall.g" Z1 S1 L1 ; Home the machine
if result !=0
  abort "Print cancelled due to Homing Error"
  M98 P"essential/leds/fault.g"
  echo >>"0:/sys/eventlog.txt" "Print cancelled due to Homing Error"


G29 ; Run Mesh Compensation
if result !=0
  abort "Print cancelled due to Mesh Compensation Error"
  M98 P"essential/leds/fault.g"
  echo >>"0:/sys/eventlog.txt" "Print cancelled due to Mesh Compensation Error"


;Purging and Cleaning the nozzles
G90
G1 Y-70 X{move.axes[0].min} U{move.axes[3].max} F18000


; Purge
T R0        ; Load previously selected tool and purge 50mm of filament
M83
G1 E50 F{60}*{3}     ; extrude filament
G4 S1

; Clean the nozzles
G91
G1 F18000

if state.currentTool == 0
  G1  X30
  G1 X-30
  G1  X30
  G1 X-30
elif state.currentTool == 1
  G1 X-30
  G1  X30
  G1 X-30
  G1  X30
elif state.currentTool == 3
  G1  X30
  G1 X-30
  G1  X30
  G1 X-30
G90



; Distrubit Temperature
if var.S0 > 0 && var.S1 > 0
  M568 P0 S{var.S0} R{var.R0}
  M568 P1 S{var.S1} R{var.R1}
  M568 P2 S{var.S0, var.S1} R{var.R0, var.R1}
  M568 P3 S{var.S0, var.S1} R{var.R0, var.R1}
elif var.S0 > 0
  M568 P0 S{var.S0} R{var.R0}
  M568 P1 S{0} R{0}
  M568 P2 S{0, 0} R{0, 0}
  M568 P3 S{0, 0} R{0, 0}
elif var.S1 > 0
  M568 P0 S{0} R{0}
  M568 P1 S{var.S1} R{var.R1}
  M568 P2 S{0, 0} R{0, 0}
  M568 P3 S{0, 0} R{0, 0}
else
  abort "Print cancelled due to Selected Temperature Error"
  M98 P"essential/leds/fault.g"
  echo >>"0:/sys/eventlog.txt" "Print cancelled due to Selected Temperature Error"
  T0 P0
  M568 P0 S{0} R{0}
  M568 P1 S{0} R{0}
  M568 P2 S{0, 0} R{0, 0}
  M568 P3 S{0, 0} R{0, 0}

M98 P"0:/sys/essential/ToolRetraction.g"  ; Enable ToolChange Retraction

M208 Z-1 S1         ; set axis minima to allow for wider range of Z - Offset