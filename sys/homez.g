; homez.g
; called to home the Z axis
;

T0

M558 P9 C"^zprobe.in" H5 F240 T18000
;G31 P500 X19.50 Y-23.00 Z3.16            ; set Z probe trigger value, offset and trigger height
M98 P"essential/autogen/ProbeOffset.g"
;When too Low => Subtract the difference
;When too High => Add the difference

G91                ; relative positioning
G1 H2 Z10 F18000   ; lift Z relative to current position
G90                ; absolute positioning
G1 U999 F18000     ; Move tool out of the way
G1 X-19.50 Y23.00 F18000 ; go to first probe point
G30                ; home Z by probing the bed