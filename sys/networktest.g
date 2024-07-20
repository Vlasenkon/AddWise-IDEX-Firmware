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
  set var.module = 0
  echo "var.module was not detected"
  M552 I1 S-1                               ; Disable WiFi
  G4 S1                                     ; Wait
  M552 I0 S0                                ; Disable Ethernet
  G4 S1                                     ; Wait
  M552 I0 S1                                ; Set WiFi to Idle



; Test 1 the selected network mode initially
echo "Test 1 with var.module = "^{var.module}
while network.interfaces[{var.module}].actualIP = "0.0.0.0" && iterations < 20
  G4 S1                                     ; Wait

echo "IF 1 with var.module = "^{var.module}
if network.interfaces[{var.module}].actualIP != "0.0.0.0"
  ;echo >"0:/IP_address.txt" "Last Connected IP is: "^{network.interfaces[{var.module}].actualIP}"
  M99                                       ; Exit the script
  abort                                     ; Abort if the network connection is successful
echo "After IF 1 with var.module = "^{var.module}

; Reverse var.module to test the other network mode
if var.module = 1
  set var.module = 0
  M552 I1 S-1
  G1 S1
  M552 I0 S1
if var.module = 0
  set var.module = 1
  M552 I0 S0
  G1 S1
  M552 I1 S1
echo "var.module was reversed to "^{var.module}


; Test 2 the other network mode
echo "Test 2 with var.module = "^{var.module}
while network.interfaces[{var.module}].actualIP = "0.0.0.0" && iterations < 20
  G4 S1                                     ; Wait

echo "IF 2 with var.module = "^{var.module}
if network.interfaces[{var.module}].actualIP != "0.0.0.0"
  M98 P"0:/sys/led/pause.g"                 ; Turn on yellow LEDs to indicate mode switch
  ;echo >"0:/IP_address.txt" "Last Connected IP is: "^{network.interfaces[{var.module}].actualIP}"
  M99                                       ; Exit the script
  abort                                     ; Abort if the network connection is successful
echo "After IF 2 with var.module = "^{var.module}

; If no connection was successful, set LED status and configure AP mode
M98 P"0:/sys/led/statusoff.g"               ; Turn off status LEDs
M98 P"0:/sys/led/dimmwhite.g"               ; Set LEDs to dim white
M98 P"0:/sys/led/red.g"                     ; Turn on red LEDs

M552 I0 S0                                  ; Disable Ethernet
if result != 0
  echo "Failed 1"
else
  echo "OK 1"
G4 S1                                       ; Wait

M552 I1 S-1                                 ; Turn off WiFi
if result != 0
  echo "Failed 2"
else
  echo "OK 2"
G4 S1                                       ; Wait

M552 I1 S0                                  ; Set WiFi to Idle
if result != 0
  echo "Failed 3"
else
  echo "OK 3"
G4 S5                                       ; Wait


M589 S"22 IDEX" P"1234567890" I192.168.0.1  ; Configure WiFi Access Point
if result != 0
  echo "Failed 4"
else
  echo "OK 4"
G4 S5                                       ; Wait


M552 I1 S-1                                 ; Turn off WiFi
if result != 0
  echo "Failed 5"
else
  echo "OK 5"
G4 S1                                       ; Wait


M552 I1 S2                                  ; Turn on WiFi in Access Point mode
if result != 0
  echo "Failed 6"
else
  echo "OK 6"
G4 S5                                       ; Wait

;if network.interfaces[1].actualIP != "0.0.0.0"
;  echo >"0:/IP_address.txt" "WiFI was switched to AP Mode, the IP is: "^{network.interfaces[{var.module}].actualIP}"


;M291 S2 R"Connection was not established" P"WiFi module was automatically switched to Access Point Mode"
; Display message indicating that WiFi has been switched to Access Point mode due to failed connection attempts