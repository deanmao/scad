/***************************************************************
 Parameterized Battery pack with electrical connections
  (c) 2010 Juan Gonzalez-Gomez (Obijuan) juan@iearobotics.com
   This design is derived from the Battery comparment generator
   (c) Nikolaus Gradwohl (guru (at) local-guru.net)
    http://www.thingiverse.com/thing:5051
Other contributors:
  * Chris Thompson (http://eagleapex.com/): Connection in series along the case
 -----------------------------------------------------------
 The nuts (two per battery) are embedded into the battery pack. 
 The screws (two per battery) are inserted from the outside and
 touch the batteries.
-----------------------------------------------------------
GPL LICENCE
****************************************************************/

//-- Battery sizes

AA = [ 14.5, 51.5 ];
AAA = [ 10.5,44.5 ];
C = [ 26.2, 50 ];
D = [ 34.2, 61.5 ]; 

// CHOOSE BATTERY TYPE AND COUNT 
typ = AA;
num =2;


//---------------------------------
//-- Battery pack parameters
//-- Can be set by the user
//---------------------------------

//-- Battery pack thickness
bottom_thick=1.5;
fr_thick=3.5;    //-- Front and rear parts
side_thick=2;    //-- Side part

//-- Distance beween batteries
distance_bat=1;

//-- Nut parameters
nut_h = 2.5;
nut_radius = 6.8/2;
nut_drill = 3.4;

//------------------------------
//-- IMPLEMENTATION
//------------------------------
//-- Battery dimensions: width, height and length. Change ser for batteries in series along the case.  

ser=2;
w=typ[0];
h=w;
l=typ[1]*ser;

//-- Dimensions of the inner part of the compartiment
ip_l = l;
ip_w = w + (w+distance_bat)*(num-1);
ip_h = h;

//-- Dimensions of the mother cube
mc_l = ip_l+2*fr_thick;
mc_w = ip_w+2*side_thick;
mc_h = ip_h+bottom_thick;
pad = 10;

module notch() {
  translate([0,-(mc_w+pad)/2, 0]) {
    cube(size=[6, 6, 40], center=true);
    translate([0,mc_w+pad,0]) {
      cube(size=[6, 6, 40], center=true);
    }
  }
}

module slots() {
  translate([-mc_l/2 + 8, (mc_w+pad)/2 - 3, mc_h/2 - 1])
  cube(size=[20, 1, 20], center=true);
  translate([-mc_l/2 + 8, -(mc_w+pad)/2+3, mc_h/2 - 1])
  cube(size=[20, 1, 20], center=true);
}

//-- The process of building the battery pack is just substracting
//-- things to the mother cube
module casing() {
rotate([0,0,90]) {
  difference() {
    //-- The mother cube
     translate([0,0,-bottom_thick/2])
      cube(size=[mc_l, mc_w+pad, mc_h],center=true);

    //-- Array of batteries
    translate([0,0,h/2])
    cube(size=[ip_l,ip_w,ip_h],center=true);

    translate([0,-mc_w/2+w/2+side_thick,0])
    for ( i = [0:num-1] ) {

      translate([0,i*(w+distance_bat),0])
      union() {
        translate([0,0,h/2])
           cube(size=[l,w,h],center=true);

        rotate([0,90,0])
          cylinder(r=w/2, h=l-0.01, center=true, $fn=50); 
      }
    }

    translate([mc_l/4, 0, 0]) {
      notch();
    }
    translate([-mc_l/4, 0, 0]) {
      notch();
    }

    slots();
    

    //-- Array of contacts
    translate([0,-mc_w/2+w/2+side_thick,0])
    for ( i = [0:num-1] ) {
      //-- Drills
      translate([0,i*(w+distance_bat),0])
      rotate([0,90,0])
      cylinder(center=true,h=l+20, r=nut_drill/2, $fn=50, center=true);

      //-- Room for the embedded nuts
      translate([0,i*(w+distance_bat),0])
      rotate([0,90,0]) 
      cylinder(h=l+2*nut_h, r=nut_radius, $fn=6, center=true);
    }
  }
}
}

casing();