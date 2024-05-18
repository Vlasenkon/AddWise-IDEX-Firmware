if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed || !move.axes[3].homed
  M98 P"homeall.g"

G90
G1 F18000

if move.axes[0].machinePosition != move.axes[0].min
    
    G1 U999
    G1 Y0
    G1 X-999


var brush_min = -87
var brush_max = -59
var x_center = -193



G1 Y{var.brush_max + var.brush_min}/2 ; Go to the center of purging bucket

; Purge fillament
M83                                                            ; Relative extruder moves
;G1 E50 F{60}*{3}     ; extrude filament
G4 S1

G1 Y{var.brush_min + random({var.brush_max - var.brush_min})} ; Go to random poit of the brush


G1 F12000


; 1st cleaning loop (Staright Left to Right moves)
while iterations < 5
  G91
  G1 X25
  G90
  G1 Y{var.brush_max + 10}
  G1 X-999
  G1 Y{var.brush_min + random({var.brush_max - var.brush_min})} ; Go to random poit of the brush
  M400

; 2nd cleaning loop (Ramp Cleaning)

G90
G1 X{move.axes[0].min + 10} Y{var.brush_min}

while move.axes[0].machinePosition < {{var.x_center + 2}} && iterations < 100
  G91
  G1 X0.5
  G90
  G1 Y{var.brush_max}
  G1 Y{var.brush_min}
  M400

while move.axes[0].machinePosition > {{var.x_center - 2}} && iterations < 100
  G91
  G1 X-0.5
  G90
  G1 Y{var.brush_max}
  G1 Y{var.brush_min}
  M400
G90

G1 X-999 Y{var.brush_max + var.brush_min}/2 ; Go to the center of purging bucket

if exists(param.E)
  T{param.E}