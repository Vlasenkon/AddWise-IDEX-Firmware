T0

M561 ; clear any bed transform
G1 U999 F18000 ; Move U - carriage off the way
G29 S2 ; Clear height map


G30 P0 X137.5 Y130 Z-99999 ; probe near an adjusting screw
G30 P1 X137.5 Y-130 Z-99999 ; probe near an adjusting screw
G30 P2 X-137.5 Y-130 Z-99999 ; probe near an adjusting screw
G30 P3 X-137.5 Y130 Z-99999 S3 ; probe near an adjusting screw and make adjustments needed