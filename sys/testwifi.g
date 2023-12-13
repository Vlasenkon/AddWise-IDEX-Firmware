while network.interfaces[0].actualIP = "0.0.0.0" && iterations < 30
  G4 S0.5

if network.interfaces[0].actualIP == "0.0.0.0"
  M98 P"0:/sys/led/statusoff.g"
  M98 P"0:/sys/led/dimmwhite.g"
  M98 P"0:/sys/led/red.g"

  var ip = network.interfaces[0].actualIP
  echo >"0:IP_address.txt" "Error - Connection was not estabblished "^{var.ip}

else
  M98 P"0:/sys/led/statusoff.g"
  M98 P"0:/sys/led/dimmwhite.g"
  M98 P"0:/sys/led/end.g"
  
  var ip = network.interfaces[0].actualIP
  echo >"0:IP_address.txt" "Your IP is: "^{var.ip}