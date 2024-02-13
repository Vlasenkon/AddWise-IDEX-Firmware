if global.enableStatusLEDs
  ;if exists(global.whiteled)
  ;  var i = 0.0
  ;  while var.i <= global.whiteled
  ;    M106 P6 S{var.i} B0
  ;    G4 P8
  ;    set var.i = var.i + 0.01
  ;else
    var i = 0.0
    while var.i <= 1
      M106 P6 S{var.i} B0
      G4 P8
      set var.i = var.i + 0.01
  
