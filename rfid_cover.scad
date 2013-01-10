length = 64 + 26 + 35;
width = 38 + 40 + 10 + 7;
height = 38;
box = [length, width, height];
solenoid = [length - 4, 40, height];
opening = [40, 4, height];
pcb = [length - 4, 45, height];
tabHoleRadius = 3;
tab = [20, tabHoleRadius * 6, 6];

module screwMount() {
  translate(v=[-1, -1, -10]) {
  	translate(v=[3, 3, 3]) {
  	  cylinder(h = 10, r = 1.8, $fn = 50);
  	}
  }
}

difference() {
  union() {
    translate(v=[0, 0, height - 4]) {
      cube(size=[length, width, 4]);
    }
  }
  union() {
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
  }
}
