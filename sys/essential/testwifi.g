while network.interfaces[0].actualIP = "0.0.0.0" && iterations < 30
  G4 S1

if network.interfaces[0].actualIP = "0.0.0.0"
  M98 P"essential/leds/statusoff.g"
  M98 P"0:/sys/essential/leds/dimmwhite.g"
  M98 P"0:/sys/essential/leds/red.g"
  
  M552 S-1
  G4 S1
  M552 S0
  G4 S1
  M589 S"22 IDEX" P"1234567890" I192.168.0.1
  G4 S1
  M552 S2
  
  M291 S2 R"Connection was not established" P"WiFi module was automatically switched to Access Point Mode"