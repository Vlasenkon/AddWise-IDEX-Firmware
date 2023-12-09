var mm = {global.xcomp}*{1}   ; create variable
M584 Z1.0:1.2                     ; define driver mapping

G91                           ; set to relative positioning
G1 F240 Z{var.mm}             ; move to compensate
G90                           ; set to relative positioning

M584 Z1.0:1.1:1.2