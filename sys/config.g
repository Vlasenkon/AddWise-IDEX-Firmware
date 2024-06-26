; Configuration file for AddWise IDEX

; General preferences
G90                                                ; absolute coordinates
M83                                                ; relative extruder moves
M550 P"22IDEX"                                     ; set printer name

; Network
if boards[0].shortName = "2Ethernet"
  echo >"0:/sys/runonce.g" "M98 P""0:/user/ethernet.g"""
else
  M98 P"0:/user/wifimode.g" 
  
M586 P0 S1                                         ; HTTP or HTTPS
M586 P1 S0                                         ; FTP or SFTP
M586 P2 S0                                         ; Telnet or SSH
;M586 P3 S0                                        ; Multicast discovery
;M586 P4 S0                                        ; MQTT


; Drives
M569 P0 S1                                         ; motor direction
M569 P1 S0                                         
M569 P2 S0                                          
M569 P3 S1                                          
M569 P4 S1                                          
M569 P5 S0                                          
M569 P6 S0                                          
M569 P7 S0                                          
M569 P8 S1                                          
M569 P9 S0                                          

M584 X1 Y0:9 U8 Z5:6:7 E3:4                        ; set motor mapping
M669 K0 Y1:1:0:1                                   ; set kinematics parameters
M671 X-222.5:222.5:0 Y-170.5:-170.5:193.5 S100     ; leadscrews at left, right and rear

M350 X16 Y16 U16 Z16 E16:16 I1                     ; configure microstepping
M92 X80 Y80 U80 Z400 E400:400                      ; set steps per mm
M566 X600 U600 Y600 Z244 E600:600                  ; set maximum jerk (mm/min)
M203 X18000 U18000 Y18000 Z1800 E10000:10000       ; set maximum speeds (mm/min)
M201 X10000 U10000 Y10000 Z1000 E5000:5000         ; set accelerations (mm/s^2)
M906 X1800 U1800 Y1800:1800 Z1000 E600:600 I50     ; set motor currents (mA) and motor idle factor in per cent
M84 S10                                            ; set idle timeout
M204 P5000 T5000

; Axis Limits
M208 X-205 U-155   Y-175 Z0   S1                   ; set axis minima
M208 U205  X155  Y175  Z450 S0                     ; set axis maxima

; Endstops
M574 X1 S1 P"E0stop"                               ; configure endstop
M574 U2 S1 P"E1stop"                               ; configure endstop
M574 Y2 S3                                         ; configure endstop
M98 P"0:/user/filamentsensor0.g"                   ; configure endstop
M98 P"0:/user/filamentsensor1.g"                   ; configure endstop

; Probe
M950 S0 C"duex.pwm5"                               ; define servo pin
M558 K0 P5 C"duex.e6stop" H5 F18000 T18000         ; define Z probe parameters
M98 P"0:/user/ProbeOffset.g"                       ; define Z probe offsets
M950 P4 C"duex.fan3" Q500                          ; define output for ESD protection
M42  P4 S0                                         ; enable EDS protection

; Heaters
M308 S0 A"Left Heater" P"e0temp" Y"pt1000"         ; configure temperature sensor
M950 H0 C"e0heat" T0                               ; configure heater
M98 P"0:/user/PIDLeftHead.g"                       ; configure PID parameters
M143 H0 S510                                       ; configure temperature limit for the heater
M570 H0 P30 T50 R10                                ; configure heater fault detection

M308 S1 A"Right Heater" P"e1temp" Y"pt1000"        ; configure temperature sensor
M950 H1 C"e1heat" T1                               ; configure heater
M98 P"0:/user/PIDRightHead.g"                      ; configure PID parameters
M143 H1 S510                                       ; configure temperature limit for the heater
M570 H1 P30 T50 R10                                ; configure heater fault detection

M308 S2 A"Bed Heater" P"duex.e4temp" Y"thermistor" T100000 B3900 ; configure temperature sensor
M950 H2 C"duex.fan5" Q10 T2                        ; configure heater
M98 P"0:/user/PIDBedHead.g"                        ; configure PID parameters
M140 H2                                            ; map heated bed to heater
M143 H2 S210                                       ; configure temperature limit for the heater
M570 H2 P10 T5 R3                                  ; configure heater fault detection

