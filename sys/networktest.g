var module = 0

; Detect what Network mode is selected
if network.interfaces[0].state = "active" ; If Ethernet Active
  set var.module = 0
elif  network.interfaces[1].state = "active" ; If WiFi Active
  set var.module = 1
else
  set var.module = 0 ; If None is active - Test Ethernet 1st 
  M552 I1 S-1 ; Disable WiFI
  G4 S1
  M552 I0 S0  ; Disable Ethernet
  G4 S1
  M552 I0 S0  ; WiFI to Idle


; Test 1st Time the network that was selected originaly
while network.interfaces[{var.module}].actualIP = "0.0.0.0" && iterations < 20
  G4 S1

if network.interfaces[{var.module}].actualIP != "0.0.0.0"
  M99
  abort


; Reverse var.module to test another network mode
if var.module = 1
  set var.module = 0
if var.module = 0
  set var.module = 1


; Test 2nd Time the other network
while network.interfaces[{var.module}].actualIP = "0.0.0.0" && iterations < 20
  G4 S1

if network.interfaces[{var.module}].actualIP != "0.0.0.0"
  M98 P"0:/sys/led/pause.g" ; Yellow LED's to show that mode was switched to another one
  M99
  abort



; if no connection was sucsessful
M98 P"0:/sys/led/statusoff.g"
M98 P"0:/sys/led/dimmwhite.g"
M98 P"0:/sys/led/red.g"


M552 I0 S0 ; disable Ethernet
G4 S0.5
M552 I1 S-1 ; turn off WiFi
G4 S1
M552 I1 S0 ; WiFi to Idle
G4 S1
M589 S"22 IDEX" P"1234567890" I192.168.0.1 ; configure AP

M552 I1 S-1 ; turn off WiFi
G4S1
M552 I1 S2 ; turn on WiFi in AP mode

M291 S2 R"Connection was not established" P"WiFi module was automatically switched to Access Point Mode"