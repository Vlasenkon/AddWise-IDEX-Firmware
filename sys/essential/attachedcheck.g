M42 P4 S1
G4 P100              ; Wait for Probe value to stabilize
M400

; If probe unavailable, try to pick it up
if sensors.probes[0].value[0] > 500
  M98 P"pick.g"
  
G4 P100              ; Wait for Probe value to stabilize

; If probe is still unavailable, open safety relay and return
if sensors.probes[0].value[0] > 500
  M42 P4 S0
  M98 P"essential/leds/fault.g"
  M291 S0 R"Probe is not connected" P"Check if Probe is attached to the Printhead"
  abort "Probe is not connected"


if !exists(param.R)
  M42 P4 S0