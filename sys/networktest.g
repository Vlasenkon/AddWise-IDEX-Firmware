echo >"0:/macros/report.txt" "Start"
 
var it = 0
 
while network.interfaces[0].actualIP = "0.0.0.0" && iterations <= 30
  set var.it = var.it + 1
  echo >>"0:/macros/report.txt" "1st Loop Iteration: "^var.it
  G4 S.1
 
echo >>"0:/macros/report.txt" "1st Loop Out"
 

if network.interfaces[0].actualIP != "0.0.0.0"
  echo >>"0:/macros/report.txt" "IF - Network Connected"
  M99
  abort
else
  echo >>"0:/macros/report.txt" "Else - Network not Connected"
 
echo >>"0:/macros/report.txt" " "
echo >>"0:/macros/report.txt" "After IF"
echo >>"0:/macros/report.txt" " "
 
 
M98 P"0:/sys/led/statusoff.g"
M98 P"0:/sys/led/dimmwhite.g"
M98 P"0:/sys/led/red.g"
 
 
 
M552 I0 S0 ; disable Ethernet (no pause after needed)
M552 I1 S-1 ; turn off WiFi
G4 S2 ; pause
 
M552 I1 S0 ; turn on WiFi to idle
G4 S2 ; pause
 
M589 S"Printer" P"1234567890" I192.168.0.1 ; configure AP
G4 S2 ; pause
 
M552 I1 S2 ; turn on WiFi in AP mode
 

M291 S2 R"Connection was not established" P"WiFi module was automatically switched to Access Point Mode"