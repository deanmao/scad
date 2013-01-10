stem_w = 35;
stem_d = 32;

seat_d = 27.1;

difference() {
  cube(size = [45, 40, 1]);
  for(i = [0 : 3]) {
    translate(v=[20 + i,20,-1]) {
      cylinder(h = 4, r = (stem_d / 2), $fn = 50);
    }
  }
}

translate(v=[0, 50, 0]) {
  difference() {
    cube(size = [32, 32, 1]);
    translate(v=[16, 16,-1]) {
      cylinder(h = 4, r = (seat_d / 2), $fn = 50);
    }
  }
}
