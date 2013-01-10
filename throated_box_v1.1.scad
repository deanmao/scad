//	throated box
//	
//	verion 1.1
//	
//	generates a 3D model of a box of arbitrary internal dimensions
//	with a "throat" on which the lid rests
//
//	by Theron Trowbridge
//	therontrowbridge.com


//	Parameters
//	CHANGE THESE

//	interior size
int_x = 40;
int_y = 40;
int_z = 30;

//  tab parameters
tab_hole_radius=2.5;
tab_outer_radius=8;

//	thin walls
//	if "true" this takes the shortest dimension of the box
//	and uses that to calculate wall thickness for each side
//	if "false" the walls are proportional
//	to the size of the box in each dimension
thin_walls = false;

//	wall thickness
//	wall thickness is calculated as a coefficient
//	of the interior dimensions
//
//	with thick walls (thin_walls==false),
//	larger values produce odd results
inner_sides = 0.1;
outer_sides = 0.1;

//	inner_length and outer_length determine how tall
//	the "throat" is and how much room there is
//	under the lid but above the throat
//	these are coefficients of the interior volume of the box
//	and as such should be > 0 and <= 1.0
//	when inner_length == 1.0, lid sits right on throat
inner_length = 0.75;
outer_length = 0.5;
lid_length = 1-outer_length;

//	slop is an adjustment to make the lid a little looser
//	so that it fits without being too tight.
slop = 1;


//	Calculations

inner_x = int_x + ( int_x * ( inner_sides * 2 ) );
inner_y = int_y + ( int_y * ( inner_sides * 2 ) );
inner_z = ( int_z * inner_length ) + ( int_z * inner_sides );
full_inner_z = int_z + ( int_z * inner_sides );

outer_x = inner_x + ( int_x * ( outer_sides * 2 ) );
outer_y = inner_y + ( int_y * ( outer_sides * 2 ) );
outer_z = ( int_z * outer_length ) + ( int_z * outer_sides );

lid_x = inner_x + ( int_x * ( inner_sides * 2 ) );
lid_y = inner_y + ( int_y * ( inner_sides * 2 ) );
lid_z = ( int_z * lid_length ) + (int_z * inner_sides ) + ( int_z * outer_sides );


//	Calculations for thin_walls==true

min_int_xy = min( int_x, int_y );
min_int = min( int_z, min_int_xy );

inner_thickness = min_int * inner_sides;
outer_thickness = min_int * outer_sides;


thin_inner_x = int_x + ( inner_thickness * 2 );
thin_inner_y = int_y + ( inner_thickness * 2 );
thin_inner_z = ( int_z * inner_length ) + inner_thickness;
thin_full_inner_z = int_z + inner_thickness;

thin_outer_x = thin_inner_x + ( outer_thickness * 2 );
thin_outer_y = thin_inner_y + ( outer_thickness * 2 );
thin_outer_z = ( int_z * outer_length ) + outer_thickness;

thin_lid_x = thin_inner_x + ( outer_thickness * 2 );
thin_lid_y = thin_inner_y + ( outer_thickness * 2 );
thin_lid_z = ( int_z * lid_length ) + inner_thickness + outer_thickness;

mythick = outer_thickness + 2;
thick = inner_thickness + outer_thickness;
  
if ( thin_walls == false ) {
  difference() {
    thick_box();
  	translate([-outer_x/2 - 1,-thick/2,thick + 8])
  	  cube([thick+5, thick, thin_outer_z * 2]);
  }
} else {
	thin_box();
}

module tab() {
	difference(){
		union() {
			translate([-2*tab_outer_radius,-tab_outer_radius,0])
			  cube([2*tab_outer_radius,tab_outer_radius,outer_thickness + 5]);
			translate([-tab_outer_radius,0,0])
				cylinder(r=tab_outer_radius, h = outer_thickness + 5, $fn=50);
		}
		translate([-tab_outer_radius,0,0])
		cylinder(r= tab_hole_radius, h = outer_thickness+20,center=true, $fn=50);
	}
}

module insert_tabs(tab_outer_y) {
  translate([tab_outer_radius, tab_outer_y + mythick,0]) {
    tab();
    mirror([0, 1, 0]) {
      translate([0, 2*tab_outer_y + 2 * mythick, 0])
      tab();
    }
  }
}

module thick_box() {
	//	box bottom
	difference() {
		union() {
			//	innner box volume
			translate( v=[0,0,(inner_z/2)+(int_z*inner_sides)] ) {
				cube( size=[inner_x,inner_y,inner_z], center=true );
			}
			//	outer box volume
			translate( v=[0,0,outer_z/2] ) {
				cube( size=[outer_x,outer_y,outer_z], center=true );
			}
		}
	
		//	interior volume
		translate( v=[0,0,(int_z/2)+(int_z*inner_sides)+(int_z*outer_sides)] ) {
			cube( size=[int_x,int_y,int_z], center=true );
		}
	}
	
	insert_tabs(outer_y / 2);
	
	//	lid
	translate( v=[	(1+(inner_sides+outer_sides*4))*int_x,0,outer_z+lid_z] ) {
		rotate( a=[0,180,0] ) {
			difference() {
				//	lid volume
				translate( v=[	0,0,(lid_z/2)+outer_z] ) {
					cube( size=[lid_x,lid_y,lid_z], center=true );
				}
				//	inner box volume, all the way to the lid
				translate( v=[0,0,(full_inner_z/2)+(int_z*inner_sides)] ) {
					cube( size=[inner_x+slop,inner_y+slop,full_inner_z+4], center=true );
				}
			}
		}
	}
}


module thin_box() {
	//	box bottom
	difference() {
		union() {
			//	innner box volume
			translate( v=[0,0,(inner_z/2)+outer_thickness] ) {
				cube( size=[inner_x,inner_y,inner_z], center=true );
			}
			//	outer box volume
			translate( v=[0,0,thin_outer_z/2] ) {
				cube( size=[thin_outer_x,thin_outer_y,thin_outer_z], center=true );
			}
		}

		//	interior volume
		translate( v=[0,0,(int_z/2)+inner_thickness+outer_thickness] ) {
			cube( size=[int_x,int_y,int_z], center=true );
		}
	}

  insert_tabs(thin_outer_y / 2);

	//	lid
	translate( v=[	(int_x+(inner_thickness+outer_thickness)*3),0,thin_outer_z+thin_lid_z] ) {
		rotate( a=[0,180,0] ) {
			difference() {
				//	lid volume
				translate( v=[0,0,(thin_lid_z/2)+thin_outer_z] ) {
					cube( size=[thin_lid_x,thin_lid_y,thin_lid_z], center=true );
				}
				//	inner box volume, all the way to the lid
				translate( v=[0,0,(thin_full_inner_z/2)+inner_thickness] ) {
					cube( size=[thin_inner_x+slop,thin_inner_y+slop,thin_full_inner_z], center=true );
				}
			}
		}
	}
}
