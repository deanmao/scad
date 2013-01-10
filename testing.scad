
difference() {
  cube([10, 10, 10]);
  translate([5, 5, 5]) {
    rotate(v = [1, 0, 0], a=90) {
      cylinder(h = 12, r = 2, $fn = 6);
    }
  }

}
