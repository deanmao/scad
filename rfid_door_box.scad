length = 64 + 26 + 35;
width = 38 + 40 + 10 + 7;
height = 38;
box = [length, width, height];
solenoid = [length - 4, 40, height];
opening = [40, 4, height];
pcb = [length - 4, 45, height];
tabHoleRadius = 3;
tab = [20, tabHoleRadius * 6, 6];

module hole() {
  rotate( v = [1,0,0], a = 90 ) {
    cylinder(40, r = 1.8, $fn=50 );
  }
}

module screwMount() {
  translate(v=[-1, -1, -10]) {
    difference() {
      rotate( v = [1,0,0], a = 180 ) {
    	  cylinder(h = 20, r1 = 10, r2 = 0, center = true, $fn = 50);
    	}
    	translate(v=[-10, -10, -10]) {
      	cube(size=[20, 10, 25]);
      	cube(size=[10, 20, 25]);
    	}
    	translate(v=[3, 3, 3]) {
    	  cylinder(h = 10, r = 1.5, $fn = 50);
    	}
  	}
  }
}

module pcbMount() {
  difference() {
    cylinder(h=5, r=2.5, $fn=50);
    cylinder(h=6, r=1.7, $fn=50);
  }
}

union() {
  // pcb mounts
  translate(v=[30,width - pcb[1] + 17,1]) {
    pcbMount();
    translate(v=[56, -15, 0]) {
      pcbMount();
      translate(v=[0, 30 + 7, 0]) {
        pcbMount();
      }
    }
    translate(v=[77 + 5, 0, 0]) {
      pcbMount();
    }
  }

  // cover screw mounts
  translate(v=[2, 2, height]) {
  	screwMount();
  }
  translate(v=[length-2, 2, height]) {
    rotate( v = [0,0,1], a = 90 ) {
  	  screwMount();
  	}
  }
  translate(v=[length-2, width-2, height]) {
    rotate( v = [0,0,1], a = 180 ) {
  	  screwMount();
  	}
  }
  translate(v=[2, width-2, height]) {
    rotate( v = [0,0,1], a = 270 ) {
  	  screwMount();
  	}
  }
  
  
  difference() {
    cube(size = box);
    union() {
      translate(v=[2, 2, 2]) {
        cube(size = solenoid);
      }
      // hole for string
      for(i = [35 : 40]) {
        translate(v=[length - i, 5, height/2]) {
          rotate( v = [1,0,0], a = 90 ) {
            cylinder(30, r = 10, $fn=50 );
          }
        }
      }
      translate(v=[2, width - pcb[1] - 2, 2]) {
        cube(size = pcb);
      }
      
      translate( v = [-10, width - pcb[1] + 5, 0] ) {
        // top hole for 2 buttons
        translate( v = [0, 0, 25] ) {
          rotate( v = [0,1,0], a = 90 ) {
            cylinder(30, r = 3.7, $fn=50 );
          }
        }
        translate( v = [0, 0, 10] ) {
          rotate( v = [0,1,0], a = 90 ) {
            cylinder(30, r = 3.7, $fn=50 );
          }
        }
        
        // top hole for led
        translate( v = [0, 20, 25] ) {
          rotate( v = [0,1,0], a = 90 ) {
            cylinder(30, r = 4.3, $fn=50 );
          }
        }
      }

      // bottom hole for power
      translate( v = [15, width + 10, 10] ) {
        rotate( v = [1,0,0], a = 90 ) {
          cylinder(30, r = 4.5, $fn=50 );
        }
      }

      // middle hole for solenoid
      translate( v = [length-25, width - pcb[1], 30] ) {
        rotate( v = [1,0,0], a = 90 ) {
          cylinder(30, r = 4, $fn=50 );
        }
      }

      // bottom hole for rfid
      translate( v = [length-20, width - solenoid[1] + 5, 15] ) {
        rotate( v = [0,1,0], a = 90 ) {
          cylinder(30, r = 7, $fn=50 );
        }
      }


      // solenoid mounting holes
      translate( v=[41, solenoid[1] + 30, 11] ) {
        hole();
        translate( v=[0, 0, 20]) {
          hole();
        }
        translate( v=[30, 0, 0]) {
          hole();
          translate( v=[0, 0, 20]) {
            hole();
          }
        }
      }
    }
  }
  
  
  // mounting tabs
  translate(v=[-tab[0] + 2, solenoid[1] - 10, 0]) {
    difference() {
      cube(size = tab);
      translate( v=[tab[0] / 2 - tabHoleRadius, tab[1] / 2, 0] ) {
        cylinder(20, r = tabHoleRadius, $fn=50 );
      }
    }
  }
  translate(v=[length - 2, solenoid[1] - 10, 0]) {
    difference() {
      cube(size = tab);
      translate( v=[tab[0] / 2 + tabHoleRadius, tab[1] / 2, 0] ) {
        cylinder(20, r = tabHoleRadius, $fn=50 );
      }
    }
  }
}
