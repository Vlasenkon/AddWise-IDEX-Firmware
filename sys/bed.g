; Take Z referrence point (home Z)
if !exists(param.Z)
  M98 P"homez.g" L1 S1 C1
else
  M98 P"homez.g" L1 S1 Z1 C1

M98 R P"essential/attachedcheck.g" ; make sure probe is conected, pick if negative and leave relay active

; Fast Bed Leveling
M558 K0 P5 C"duex.e6stop" H50 F18000 T18000
M98 P"essential/autogen/ProbeOffset.g"
G1 U999 F18000 ; Move U - carriage off the way
G30 P0 X-36.3 Y-34.3 Z-99999         ; probe near an adjusting screw
G30 P1 X0     Y50    Z-99999   ; probe near an adjusting screw
G30 P2 X36.3 Y-34.3 Z-99999 S3 ; probe near an adjusting screw and report adjustments needed

M561 ; clear any bed transform
G29 S2 ; Clear height map

M558 K0 P5 C"duex.e6stop" H5 F300 T18000
M98 P"essential/autogen/ProbeOffset.g"
G30 P0 X147.5  Y-147.5 Z-99999 ; probe near an adjusting screw
G30 P1 X-147.5 Y-147.5 Z-99999 ; probe near an adjusting screw
G30 P2 X0      Y147.5  Z-99999 S3 ; probe near an adjusting screw and make adjustments needed


if exists(param.L) && exists(param.S) && exists(param.Z)
  M98 P"homez.g" L1 S1 Z1 F1
elif exists(param.L) && exists(param.S)
  M98 P"homez.g" L1 S1 F1
elif exists(param.S) && exists(param.Z)
  M98 P"homez.g" S1 Z1 F1
elif exists(param.L) && exists(param.Z)
  M98 P"homez.g" L1 Z1 F1
elif exists(param.L)
  M98 P"homez.g" L1 F1
elif exists(param.S)
  M98 P"homez.g" S1 F1
elif exists(param.Z)
  M98 P"homez.g" Z1 F1
else
  M98 P"homez.g" F1

if !exists(param.S)
  G1 X-999 U999 Y150 Z100 F18000