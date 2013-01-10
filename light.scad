l = 135;
w = 68;
h = 30;

pcb_w = 57;
pcb_l = 65;

rear_light_d = 24;
rear_light_h = 15;

stem_w = 35;
stem_d = 32;

seat_d = 27.1;


//-- Nut parameters
nut_h = 2.5;
nut_radius = 6.9/2;
nut_drill = 3.4;

module lens() {
  rotate( v = [1,0,0], a = 180 ) {
    translate(v=[0, 0, -2])
      cylinder(h = 2.5, r = 9.75, $fn = 50);
    cylinder(h = 1.8, r = 14.2, $fn = 50);
    cylinder(h = 13, r1 = 12.25, r2 = 5, $fn = 50);
    translate(v=[0, -3, 15]) {
      cylinder(h = 20, r1 = 6, r2=8, $fn = 50);
      for(i = [0 : 6]) {
        translate(v=[0, i, 0]) {
          cylinder(h = 20, r1 = 6, r2=8, $fn = 50);
        }
      }
    }
  }
  translate(v=[4.8, (-6.2 / 2), -4.2]) {
    cube(size=[9.5, 6.2, 4.2]);
  }
  translate(v=[-25/2, -17.2/2, -(18 + 13)]) {
    cube(size=[25, 17.2, 21]);
    translate(v=[18/2, -20/2, 0])
    cube(size=[6, 36, 21]);
  }
}

module nut(z, radius, fn) {
  rotate([0, 0, 90]) 
  cylinder(h=z, r=radius, $fn=fn, center=true);
}

module disc(z, s) {
  rotate([0, 0, 90]) 
  cylinder(h=z, r=s, $fn=50, center=true);
}

module mscrew(z) {
  translate(v=[0, 0, -5]) {
    cylinder(h = (z + 10), r = 2, $fn = 50);
  }
  translate(v=[0, 0, z-1]) {
    disc(8, 4);
  }
}

module mount(s, mh) {
  mscrew(mh);
  translate([s, 0, 0])
    mscrew(mh);
  translate([0, s, 0]) {
    mscrew(mh);
    translate([s, 0, 0])
      mscrew(mh);
  }
}

module mscrew2(z) {
  translate(v=[0, 0, -5]) {
    cylinder(h = (z + 10), r = 2, $fn = 50);
  }
  translate(v=[0, 0, 1]) {
    nut(22, nut_radius, 6);
  }
}

module mount2(s, mh) {
  mscrew2(mh);
  translate([s, 0, 0])
    mscrew2(mh);
  translate([0, s, 0]) {
    mscrew2(mh);
    translate([s, 0, 0])
      mscrew2(mh);
  }
}

module screw() {
  translate(v=[0, 0, -5]) {
    cylinder(h = (h + 10), r = 2, $fn = 50);
  }
  translate(v=[0, 0, h-1]) {
    nut(14, nut_radius, 6);
  }
  translate(v=[0, 0, 1]) {
    nut(14, nut_radius, 6);
  }
}

module screw_pair(x, inset) {
  translate(v=[x, inset, 0]) {
    screw();
  }
  translate(v=[x, w - inset, 0]) {
    screw();
  }
}

module rscrew() {
  translate(v=[0, 0, -5]) {
    cylinder(h = (h + 10), r = 2, $fn = 50);
  }
  translate(v=[0, 0, h-1]) {
    nut(14, nut_radius, 6);
  }
  translate(v=[0, 0, 1]) {
    nut(14, nut_radius + 0.7, 60);
  }
}

module rscrew_pair(x, inset) {
  translate(v=[x, inset, 0]) {
    rscrew();
  }
  translate(v=[x, w - inset, 0]) {
    rscrew();
  }
}


