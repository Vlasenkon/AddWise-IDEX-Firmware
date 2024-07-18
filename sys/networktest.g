; Initialize variable to store the network module state
var module = 0

; Detect what Network mode is selected
if network.interfaces[0].state = "active"   ; If Ethernet is active
  set var.module = 0
elif network.interfaces[1].state = "active" ; If WiFi is active
  set var.module = 1
else
                                            ; If none are active, default to Ethernet first and disable WiFi
  set var.module = 0
  M552 I1 S-1                               ; Disable WiFi
  G4 S1                                     ; Wait for 1 second
  M552 I0 S0                                ; Disable Ethernet
  G4 S1                                     ; Wait for 1 second
  M552 I1 S0                                ; Set WiFi to Idle

; Test the selected network mode initially
while network.interfaces[{var.module}].actualIP = "0.0.0.0" && iterations < 20
  G4 S1                                     ; Wait for 1 second

if network.interfaces[{var.module}].actualIP != "0.0.0.0"
  M99                                       ; Exit the script
  abort                                     ; Abort if the network connection is successful

; Reverse var.module to test the other network mode
if var.module = 1
  set var.module = 0
if var.module = 0
  set var.module = 1

; Test the other network mode
while network.interfaces[{var.module}].actualIP = "0.0.0.0" && iterations < 20
  G4 S1                                     ; Wait for 1 second

if network.interfaces[{var.module}].actualIP != "0.0.0.0"
  M98 P"0:/sys/led/pause.g"                 ; Turn on yellow LEDs to indicate mode switch
  M99                                       ; Exit the script
  abort                                     ; Abort if the network connection is successful

; If no connection was successful, set LED status and configure AP mode
M98 P"0:/sys/led/statusoff.g"               ; Turn off status LEDs
M98 P"0:/sys/led/dimmwhite.g"               ; Set LEDs to dim white
M98 P"0:/sys/led/red.g"                     ; Turn on red LEDs

M552 I0 S0                                  ; Disable Ethernet
G4 S0.5                                     ; Wait for 0.5 seconds
M552 I1 S-1                                 ; Turn off WiFi
G4 S1                                       ; Wait for 1 second
M552 I1 S0                                  ; Set WiFi to Idle
G4 S1                                       ; Wait for 1 second
M589 S"22 IDEX" P"1234567890" I192.168.0.1  ; Configure WiFi Access Point

M552 I1 S-1                                 ; Turn off WiFi
G4 S1                                       ; Wait for 1 second
M552 I1 S2                                  ; Turn on WiFi in Access Point mode

M291 S2 R"Connection was not established" P"WiFi module was automatically switched to Access Point Mode"
; Display message indicating that WiFi has been switched to Access Point mode due to failed connection attempts