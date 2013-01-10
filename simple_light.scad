use <Thread_Library.scad>

wall = 3;
light_r = 14;
light_h = 26;

stem_r = 21;

threadd = 2*(light_r + 3);
threadh = 10;
pitch = 4;

coin = 15;

cwidth = (light_r + wall + 3) * 2;

nut_radius = 8.1/2;
nut_height = 3.4;

module nut() {
  cylinder(h=nut_height, r=nut_radius, $fn=6);
}


module cap() {
  difference() {
    trapezoidThread(length=threadh,pitchRadius=threadd/2-pitch/4 - 1,pitch=pitch, clearance=0.2, stepsPerTurn=80, threadAngle=50);
    cylinder(h=threadh + 5, r=3, $fn=50);
    translate([-1, 0, 2*coin - 9])
    rotate(v=[0, 1, 0], a = 90)
    cylinder(h=2, r=coin);
  }
}

module front() {
  translate([50, 0, 0]) {
    cap();
  }

  difference() {
    union() {
      cylinder(h = light_h + threadh + wall - 1, r1=light_r + wall, r2=stem_r + wall, $fn=50);
      translate([0, 0, -1 + wall + light_h + threadh])
      cylinder(h = stem_r + 3, r = stem_r + wall, $fn=50);
    }
    translate([0, 0, -1]) {
      cylinder(h = wall, r=light_r - wall, $fn=50);
      translate([0, 0, -0.1 + wall]) {
        cylinder(h = light_h, r=light_r, $fn=50);
        translate([0, 0, -0.1 + light_h]) {
          trapezoidThreadNegativeSpace(length=threadh,pitchRadius=threadd/2-pitch/4,pitch=pitch,countersunk=0.05, stepsPerTurn=80);
          translate([0, 0, -0.1 + threadh]) {
            cylinder(h = stem_r, r=(threadd / 2) + 1, $fn=50);
            translate([7.5, -(stem_r*2), 2]) {
              cube([4, (stem_r * 5) + 4, 2]);
              translate([-18.8, 0, 0])
                cube([4, (stem_r * 5) + 4, 2]);
            }
            translate([-(stem_r + wall + 5), 0, stem_r + 3]) {
              rotate(v=[0,1,0], a=80) {
                cylinder(h = 3 * (stem_r + wall), r = stem_r, $fn=50);
                translate([stem_r + wall - 3, 0, 0])
                cylinder(h=18, r=1.5, $fn=50);
              }
            }
          }
        }
      }
    }
  }
}

module back() {
  translate([50, 0, 0]) {
    cap();
  }
  
  difference() {
    translate([-cwidth / 2, -cwidth / 2, 0])
    cube([cwidth, cwidth + 10, light_h+10]);
    translate([0, 0, -1]) {
      cylinder(h = wall, r=light_r - wall, $fn=50);
      translate([0, 0, -0.1 + wall]) {
        cylinder(h = light_h, r=light_r, $fn=50);
        translate([0, 0, -0.1 + light_h]) {
          trapezoidThreadNegativeSpace(length=threadh,pitchRadius=threadd/2-pitch/4,pitch=pitch,countersunk=0.05);
        }
      }
    }
    // screw & nut mount
    translate([-10, 0, 12])
    rotate([0, 90, 0])
    translate([0, light_r + 9, 0]) {
      translate([0, 0, 20]) {
        translate([-nut_radius, 0, 0])
          cube([nut_radius * 2, 20, nut_height]);
        nut();
      }
      translate([0, 0, -18])
        cylinder(h=50, r=2.2, $fn=50);
    }
  }
}

front();
