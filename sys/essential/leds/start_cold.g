if global.enableStatusLEDs
  M98 P"essential/leds/statusoff.g"
  M98 P"essential/leds/dimmwhite.g"
  
  ; Slowly blink blue LEDs 
  var i = 0.0
  while var.i <= 1
    M42 P3 S{var.i}
    M42 P2 S{var.i / 1.7}
    G4 10
    set var.i = var.i + 0.01