module case(top) {
  difference() {
    cube(size=[l, w, h+5]);
    translate(v=[1, w / 2, h / 2]) {
      rotate( v = [0, 1, 0], a = -90 ) {
        lens();
      }
    }
    screw_pair(20, 6);
    screw_pair(l - 30, 20);
    if (top == 1) {
      translate(v=[-2, -2, -2]) {
        cube(size=[l+ 5, w + 5, (h / 2) + 2]);
      }
    } else {
      translate(v=[-2, -2, (h/2)+1]) {
        cube(size=[l+ 5, w + 5, (h / 2) + 10]);
      }
    }

    // battery wires
    translate([30 + pcb_l, 4.5, h/2 - 1])
      cube(size=[20, 1.5, 4]);
    translate([30 + pcb_l, w - 6, h/2 - 1])
      cube(size=[20, 1.5, 4]);

    // mount
    translate([60, (w - 25) / 2, 0])
      mount(25, 10);

    translate([34, 0, -2]) {
      // pcb
      translate([0, (w - pcb_w) / 2, 10]) {
        cube(size=[pcb_l, pcb_w, h - 5]);
      }

      // battery
      for(i = [0 : 10]) {
        translate([pcb_l + 25 + i, w - 2, h/2 + 2]) {
          rotate( v = [1,0,0], a = 90 ) {
            cylinder(h = w - 4, r = 10, $fn = 50);
          }
        }
      }
    }
    
    // light sensor
    translate([45, 6, 11]) {
      rotate(v=[1, 0, 0], a=90) {
        cylinder(h = 20, r = 2.8, $fn = 50);
        translate([0, 0, 2])
        cylinder(h = 5, r = 4, $fn = 50);
        translate([0, 0, -4.5])
        cylinder(h = 5, r = 5, $fn = 50);
      }
    }
    
    // speedometer light
    translate([45, w + 10, 9]) {
      rotate(v=[1, 0, 0], a=90) {
        cylinder(h = 35, r = 4.3, $fn = 50);
        translate([0, 0, 11.5])
        cylinder(h = 10, r = 5.5, $fn = 50);
      }
    }
    
    // hole for wires
    if (top == 1) {
      translate([80, w - 10, h/2 - 1])
      cube([5, 20, 8]);
    }
  }
}

module stem2(sl, sw, sh) {
  difference() {
    difference() {
      union() {
        translate([45, 0, -45])
        cube(size = [sl -20, sw, sh + 30]);
        
        cube(size = [sl, sw, sh]);
        translate([20, 0, 0]) {
          for(i=[0 : sw]) {
            translate([0, i, 0])
            cylinder(h=sh, r= 20, $fn = 50);
          }
        }
      }
      for(i = [0 : 3]) {
        translate(v=[25 + i,sw/2,-1]) {
          cylinder(h = sh + 4, r = (stem_d / 2), $fn = 50);
        }
      }
    }
    translate([5, -5, 10]) {
      rotate(v=[0, 1, 0], a = 90) {
        screw();
        translate([-20, 0, 0])
        screw();
        translate([0, 55, 0])
        screw();
        translate([-20, 55, 0])
        screw();
      }
    }
    translate([20, 0, 30])
    rotate(v=[0, 1, 0], a = 78) {
      translate([47, 10, 15])
      mount2(25, 30);
      translate([-10, -3, 40])
      cube([110, 50, 50]);
      translate([35, -10, -31])
      cube([110,60, 50]);
    }
    
  }
  
  
}

module stem(top) {
  difference() {
    translate([-45 + (100 * top), 0, 0])
    stem2(75, 45, 40);
    translate([-20, -40, -20])
    cube([100, 130, 100]);
  }
}

module rear2(x, y) {
  difference() {
    translate([0, 0, -2])
    cube([x, y, 56]);
    translate([x/2, y/2, 0]) {
      cylinder(h = 16, r = 11.9, $fn = 50);
      translate([0, 0, -4]) {
        cylinder(h = 5, r = 10, $fn = 50);
      }
    }
    
    // tube
    translate([x/2, x + 35, 31]) {
      rotate(v=[1, 0, 0], a = 90)
      cylinder(h = x + 70, r = (seat_d / 2), $fn = 50);
      translate([0, 0, -17])
      rotate(v=[1, 0, 0], a = 90)
      cylinder(h = x + 5, r = 1.8, $fn = 50);
    }

    // screws
    translate([2, -11, 68])
    rotate(v = [0, 1, 0], a = 90) {
      rscrew_pair(20, 17);
    }
    translate([2, -11, 25])
    rotate(v = [0, 1, 0], a = 90) {
      rscrew_pair(20, 17);
    }
  }
}

module rear(top) {
  difference() {
    rear2(34, 46);
    if (top == 0) {
      translate([34 - 17, -10, -10])
      cube([35, 70, 80]);
    } else {
      translate([-18, -10, -10])
      cube([35, 70, 80]);
    }
  }
}

//rear(0);

//translate([34, 0, -20])
//rotate(v=[0, 1, 0], a = 180)
//rear(1);

//stem(1);
case(1);


