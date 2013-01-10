footLength = 5;
difference() {
  cylinder(footLength, r=7, $fn=50);
  translate(v=[-2.5, -3.4, -1]) {
    cube(size=[5.3, 12, footLength + 2]);
  }
}
