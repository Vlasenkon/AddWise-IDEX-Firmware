M80
T0                      ; Select first tool
G90
G1 F18000 Y135 X{global.probePickX} U{move.axes[3].max-10} ; Go to position
M400

M280 P0 S{global.probePickAngle}         ; Move probe holder to the 'pick/place' position
M42 P4 S0               ; Turn off relay, detach GND from PE and ground the probe pin (ESD Safe)
G4 S1
G1 F8000 Y999           ; Place the probe

G91
G1 F18000 X-50          ; Shear probe off the tool head
G1 F18000 Y-50
G90

M280 P0 S0              ; Take probe holder out of the way
G1 U999
G4 P250