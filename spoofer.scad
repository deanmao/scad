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

h = 60;
w = 50;
l = 32 + ninev_h + 20; 
side = 10;

module casing() {
  difference() {
    cube([l + 5, w + side, h + 5]);

    // pcb
    translate([28, side / 2, 2])
    cube([pcb_l, pcb_w, 100]);

    // holes
    translate([25, side / 2, h - 3])
    cube([5, 5, 5]);
    translate([25, (w - 5) + side / 2, h - 3])
    cube([5, 5, 5]);

    // coil
    translate([2, ((w + side) - coil_h) / 2, h - coil_l - 6])
    cube([coil_w, coil_h, 100]);
    translate([4, ((w + side) - 10) / 2, h - 3])
    cube([5, 10, 5]);

    // buttons & rfid board
    translate([6, side / 2, 2])
    cube([20, pcb_w, 100]);

    // 9v battery
    translate([55, ((w + side) - ninev_w) / 2, 2])
    cube([ninev_h, ninev_w, 100]);
    translate([51, ((w + side) - 5) / 2, h - 3])
    cube([5, 5, 5]);
    
    // button holes on bottom
    translate([16, 12, h - 40])
    rotate( v = [1,0,0], a = 90 ) {
      cylinder(30, r = 3.7, $fn=50 );
      cylinder(10, r = 7, $fn=50 );
    }
    translate([16, 2, h - 20])
    rotate(v=[1, 0, 0], a=90) {
      cylinder(h = 20, r = 2.9, $fn = 50);
      translate([0, 0, -4.5])
      cylinder(h = 5, r = 7, $fn = 50);
    }
    
    cover();
  }
}


module cover() {
  translate([2, side / 2, (h + 5) - 3.9]) {
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

casing();
//cover();