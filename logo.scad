module logo() {
  scale([0.5, 0.5, 0.5]) {
    linear_extrude(height = 20) import_dxf(file = "logo.dxf");
  }
  translate([12, 20, 0])
  cube([80, 70, 1]);
}

scale([0.5, 0.5, 0.5]) {
  // difference() {
  //   translate([12, 20, 0])
  //   cube([80, 70, 10]);
  //   logo();
  // }
  logo();
}
