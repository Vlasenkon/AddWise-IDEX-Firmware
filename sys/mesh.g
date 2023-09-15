if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed || !move.axes[3].homed
  M98 P"homeall.g" L1 S1 Z1

M98 R1 P"essential/attachedcheck.g" ; make sure probe is conected, pick if negative and leave relay active

M204 P5000 T5000

G1 U{move.axes[3].max} F18000 F18000
M558 K0 P5 C"duex.e6stop" H3 F300 T30000  ; Redefine probe with appropriate parameters
M98 P"essential/autogen/ProbeOffset.g"      ; Set probe offsets
M557 X-165:155 Y-146:165 P8:8               ; Define mesh grid
M376 H0                                     ; Disable compensation taper
G29 S0                                      ; Run mesh bed leveling
G1 Z20 F18000
M376 H40                                     ; Enable compensation taper

if !exists(param.L)
  M98 P"place.g"