M308 S3 A"Chamber Air" P"duex.e2temp" Y"thermistor" T200000 B3450 ; configure temperature sensor
M950 H3 C"duex.fan4" Q10 T3                        ; configure heater
M307 H3 R0.1 K0.895 D55 S1.00 B1                   ; configure PID parameters
M141 H3                                            ; map chamber to heater
M143 H3 S110                                       ; configure temperature limit for the heater
M98 P"0:/user/faultdetection.g"                    ; configure heater fault detection

M308 S4 A"Chamber Heater" P"duex.e3temp" Y"thermistor" T100000 B3950  ; configure temperature sensor
M143 H3 T4 S170 A2                                                    ; configure temperature limit for the heater


; Fans
M950 F0 C"duex.fan6" Q500                          ; configure fan
M106 P0 H1 T70 S1                                  ; configure thermostatic contron
M950 F1 C"duex.fan7" Q500                          ; configure fan
M106 P1 C"U - Fan" H-1 S0                          ; configure contron

M950 F2 C"fan1" Q500                               ; configure fan
M106 P2 H0 T70 S1                                  ; configure thermostatic contron
M950 F3 C"fan2" Q500                               ; configure fan
M106 P3 C"X - Fan" H-1 S0                          ; configure thermostatic contron

M950 F4 C"fan0" Q5000                              ; configure fan
M106 P4 H4 T70 S1                                  ; configure thermostatic contron

M950 F5 C"duex.fan8" Q500                          ; configure fan
M106 P5 C"E Cooling" H-1 S0                        ; configure thermostatic contron

M950 F7 C"bedheat" Q500                            ; configure fan
M106 P7 H4 T50 S1                                  ; configure thermostatic contron

; LEDs
M950 P1 C"duex.e5heat" Q5000                       ; Red LEDs
M42 P1 S0
M950 P2 C"duex.e4heat" Q5000                       ; Green LEDs
M42 P2 S0
M950 P3 C"duex.e3heat" Q5000                       ; Blue LEDs
M42 P3 S0
M950 F6 C"duex.e2heat" Q5000                       ; White LEDs
M106 P6 C"W LED" H-1 B0 S0


; Tools
M563 P0 S"Left Head" D0 H0 F3                      ; define tool
G10 P0 X0 Y0 Z0 U0                                 ; set tool offsets
G10 P0 R0 S0                                       ; set initial tool active and standby temperatures

M563 P1 S"Right Head" D1 H1 F1 X3                  ; define tool
M98 P"0:/user/tooloffset.g"                        ; Load tool offsets
G10 P1 R0 S0                                       ; set initial tool active and standby temperatures

M563 P2 S"Duplicate Mode" D0:1 H0:1 X0:3 F1:3      ; tool 2 uses both extruders and hot end heaters, maps X to both X and U, and uses both print cooling fans
G10 P2 X97.5 Y0 U-97.5 S0 R0                       ; set tool offsets and temperatures for tool 2
M567 P2 E1:1                                       ; set mix ratio 100% on both extruders

M563 P3 S"Mirroring Mode" D0:1 H0:1 X0:3 F1:3      ; tool 3 uses both extruders and hot end heaters, maps X to both X and U, and uses both print cooling fans
G10 P3 X0 Y0 U0 S0 R0                              ; set tool offsets and temperatures for tool 3
M567 P3 E1:1                                       ; set mix ratio 100% on both extruders


; Load persistent variables
M98 P"0:/user/uoffset.g"                           ; load global variables
M98 P"0:/user/yoffset.g"                           ; load global variables
M98 P"0:/user/zoffset.g"                           ; load global variables
M98 P"0:/user/pickupposition.g"                    ; load global variables
M98 P"0:/user/pickupangle.g"                       ; load global variables
M98 P"0:/user/eventlogging.g"                      ; load global variables
M98 P"0:/user/xcomp.g"                             ; load global variables

echo >"0:/user/toolchangeretraction.g" "; ToolChange Retraction Disabled"
echo >"0:/user/resetzbabystep.g" "; do nothing"

; Custom settings
M280 P0 S0                                         ; rotate servo to 0 deg
T1 P0                                              ; select tool 0
T0 P0                                              ; select tool 0
M575 P1 S1 B57600                                  ; define PanelDUE
M80 C"pson"                                        ; define PS_ON pin


; Wait for voltage to stabilize and hold Z motors
while boards[0].vIn.current < 22 && iterations < 20
  G4 P250

M17 Z            ; Hold Z motors with idle current

; test internet connection
if boards[0].shortName = "2WiFi"
  echo >"0:/sys/runonce.g" "M98 P""0:/sys/testwifi.g"""

M98 P"0:/sys/led/startup.g"                        ; startup LED