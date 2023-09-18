; stop.g
; called when M0 (Stop) is run (e.g. when a print from SD card is cancelled)

; Disable ToolChange Retraction
echo >"essential/autogen/printretract.g" "; ToolChange Retraction Disabled"


M106 P5 S0
M106 P3 S0
M106 P1 S0

M104 T0 S0 R0 ; Extruder heater off
M104 T1 S0 R0 ; Extruder heater off
M104 T2 S0 R0 ; Extruder heater off
M104 T3 S0 R0 ; Extruder heater off

M98 P"essential/autogen/bedfinishbehavior.g"	    ; decide what to do with bed after printing is finished
M98 P"essential/autogen/chamberfinishbehavior.g"	; decide what to do with chamber after printing is finished

; Disable ToolChange Retraction
echo >"essential/autogen/printretract.g" "; ToolChange Retraction Disabled"