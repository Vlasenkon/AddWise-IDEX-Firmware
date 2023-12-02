G90
G1 H1 Y-190 F3000
G91
G1 Y5 F1200
G1 H1 Y-10 F240
G92 Y-150
G4 P260
var ll = move.axes[1].machinePosition

;=== Home with Right end stop ===
M584 Y0.1
M574 Y1 S1 P"io1.in"
G1 H4 Y-5 F240

;=== Home with Left end stop ===
M584 Y0.4
M574 Y1 S1 P"io2.in"
G1 H4 Y-5 F240

G4 P260
var rr = move.axes[1].machinePosition + {5}

var dd = var.rr - var.ll

;if var.dd > 1.5
  echo "Div "^{var.dd}

G92 Y-999
M584 Y0.1:0.4
M574 Y1 S1 P"io1.in+io2.in"                          ; configure endstop
G90                        ; absolute positioning



M400
G1 Y-100 F18000
M84 Y