w = 16;
h = 13;
l = 45;
pad = 6;
taper = 4;

header_w = 8.5;
header_h = 4.8;

module screw() {
  cylinder(h = 15, r = 1.5, $fn = 50);
  cylinder(h = 10, r = 1.7, $fn = 50);
  cylinder(h = 3, r1 = 3, r2 = 1.7, $fn = 50);
}

module rounded_cube(sx,sy,sz,r) 
{
	union()
	{
		translate([r,r,0]) cube([sx-2*r,sy-2*r,sz],false);
		translate([r,0,r]) cube([sx-2*r,sy,sz-2*r],false);
		translate([0,r,r]) cube([sx,sy-2*r,sz-2*r],false);

		translate([r,r,r]) rotate(a=[0,90,0]) cylinder(h=sx-2*r,r=r,center=false,$fn=50);
		translate([r,sy-r,r]) rotate(a=[0,90,0]) cylinder(h=sx-2*r,r=r,center=false,$fn=50);
		translate([r,r,sz-r]) rotate(a=[0,90,0]) cylinder(h=sx-2*r,r=r,center=false,$fn=50);
		translate([r,sy-r,sz-r]) rotate(a=[0,90,0]) cylinder(h=sx-2*r,r=r,center=false,$fn=50);

		translate([r,r,r]) rotate(a=[0,0,0]) cylinder(h=sz-2*r,r=r,center=false,$fn=50);
		translate([r,sy-r,r]) rotate(a=[0,0,0]) cylinder(h=sz-2*r,r=r,center=false,$fn=50);
		translate([sx-r,r,r]) rotate(a=[0,0,0]) cylinder(h=sz-2*r,r=r,center=false,$fn=50);
		translate([sx-r,sy-r,r]) rotate(a=[0,0,0]) cylinder(h=sz-2*r,r=r,center=false,$fn=50);

		translate([r,r,r]) rotate(a=[-90,0,0]) cylinder(h=sy-2*r,r=r,center=false,$fn=50);
		translate([r,r,sz-r]) rotate(a=[-90,0,0]) cylinder(h=sy-2*r,r=r,center=false,$fn=50);
		translate([sx-r,r,r]) rotate(a=[-90,0,0]) cylinder(h=sy-2*r,r=r,center=false,$fn=50);
		translate([sx-r,r,sz-r]) rotate(a=[-90,0,0]) cylinder(h=sy-2*r,r=r,center=false,$fn=50);

		translate([r,r,r]) sphere(r, $fn = 50);
		translate([r,sy-r,r]) sphere(r, $fn = 50);
		translate([r,r,sz-r]) sphere(r, $fn = 50);
		translate([r,sy-r,sz-r]) sphere(r, $fn = 50);

		translate([sx-r,r,r]) sphere(r, $fn = 50);
		translate([sx-r,sy-r,r]) sphere(r, $fn = 50);
		translate([sx-r,r,sz-r]) sphere(r, $fn = 50);
		translate([sx-r,sy-r,sz-r]) sphere(r, $fn = 50);
	}
}

module thing(top) {
  difference() {
    rounded_cube(l + 4 + taper, w + (pad * 2), h + 4, 3);
    translate([2, pad, 2])
    cube([l, w, h]);
    if (top == 0) {
      translate([-1, -1, (h + 4) / 2])
      cube([l + 6 + taper + 10, w + (2 + pad * 2), (h + 4) / 2 + 1]);
      translate([-5, (w - header_w + (pad * 2)) / 2, 2])
      cube([20, header_w, 20]);
    } else {
      translate([-1, -1, -1])
      cube([l + 6 + taper, w + (2 + pad * 2), (h + 4) / 2 + 1]);
      translate([(l + 4 + taper - 10) / 2 - 0.25, 2, h / 2 + 1])
      cube([10.5, 1.4, 2]);
      translate([(l + 4 + taper - 10) / 2 - 0.25, 2 + w + pad, h / 2 + 1])
      cube([10.5, 1.4, 2]);
    }
    translate([l, (w + (pad * 2)) / 2, h - 4.5])
    rotate(v=[0, 1, 0], a=90) {
      cylinder(h = 20, r = 2, $fn = 50);
    }
    translate([(l + 4 + taper) / 4, 3, -1]) {
      screw();
    }
    translate([(l + 4 + taper) / 4, 3 + w + pad, -1]) {
      screw();
    }
    translate([ 3 * (l + 4 + taper) / 4, 3, -1]) {
      screw();
    }
    translate([3 * (l + 4 + taper) / 4, 3 + w + pad, -1]) {
      screw();
    }
  }
  if (top == 1) {
    translate([0, (w - header_w + (pad * 2)) / 2, 2.5 + header_h])
    cube([2, header_w, header_h]);
  } else {
    translate([(l + 4 + taper - 10) / 2, 2, h / 2 + 0.8])
    cube([10, 1.5, 2]);
    translate([(l + 4 + taper - 10) / 2, 2 + w + pad, h / 2 + 0.8])
    cube([10, 1.5, 2]);
  }
}
thing(1);

