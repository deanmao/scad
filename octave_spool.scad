radius = 12;

cube([3, 34, 32]);
translate([3, 10, 0])
cube([6, 3, 32]);

translate([9, -15, 0]) {
  cube([3, 34, 32]);
  translate([3, 0, 0]) {
    difference() {
      translate([0, 12, radius])
      rotate([90, 0, 90])
      cylinder(h=95, r=radius, $fn=50);
      translate([0, -radius, 0])
      cube([95, radius * 2, radius * 2]);
    }
    translate([0, 4, 0])
    cube([95, 8, radius * 2]);
  }
}
