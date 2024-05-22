var ttt = 0
if exists(param.T)
  set var.ttt = (param.T)
elif state.currentTool == 0 || state.currentTool == 2 || state.currentTool == 3
  set var.ttt = 0
elif state.currentTool == 1
  set var.ttt = 1


var brush_min = -87
var brush_max = -59
var x_center = -193
var u_center = 193 ;var.x_center * {-1}
var xu_offset = {3}
var xu_step = 1
var num_wipes = 7




if move.axes[0].machinePosition > {move.axes[3].min + 5} || move.axes[3].machinePosition < {move.axes[3].max - 5}
    G1 Y{brush_max + 50} X-999 U999 F18000


G1 Y{var.brush_max + var.brush_min}/2 ; Go to the center of purging bucket
M400

; Wait for Temp
if exists(param.W)
  M116 S10

; Purge fillament
if exists(param.E)
  echo {(param.E)}
  M83                                                            ; Relative extruder moves
  G1 E{(param.E)} F{60}*{3}     ; extrude filament
  M400
  G4 S1

G1 F12000
G1 Y{var.brush_min + random({var.brush_max - var.brush_min})} ; Go to random poit of the brush


if var.ttt = 0

  ; 1st cleaning loop (Staright Left to Right moves)
  while iterations < var.num_wipes
    G91
    G1 X25
    M400
    G90
    G1 Y{var.brush_max + 5}
    G1 X-999
    G1 Y{var.brush_min + random({var.brush_max - var.brush_min})} ; Go to random poit of the brush
    M400

  ; 2nd cleaning loop (Ramp Cleaning)
  if exists(param.C)
    G90
    G1 X{var.x_center - var.xu_offset * 2} Y{var.brush_min}
    M400

    while move.axes[0].machinePosition < {var.x_center + var.xu_offset} && iterations < 50
      G91
      G1 X{var.xu_step}
      G90
      G1 Y{var.brush_max}
      G1 Y{var.brush_min}
      M400

    while move.axes[0].machinePosition > {var.x_center - var.xu_offset} && iterations < 50
      G91
      G1 X{-var.xu_step}
      G90
      G1 Y{var.brush_max}
      G1 Y{var.brush_min}
      M400
  G90
  G1 X-999
  G1 Y{var.brush_max + var.brush_min}/2 ; Go to the center of purging bucket



if var.ttt = 1

  ; 1st cleaning loop (Staright Left to Right moves)
  while iterations < var.num_wipes
    G91
    G1 U-25
    M400
    G90
    G1 Y{var.brush_max + 5}
    G1 U999
    G1 Y{var.brush_min + random({var.brush_max - var.brush_min})} ; Go to random poit of the brush
    M400
  
  ; 2nd cleaning loop (Ramp Cleaning)
  if exists(param.C)
    G90
    G1 U{var.u_center + var.xu_offset * 2} Y{var.brush_min}
    M400
  
    while move.axes[3].machinePosition > {var.u_center - var.xu_offset} && iterations < 50
      G91
      G1 U{-var.xu_step}
      G90
      G1 Y{var.brush_max}
      G1 Y{var.brush_min}
      M400
  
    while move.axes[3].machinePosition < {var.u_center + var.xu_offset} && iterations < 50
      G91
      G1 U{var.xu_step}
      G90
      G1 Y{var.brush_max}
      G1 Y{var.brush_min}
      M400
  G90
  G1 U999
  G1 Y{var.brush_max + var.brush_min}/2 ; Go to the center of purging bucket