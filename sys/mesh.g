; home all if any of axis was not homed
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed || !move.axes[3].homed
  G28

G29 S2                                      ; disable MBC
G1 U999 F18000                              ; move U out of the way

M558 P9 C"^zprobe.in" H5 F240 T18000
M98 P"0:/user/ProbeOffset.g"
M557 X-165:150 Y-170:150 P4                      ; define mesh grid

G29 S0                                      ; run MBC
if result !=0
  M98 P"0:/sys/led/fault.g"
  echo >>"0:/sys/eventlog.txt" "Print cancelled due to Mesh Compensation Error"
  abort "Print cancelled due to Mesh Compensation Error"

M376 H40                                    ; enable compensation taper
M98 P"0:/sys/compensatex.g"                 ; run X - rail twist compensation
G29 S1                                      ; enable MBC
M98 P"homez.g" Z1 S1 F1                     ; fine home z to get final reference