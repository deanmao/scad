coil_w = 2;
coil_h = 34;
coil_l = 43;

rfid_l = 45;
rfid_w = 24;
rfid_h = 15;

ninev_l = 56;
ninev_w = 27.5;
ninev_h = 18;

pcb_w = 50;
pcb_l = 25;
pcb_h = 60;

h = 25;
w = 60;
l = 105; 
side = 10;

module cover() {
  translate([-2, side / 2, (h + 5) - 3.9]) {
    cube([l + 5, w, 4]);
    translate([0, 0, 1.5])
    rotate( v = [0,1,0], a = 90 ) {
      cylinder(l + 5, r = 1.5, $fn=50 );
    }
    translate([0, w, 1.5])
    rotate( v = [0,1,0], a = 90 ) {
      cylinder(l + 5, r = 1.5, $fn=50 );
    }
  }
}

module case() {
  difference() {
    cube([l + 5, w + side, h + 5]);

    translate([2, ((w + side) - ninev_l)/2, 3])
    cube([ninev_h, ninev_l, 100]);
  
    translate([4 + ninev_h, ((w + side) - pcb_h)/2, 3])
    cube([pcb_w, pcb_h, 100]);

    translate([6 + ninev_h + pcb_w, ((w + side) - pcb_h)/2, 3])
    cube([coil_h, pcb_h, 100]);

    // hole through walls
    translate([5, 10, h-4])
    cube([80, 10, 10]);
  
    // buttons
    translate([6 + ninev_h + pcb_w + 18, ((w + side) - pcb_h)/2 + 7, 15])
    rotate( v = [1,0,0], a = 90 ) {
      cylinder(30, r = 3.7, $fn=50 );
      cylinder(10, r = 7, $fn=50 );
    }
    translate([6 + ninev_h + pcb_w + 18, ((w + side) - pcb_h)/2 + 63, 15])
    rotate(v=[1, 0, 0], a=270) {
      cylinder(h = 20, r = 2.9, $fn = 50);
      translate([0, 0, -4.5])
      cylinder(h = 5, r = 7, $fn = 50);
    }
  
    cover();
  };

  translate([6 + ninev_h + pcb_w + 5, ((w + side) - 34)/2, 3])
  cube([25, 34, 3]);

  translate([6 + ninev_h + pcb_w, side/2, 3])
  cube([coil_h, 8, 3]);

  translate([6 + ninev_h + pcb_w, (w + side) - (side/2) - 8, 3])
  cube([coil_h, 8, 3]);
}

case();

