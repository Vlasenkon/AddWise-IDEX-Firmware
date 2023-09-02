; Configuration file for AddWise IDEX

; General preferences
G90                                                ; send absolute coordinates...
M83                                                ; ...but relative extruder moves
M550 P"22IDEX"                                     ; set printer name

; Network
M98 P"essential/autogen/wifimode.g"                ; setup network
M586 P0 S1                                         ; enable HTTP
M586 P1 S0                                         ; disable FTP
M586 P2 S0                                         ; disable Telnet

; Drives
M569 P0 S1                                         ; physical drive 0 goes backwards
M569 P1 S0                                         
M569 P2 S0                                          
M569 P3 S1                                          
M569 P4 S1                                          
M569 P5 S0                                          
M569 P6 S0                                          
M569 P7 S0                                          
M569 P8 S1                                          
M569 P9 S0                                          

M584 X1 Y0:9 U8 Z5:6:7 E3:4                        ; set drive mapping
M669 K0 Y1:1:0:1                                   ; set kinematics type and kinematics parameters
M671 X-224:224:0 Y-168.12:-168.12:195.74 S100      ; leadscrews at left, right and middle

M350 X16 Y16 U16 Z64 E16:16 I1                     ; configure microstepping with interpolation
M92 X80.4 Y80.4 U80.4 Z1600 E400:400               ; set steps per mm
M566 X600 U600 Y600 Z244 E300:300                  ; set maximum jerk (mm/min)
M203 X30000 U30000 Y30000 Z1800 E10000:10000       ; set maximum speeds (mm/min)
M201 X2500 U2500 Y2500 Z1000 E5000:5000            ; set accelerations (mm/s^2)
M906 X1800 U1800 Y1800:1800 Z1000 E600:600 I20     ; set motor currents (mA) and motor idle factor in per cent
M84 S5                                             ; set idle timeout
M204 P5000 T5000

; Axis Limits
M208 X-205 U-155   Y-175 Z0   S1                   ; set axis minima
M208 U205  X155  Y175  Z450 S0                     ; set axis maxima

; Endstops
M574 X1 S1 P"E0stop"                               ; configure active-low endstop for low end on X
M574 U2 S1 P"E1stop"                               ; configure active-low endstop for high end on U
M574 Y2 S3                                         ; configure motor load detection for Y motors
M98 P"essential/autogen/filamentsensor0.g"         ; configure active-high filament sensor for T0
M98 P"essential/autogen/filamentsensor1.g"         ; configure active-high filament sensor for T1

; Probe
M950 S0 C"duex.pwm5"                               ; define servo pin 5 for Z-Probe holder actuation
M558 K0 P5 C"duex.e6stop" H5 F18000 T30000
M98 P"essential/autogen/ProbeOffset.g"
M950 P4 C"duex.fan3" Q500                          ; define output for safety relay
M42  P4 S0

; Heaters
M308 S0 A"Left Heater" P"e0temp" Y"pt1000"         ; configure sensor 0 as pt1000 on pin e0temp
M950 H0 C"e0heat" T0                               ; create nozzle heater output on e0heat and map it to sensor 0
M98 P"essential/autogen/PIDLeftHead.g"             ; disable bang-bang mode for heater and set PID parameters
M143 H0 S510                                       ; set temperature limit for heater 0
M570 H0 P10 T20 R5

M308 S1 A"Right Heater" P"e1temp" Y"pt1000"        ; configure sensor 1 as pt1000 on pin e1temp
M950 H1 C"e1heat" T1                               ; create nozzle heater output on duex.e4heat and map it to sensor 2
M98 P"essential/autogen/PIDRightHead.g"            ; disable bang-bang mode for heater and set PID parameters
M143 H1 S510                                       ; set temperature limit for heater 1
M570 H1 P10 T20 R5

M308 S2 A"Bed Heater" P"duex.e4temp" Y"thermistor" T100000 B3800            ; configure sensor 0 as thermistor on pin bedtemp
M950 H2 C"duex.fan5" Q10 T2                        ; create bed heater output on bedheat and map it to sensor 0
M98 P"essential/autogen/PIDBedHead.g"              ; Disable bang-bang mode for the bed heater and set PWM limit
M140 H2                                            ; map heated bed to heater 2
M143 H2 S210                                       ; set temperature limit
M570 H2 P10 T5 R3

