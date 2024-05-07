T0               ; Select first tool

G90              ; Absolute positioning

; Go to probe pickup position
G1 f18000 Y135 X{global.probePickX} U999
M400

M204 P1000 T1000 ; Lower the accelerations a little

M280 P0 S{global.probePickAngle}     ; Move probe holder to the 'pick/place' position
G4 S1
G1 f18000 Y999   ; Pick the probe
G91
G1 f18000 Y-50   ; Return with probe
M280 P0 S0       ; Take probe holder out of the way
M42 P4 S1		 ; Turn on relay, engage probing (ESD Warning)
;G4 S1

G90
M204 P5000 T5000 ; Return the accelerations