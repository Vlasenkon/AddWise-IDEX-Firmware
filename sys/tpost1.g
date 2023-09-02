; tpost1.g
; called after tool 1 has been selected

M204 P5000 T5000

M106 R2

G90
G1 Y-70 U999 X-999 F18000

M98 P"essential/autogen/printretract.g" E1

G91
G1 U-30 F18000
G1 U30
G1 U-30
G1 U30
G90