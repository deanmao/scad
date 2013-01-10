module holes(z, s) {
  translate([0.9, 1.2, -1]) {
    for(i = [0 : 3]) {
      translate([i * 2, 0, 0])
      cube([s, s, z]);
    }
  }
}
difference() {
  cube([8.7, 3.1, 15]);
  holes(7, 0.7);
  translate([0, 0.9, 0.7])
  rotate(v=[1, 0, 0], a = 20)
  holes(12, 1.1);
  translate([0, 1.4, 2])
  holes(12, 1.1);
}
