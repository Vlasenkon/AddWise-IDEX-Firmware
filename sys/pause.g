; pause.g
; called when a print from SD card is paused

; Disable ToolChange Retraction
echo >"essential/autogen/printretract.g" "; ToolChange Retraction Disabled"

; Save Tool Temperature
echo >"essential/autogen/pausetemp.g" "G10 P0 S"^{tools[0].active[0]}^" R"^{tools[0].standby[0]}^""
echo >>"essential/autogen/pausetemp.g" "G10 P1 S"^{tools[1].active[0]}^" R"^{tools[1].standby[0]}^""
echo >>"essential/autogen/pausetemp.g" "G10 P2 S"^{tools[2].active[0]}^":"^{tools[2].active[1]}^" R"^{tools[2].standby[0]}^":"^{tools[2].standby[1]}^""
echo >>"essential/autogen/pausetemp.g" "G10 P3 S"^{tools[3].active[0]}^":"^{tools[3].active[1]}^" R"^{tools[3].standby[0]}^":"^{tools[3].standby[1]}^""




; Redure Tool Temperature
var tt = 100

; Active Temperature
if tools[0].active[0] > var.tt
  G10 P0 S{tools[0].active[0] - var.tt}

if tools[1].active[0] > var.tt
  G10 P1 S{tools[1].active[0] - var.tt}


if tools[2].active[0] > var.tt || tools[2].active[1] > var.tt
  G10 P2 S{tools[2].active[0] - var.tt,tools[2].active[1] - var.tt}

if tools[3].active[0] > var.tt || tools[3].active[1] > var.tt
  G10 P3 S{tools[3].active[0] - var.tt,tools[3].active[1] - var.tt}


; Standby Temperature
if tools[0].standby[0] > var.tt
  G10 P0 R{tools[0].standby[0] - var.tt}

if tools[1].standby[0] > var.tt
  G10 P1 R{tools[1].standby[0] - var.tt}


if tools[2].standby[0] > var.tt || tools[2].standby[1] > var.tt
  G10 P2 R{tools[2].standby[0] - var.tt,tools[2].standby[1] - var.tt}

if tools[3].standby[0] > var.tt || tools[3].standby[1] > var.tt
  G10 P3 R{tools[3].standby[0] - var.tt,tools[3].standby[1] - var.tt}



M204 P5000 T5000

M83            ; relative extruder moves
G1 E-25 F{60}*{50}  ; retract 10mm of filament
G91            ; relative positioning
G1 Z100 F18000 ; lift Z
G90            ; absolute positioning
G1 Y150 F6000

M106 P5 S0
M106 S0

; If one of the heaters failed light alarm LEDs or normal pause LEDs otherwise
if heat.heaters[0].state == "fault" || heat.heaters[1].state == "fault" || heat.heaters[2].state == "fault" || heat.heaters[3].state == "fault"
  M98 P"essential/leds/fault.g"  
else
  M98 P"essential/leds/pause.g"