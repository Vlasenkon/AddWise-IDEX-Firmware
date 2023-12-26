var h0 = tools[0].standby[0]
var h1 = tools[1].standby[0]

; Preheat
if var.h0 != 0 && var.h1 != 0
  T3 P0
  M568 P0 S{var.h0}
  M568 P1 S{var.h1}
  M568 P2 S{var.h0, var.h1} R{var.h0, var.h1}
  M568 P3 S{var.h0, var.h1} R{var.h0, var.h1}
  M116 P3 S20
elif var.h0 != 0
  T0 P0
  G10 P0 S{var.h0} R{var.h0}
  M116 P0 S20
else
  T1 P0
  G10 P1 S{var.h1} R{var.h1}
  M116 P1 S20  


M116 H2 S10