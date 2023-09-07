var S0 = tools[0].standby[0]
var S1 = tools[1].standby[0]

var standbydelta = {global.standbydelta}  ;change this valve if you want to enable standby temperatures


;Set Standby temp, if temp > 300C delta increased 150%
var R0 = 0
if var.S0 > 300
  set var.R0 = {var.S0} - {var.standbydelta}*1.5
else
  set var.R0 = {var.S0} - {var.standbydelta}

var R1 = 0
if var.S1 > 300
  set var.R1 = {var.S1}-{var.standbydelta}*1.5
else
  set var.R1 = {var.S1}-{var.standbydelta}


; Preheat
if var.S0 > {var.standbydelta} && var.S1 > {var.standbydelta}
  T3 P0
  M568 P0 S{var.S0} R{var.R0}
  M568 P1 S{var.S1} R{var.R1}
  M568 P2 S{var.S0, var.S1} R{var.R0, var.R1}
  M568 P3 S{var.S0, var.S1} R{var.R0, var.R1}
  if !exists(param.W)
    M116 P3 S20
elif var.S0 > {var.standbydelta}
  T0 P0
  G10 P0 S{var.S0} R{var.R0}
  G10 P1 S{0} R{0}
  if !exists(param.W)
    M116 P0 S20
elif var.S1 > {var.standbydelta}
  T1 P0
  G10 P1 S{var.S1} R{var.R1}
  G10 P0 S{0} R{0}
  if exists(param.W)
    M116 P1 S20
else
  T0 P0
  M568 P0 S{0} R{0}
  M568 P1 S{0} R{0}
  M568 P2 S{0, 0} R{0, 0}
  M568 P3 S{0, 0} R{0, 0}


if !exists(param.W)
  M116 H2 S10
  M98 P"essential/autogen/chamberwait.g"