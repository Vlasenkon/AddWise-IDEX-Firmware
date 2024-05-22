;echo >"0:/macros/report.txt" "Start"
 
var it = 0
;while network.interfaces[0].actualIP = "0.0.0.0" && iterations <= 30
while network.interfaces[0].actualIP = "0.0.0.0" && network.interfaces[1].actualIP = "0.0.0.0" && iterations < 30
  set var.it = var.it + 1
  ;echo >>"0:/macros/report.txt" "1st Loop Iteration: "^var.it
  G4 S.1
 
;echo >>"0:/macros/report.txt" "1st Loop Out"
 
 
;if network.interfaces[0].actualIP != "0.0.0.0"
if network.interfaces[0].actualIP != "0.0.0.0" || network.interfaces[1].actualIP != "0.0.0.0"
  ;echo >>"0:/macros/report.txt" "IF - Network Connected"
  M99
  abort
else
  ;echo >>"0:/macros/report.txt" "Else - Network not Connected"
 
 
 
M98 P"0:/sys/led/statusoff.g"
M98 P"0:/sys/led/dimmwhite.g"
M98 P"0:/sys/led/red.g"
 
 
;echo >>"0:/macros/report.txt" " "
;echo >>"0:/macros/report.txt" "After LED"
;echo >>"0:/macros/report.txt" " "
 
 
M552 I0 S0 ; disable Ethernet (no pause after needed)
;echo >>"0:/macros/report.txt" "Result: "^result
M552 I1 S-1 ; turn off WiFi
;echo >>"0:/macros/report.txt" "Result: "^result
G4 S2 ; pause
 
M552 I1 S0 ; turn on WiFi to idle
;echo >>"0:/macros/report.txt" "Result: "^result
G4 S2 ; pause
 
M589 S"22 IDEX" P"1234567890" I192.168.0.1 ; configure AP
;echo >>"0:/macros/report.txt" "Result: "^result
G4 S2 ; pause
 
M552 I1 S2 ; turn on WiFi in AP mode
;echo >>"0:/macros/report.txt" "Result: "^result
 
 
M291 S2 R"Connection was not established" P"WiFi module was automatically switched to Access Point Mode"