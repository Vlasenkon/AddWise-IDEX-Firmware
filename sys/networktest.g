; Initialize variable to store the network module state
var module = 0

; Detect what Network mode is selected
if network.interfaces[0].state = "active"   ; If Ethernet is active
  set var.module = 0
  echo "Detected var.module = 0"
elif network.interfaces[1].state = "active" ; If WiFi is active
  set var.module = 1
  echo "Detected var.module = 1"
else                                        ; If none are active, default to Ethernet first and disable WiFi
  echo "var.module was not detected"
  set var.module = 0
  M552 I1 S-1                               ; Disable WiFi
  G4 S1                                     ; Wait
  M552 I0 S0                                ; Disable Ethernet
  G4 S1                                     ; Wait
  M552 I0 S1                                ; Set WiFi to Idle

echo "var.module was set to "^{var.module}


; Test 1 the selected network mode initially
echo "Test 1 with var.module = "^{var.module}
while network.interfaces[{var.module}].actualIP = "0.0.0.0" && iterations < 20
  G4 S1                                     ; Wait

echo "If 1 with var.module = "^{var.module}
if network.interfaces[{var.module}].actualIP != "0.0.0.0"
  echo "T1 Passed with var.module = "^{var.module}
  M99                                       ; Exit the script
  abort                                     ; Abort if the network connection is successful
echo "If 1 Failed with var.module = "^{var.module}

; Reverse var.module to test the other network mode
if var.module = 1
  set var.module = 0
  M552 I1 S-1
  G1 S0.5
  M552 I0 S1
if var.module = 0
  set var.module = 1
  M552 I0 S0
  G1 S0.5
  M552 I1 S1
echo "var.module was reversed to "^{var.module}

; Test 2 the other network mode
echo "Test 2 with var.module = "^{var.module}
while network.interfaces[{var.module}].actualIP = "0.0.0.0" && iterations < 20
  G4 S1                                     ; Wait

echo "If 2 with var.module = "^{var.module}
if network.interfaces[{var.module}].actualIP != "0.0.0.0"
  echo "T2 Passed with var.module = "^{var.module}
  M98 P"0:/sys/led/pause.g"                 ; Turn on yellow LEDs to indicate mode switch
  M99                                       ; Exit the script
  abort                                     ; Abort if the network connection is successful
echo "If 2 Failed with var.module = "^{var.module}

; If no connection was successful, set LED status and configure AP mode
M98 P"0:/sys/led/statusoff.g"               ; Turn off status LEDs
M98 P"0:/sys/led/dimmwhite.g"               ; Set LEDs to dim white
M98 P"0:/sys/led/red.g"                     ; Turn on red LEDs

M552 I0 S0                                  ; Disable Ethernet
G4 S1                                       ; Wait
M552 I1 S-1                                 ; Turn off WiFi
G4 S1                                       ; Wait
M552 I1 S0                                  ; Set WiFi to Idle
G4 S2                                       ; Wait
M589 S"22 IDEX" P"1234567890" I192.168.0.1  ; Configure WiFi Access Point
G4 S1                                       ; Wait
M552 I1 S-1                                 ; Turn off WiFi
G4 S1                                       ; Wait
M552 I1 S2                                  ; Turn on WiFi in Access Point mode

M291 S2 R"Connection was not established" P"WiFi module was automatically switched to Access Point Mode"
; Display message indicating that WiFi has been switched to Access Point mode due to failed connection attempts