M308 S3 A"Chamber Air" P"duex.e2temp" Y"thermistor" T200000 B3333          ; configure sensor 0 as thermistor on pin bedtemp
M950 H3 C"duex.fan4" Q10 T3                        ; create chamber heater output on bedheat and map it to sensor 0
M307 H3 R0.1 K0.895 D55 S1.00 B1                   ; Chamber Heater
M141 H3                                            ; map chamber to heater 3
M143 H3 S110                                       ; set temperature limit for heater 0 to 100C
M98 P"essential/autogen/faultdetection.g"          ; setup chamber heater fault detection

M308 S4 A"Chamber Heater" P"duex.e3temp" Y"thermistor" T100000 B3950
M143 H3 T4 S170 A2


; Fans
M950 F0 C"duex.fan6" Q500                          ; create fan 0 on pin fan3 and set its frequency
M106 P0 H1 T70 S1                                  ; set fan 0 value. Thermostatic control is turned on
M950 F1 C"duex.fan7" Q500                          ; create fan 1 on pin fan1 and set its frequency
M106 P1 C"U - Fan" H-1 S0                          ; set fan 1 value. Thermostatic control is turned off

M950 F2 C"fan1" Q500                               ; create fan 2 on pin duex.fan2 and set its frequency
M106 P2 H0 T70 S1                                  ; set fan 2 value. Thermostatic control is turned on
M950 F3 C"fan2" Q500                               ; create fan 3 on pin duex.fan1 and set its frequency
M106 P3 C"X - Fan" H-1 S0                          ; set fan 3 value. Thermostatic control is turned off

M950 F4 C"fan0" Q5000                              ; Chamber Heater fan
M106 P4 H4 T70 S1

M950 F5 C"duex.fan8" Q500                          ; create fan 5 on pin duex.fan8
M106 P5 C"E Cooling" H-1 S0

M950 F7 C"bedheat" Q500                            ; Chamber air recirculation fan
M106 P7 H4 T70 S1

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
M563 P0 S"Left Head" D0 H0 F3                      ; define tool 0
G10 P0 X0 Y0 Z0                                    ; set tool 0 axis offsets
G10 P0 R0 S0                                       ; set initial tool 0 active and standby temperatures to 0C
M563 P1 S"Right Head" D1 H1 F1 X3                  ; define tool 1
M98 P"essential/autogen/tooloffset.g"              ; Load tool offsets
G10 P1 R0 S0                                       ; set initial tool 1 active and standby temperatures to 0C

M563 P2 S"Duplicate Mode" D0:1 H0:1 X0:3 F1:3      ; tool 2 uses both extruders and hot end heaters, maps X to both X and U, and uses both print cooling fans
G10 P2 X97.5 Y0 U-97.5 S0 R0                       ; set tool offsets and temperatures for tool 2
M567 P2 E1:1                                       ; set mix ratio 100% on both extruders

M563 P3 S"Mirroring Mode" D0:1 H0:1 X0:3 F1:3      ; tool 2 uses both extruders and hot end heaters, maps X to both X and U, and uses both print cooling fans
G10 P3 X0 Y0 U0 S0 R0                              ; set tool offsets and temperatures for tool 3
M567 P3 E1:1                                       ; set mix ratio 100% on both extruders

; Custom settings
M80 C"pson"

; Miscellaneous
M575 P1 S1 B57600                                  ; Define PanelDUE
;M929 P"eventlog.txt" S1                           ; logging to file eventlog.txt
;M915 X Y U S15 R3                                 ; Enable stall detection
;M911 S18 R23.5 P"M913 X0 Y0 G91 M83 G1 Z3"        ; set voltage thresholds and actions to run on power loss
T1 P0
T0 P0

; Wait for voltage to stabilize and enable Z motors
while boards[0].vIn.current < 22 && iterations < 20
  G4 P250

M17 Z

; Load persistent variables
M98 P"essential/autogen/uoffset.g"
M98 P"essential/autogen/yoffset.g"
M98 P"essential/autogen/zoffset.g"
M98 P"essential/autogen/pickupposition.g"
M98 P"essential/autogen/pickupangle.g"
M98 P"0:/macros/System/Calibration/Z Probe/Rotate holder to 0 degree"

if boards[0].shortName = "2Ethernet"
  ;Ethernet
else
  echo >"0:/sys/runonce.g" "M98 P""0:/sys/essential/testwifi.g"""


M98 P"essential/leds/startup.g"


; Disable ToolChange Retraction
echo >"essential/autogen/printretract.g" "; ToolChange Retraction Disabled"