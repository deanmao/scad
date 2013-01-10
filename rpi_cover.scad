// Raspberry Pi Case
// Hans Harder 2012
//
// Warning: this is based on the Beta board dimensions...
//          so production models can be slightly different
//          for instance SD card holder height and USB socket dimensions
//
// Since all connectors stick out, case is split on HDMI height
// so the power and sdcard holder goes in first and then the pcb drops into place.
//
// v2: Adapted version after some suggestions from David...
//     removed feet, made both surface flat
// v3: Added fliptop option and smooth the corners of the box
// v4: Different levels of case split (make it 3d printable, thx David)
//     Looks strange but it fits...
//     Added frame mode (so no bottom and top deck)
//     Moved screw locations due to split and added some support structures
//     Unsure about 2nd screw location in combination with GPIO pins
// v5  relocated a lot of code in modules
//     SDslot location was not calculated correctly
// v6  Added pcb drawing
//     Added colors
//     Cut out better so there is no debris around
//     DRAwvars and options seperated, so it is easier to do 1 part
//     Make a low as possible case, let USB stick out
// v7  PCB options
//     Low level case optimisations
//     SD card location alterations
// v8  adapted pcb dimensions, board is really 56mm width
//     adapted support studs, moved some due to component location
//     components locations adapted
// v9  Added logo in seperate dxf file
//     Option added to put logo in middle or using whole deck
//     beautified code, kr style
// v10 Added logosunken and bottomsupport structures
//     Bottom supports are located where no components are located
//       so the pcb is not only supported from the sides
//     Well got my case, so based on what I see I changed:
//     case split level changed, should be better when printed on a reprap
//     Removed screwholes (far to small) for fastening top and added some more studs
//     Made frontstud a little thicker
// v11 Different splitlevel (more simple) on back
//     keep a little margin on back split, so that top and bottom always fit
//     added openlogo option
// v12 Different component locations/sizes
//     keep a little margin on component holes
//     pcbsize to 57.0 x 86.0   (actual it is 56.17 x 85.0)
//     made casestuds wider and added 2 minor holes for self tapping screws
// v13 skip this one.... :)
// v14 Production board measurements...
//	   small differences, sometimes components are soldered differently
//     keep more space
//     should fit like a glove...
//
//     no more changes I think until I get the definite board...

// All parts are draw as default just disable the ones you don't want
DRAWfull        = 0;
DRAWtop         = 1;
DRAWbottom      = 0;
DRAWtopinlet    = 0;
DRAWbottominlet = 0;
DRAWpcb         = 0;

// select how the case should look like
topframe    = false;        // if false, underneath values determines how
topinlet    = false;        // false is outside, otherwise it is with an indent
topholes    = false;
// ---- top holes sizes
//holeofs=0;
//holesiz=2;
//holestep=5.2;
//noholes=20;					// 12 for top,  20 for bottom
//holeangle1=[0,0, 30];
//holeangle2=[0,0, -30];
// ---- bottom holes sizes
holeofs=5;
holesiz=2.5;
holestep=6;
noholes=12;					// 12 for top,  20 for bottom
holelen=30;
holeangle1=[0,0, 0];
topmiddle   = false;
toplogo     = false;
toplogopc   = -1;            //  0   0  placement correction of logo
toplogoxm   = 0;            //  3   6  leftmargin of logo
toplogotm   = 2;        // 12  15  topmargin of logo
toplogohole = false;
toplogosunken=false;              // true or false, no idea if this works on a reprap

gpioslot = true; // cutout for GPIO pins on top

bottomframe = false;        // if false, underneath values determines how
bottominlet = false;
bottomholes = false;
bottomscrew = false;
bottomfeet  = false;
bottomsupport = true;         // Added extra support locations for pcb
bottomclick   = true;
bottompcb    = false;		    // just a pcb holder without a top

box_thickness = 2.0;            // minimum = 1.0
inside_h      = 12.1;           // 12.1 = lowprofile    16.5 is full height
pcb_h         = 6.6;            // height needed for SD holder and solder points of pcb
//pcb_h         = box_thickness+3.5;    // height needed for SD holder and solder points of pcb
// 4.1 = no deck, box_thickness+3.5 is with deck

// just some colors to see the difference
CASEcolor="Maroon";
CONNcolor="Silver";
LOGOcolor="White";

// Define Raspberry Pi pcb dimensions in mm
inside_l = 86.0;                //85.00 is largest length reported, so a bit room on each side
inside_w = 57.0;                //56.17 is largest width  reported, so a bit room on each side
pcb_thickness = 1.6;

// Coordinates based on RJ45 corner = 0,0,0
// pcb connectors and locations. Based on Beta Board measurements of Gert and a real RPi

// Connectors
Crj45_x=2.0;			 //2.0
Crj45_y=-1;
Crj45_w=16.4;			// 15.4
Crj45_d=21.5;           //21.8
Crj45_h=13;

Cusb_x=24.5;            // 23.9
Cusb_y=-7.7;
Cusb_w=13.9;            // 13.3
Cusb_d=19.0;			// 17.2
Cusb_h=15.4;

Cpwr_x=3.25;				// 3.5 3.6
Cpwr_y=80.9;
Cpwr_w=8.6;				// 7.8 7.6
Cpwr_d=5.6;
Cpwr_h=2.5;

Chdmi_x=-1.2;
Chdmi_y=32.0;               // 32.4  if 15.1
Chdmi_w=11.4;
Chdmi_d=17.8;				  // 15.7 15.3
Chdmi_h=6.4;

Csnd_x=inside_w - 11.4;
Csnd_y=17.0;
Csnd_w=11.4;
Csnd_d=10.0;
Csnd_h=10.5;
Csnd_r=6.7;
Csnd_z=3.0;
Csnd_l=3.4;

Crca_x=inside_w - 10.0 - 2.1;
Crca_y=34.0;                // 34.6 was 35.2
Crca_w=10.0;
Crca_d=10.4;                 // 9.8
Crca_h=13.0;
Crca_r=8.6;
Crca_z=4;
Crca_l=10;                  // wild guess

Cgpio_w=7.0;
Cgpio_d=35.0;				  
Cgpio_h=9.0;
Cgpio_x=56.17-Cgpio_w;
Cgpio_y=87.0-.75-Cgpio_d;        


pcb_c = pcb_h + pcb_thickness;            // component height
casesplit = pcb_c + Chdmi_h;              // split case at top of hdmi connector
echo("casesplit=",casesplit);
echo("case dimensions: w=",box_w," l=",box_l," h=",box_h);

// side stud sizes for supporting pcb
stud_w = 2;
stud_l = 4;

// calculate box size
box_l  = inside_l + (box_thickness * 2);
box_w  = inside_w + (box_thickness * 2);
box_h  = pcb_c + (pcb_thickness * 2) + inside_h;
box_w1 = box_thickness;
box_w2 = box_w - box_thickness;
box_l1 = box_thickness;
box_l2 = box_l - box_thickness;
box_wc = box_w / 2;                 // center width
box_lc = box_l / 2;                 // center length
box_t2 = box_thickness / 2.0;           // half box_thickness
middle = true;
// rounded corners
corner_radius = box_thickness*2;



// count no of items to draw
DRAWtotal = DRAWfull + DRAWtop + DRAWbottom + DRAWtopinlet + DRAWbottominlet;

// ====================================================== DRAW items
// if one  draw it centered
if (DRAWtotal == 1) {
    translate(v = [ -box_w/2, -box_l / 2, 0]) {
        if (DRAWfull ) {
        //   draw_case(0,1);
         //  translate(v=[0,0,0.2]) draw_case(1,0);
        }
        if (DRAWtop   ) {
            rotate(a=[0,180,0]) translate(v=[-box_w,0,-box_h]) draw_case(0,1);
        }
        //if (DRAWbottom) draw_case(1,0);
        //if (DRAWtopinlet) make_deck(inside_w-5,inside_l-5,0, 12,3,5, holes=topholes,feet=false,middle=topmiddle,screwholes=false,logo=toplogo);
        //if (DRAWbottominlet) make_deck(inside_w-5,inside_l-5,0, 12,3,5, holes=bottomholes,feet=true,middle=false,screwholes=bottomscrew,logo=false);
    }
} else {
// draw each one on there one location
    if (DRAWfull)   {
        translate(v = [ box_w+20, -box_l / 2, 0]) {
            draw_case(1,0);
            translate(v=[0,0,0.2]) draw_case(0,1);
        }
    }
    if (DRAWbottom) {
        translate(v = [ 5, 5, 0]) draw_case(1,0);
    }
    if (DRAWtop)    {
        translate(v = [ - 5,  5, box_h])  rotate(a=[0,180,0]) draw_case(0,1);
    }
    if (DRAWtopinlet) {
        translate(v = [ -box_w-5,  -box_l-5, 0])    make_deck(inside_w-5,inside_l-5,0, 12,3,5, holes=topholes,feet=false,middle=topmiddle,screwholes=false,logo=toplogo);
    }
    if (DRAWbottominlet) {
        translate(v = [ 5       ,  -box_l-5, 0]) make_deck(inside_w-5,inside_l-5,0, 10,3,5 , holes=bottomholes,feet=true,middle=false,screwholes=bottomscrew,logo=false);
    }
}

// ======================================================= END of draw
// Module sections

module put_pilogo(w,h,mx,mh,mt) {
    fn="raspberrypi_logo.dxf";
    // calculate the scale and which offset to use
    scx=(w- (mx*2)) / 155.0;
    ofsy= (h - mh) - (205.0*scx);

    translate(v=[mx+toplogopc,ofsy-toplogotm,0]) linear_extrude(height=mt) import(file=fn, scale=scx);
}

module make_deckholes(no,w,d,step,v) {
for ( i = [0 : 1 : no - 1] ) {
        translate(v=[w/2,(i*step)+(step/2),box_thickness/2]) rotate(a=v) cube([w,d, box_thickness+18], center=true);
    }
}

module make_gianthole(no,w,d,step,v) {
    i = 10;
    translate(v=[w/2,(i*step)+(step/2),box_thickness/2]) rotate(a=v) cube([w+50, d+80, box_thickness+18], center=true);
}


// create a deck or insert
module make_deck(w,d,z,hole_no,hole_size,hole_step) {
    hole_w=(w - 12) / 2;      // change 12 for middle piece size
    ofs1=4;
    ofs2=w - ofs1 - hole_w;
    hole_ofs= ((d - hole_no*hole_step) / 2) - box_thickness/2;
    translate(v = [(box_w-w)/2, (box_l-d)/2,z]) {
        color(CASEcolor) {
            echo("deck : z=",z," w=",w+0.01," d=",d+0.01);
            difference() {
                cube([w, d, box_thickness], center = false);
                if (top && !logo && holes && hole_size>0) {
                    if (holeangle1 != [0,0,0]) {
                       translate(v=[-1,hole_ofs+holeofs,-0.1]) make_deckholes(noholes,holelen,holesiz,holestep,holeangle1);
                       //translate(v=[w/2-2,hole_ofs+holeofs,-0.1]) make_deckholes(noholes,holelen,holesiz,holestep,holeangle2);
                    } else {
                       //translate(v=[ofs1,hole_ofs+holeofs,-0.1]) make_deckholes(noholes,hole_w,holesiz,holestep,holeangle1);
                       translate(v=[ofs1,hole_ofs+holeofs,-0.1]) make_gianthole(noholes,hole_w,holesiz,holestep,holeangle1);
                       //translate(v=[ofs2,hole_ofs+holeofs,-0.1]) make_deckholes(noholes,hole_w,holesiz,holestep,holeangle2);
                    }
                }
            }
        }
    }
}

module rounded_corner(x,y,rx,ry,cx,cy) {
    translate(v = [x, y, -1]) {
        difference() {
            translate(v=[rx,ry,0])    cube([corner_radius,corner_radius,box_h+2], center=false);
            translate(v=[cx, cy, -1]) cylinder(r=corner_radius, h=box_h+2, $fn=100);
        }
    }
}


module make_topcomponents() {

}

module make_connholes() {

}

module make_pcb() {
    translate(v=[box_w1,box_l1,pcb_h]) {
        color("darkgreen") cube([inside_w,inside_l,pcb_thickness], center=false);
    }
}

// put extra supports on free spaces, used beta board image
module make_supports() {
    if (!bottomframe) {
        translate(v=[box_w1+10 ,box_l1+28,0.1]) cube([3, 2,pcb_h-0.1]);
        translate(v=[box_w2-7.5,box_l1+28,0.1]) cube([3, 2,pcb_h-0.1]);

        translate(v=[box_w1+7  ,box_l2-35,0.1])  cube([5, 5,pcb_h-0.1]);
        translate(v=[box_w2-13 ,box_l2-35,0.1])  cube([5, 5,pcb_h-0.1]);

        translate(v=[box_w1+12 ,box_l2-16,0.1])  cube([1.5 ,5,pcb_h-0.1]);
        translate(v=[box_w2-9  ,box_l2-16,0.1])  cube([1.5 ,5,pcb_h-0.1]);
    }
}

// width,depth,height,boxthickness,ledgethickness
module make_case(w,d,h,bt,lt) {
    dt=bt+lt;    // box+ledge thickness
    bt2=bt+bt;    // 2x box thickness
    // Now we just substract the shape we have created in the four corners
    color(CASEcolor) difference() {
        cube([w,d,h], center=false);
        if (rounded) {
            rounded_corner(-0.1,d+0.1, 0             ,-corner_radius,  corner_radius,-corner_radius);
            rounded_corner(w+0.1,d+0.1, -corner_radius,-corner_radius, -corner_radius,-corner_radius);
            rounded_corner(w+0.1,-0.1, -corner_radius,0             , -corner_radius, corner_radius);
            rounded_corner(-0.1,-0.1, 0             ,0             ,  corner_radius, corner_radius);
        }
        // empty inside, but keep a ledge for strength
        translate(v = [bt, bt, dt])   cube([w-bt2, d-bt2, h-(dt*2)], center = false);
        translate(v = [dt,dt,bt])     cube([w-(dt*2), d-(dt*2), h-bt2], center = false);
        // remove bottom and top deck
        translate(v = [box_thickness+5, box_thickness+5,-2]) {
            cube([inside_w-10, inside_l-10, box_h+4], center = false);
        }
    }
    if (!topframe) {
        if (!topinlet) {
            make_deck(inside_w-4,inside_l-4,box_h-box_thickness, 12,3,5, holes=topholes,feet=false,middle=topmiddle,screwholes=false,logo=toplogo,top=true);
        } else {
            make_deck(inside_w-4,inside_l-4,box_h-box_thickness*2, 12,3,5, holes=topholes,feet=false,middle=topmiddle,screwholes=false,logo=toplogo,top=true);
        }
    }
    if (!bottomframe) {
        if (!bottominlet) {
            make_deck(inside_w-4,inside_l-4,0, 12,3,5, holes=bottomholes,feet=bottomfeet,screwholes=bottomscrew,middle=false,logo=false,top=false);
        } else {
            make_deck(inside_w-4,inside_l-4,box_thickness, 12,3,5, holes=bottomholes,feet=bottomfeet,screwholes=bottomscrew,middle=false,logo=false,top=false);
        }
        if (bottomsupport) {
            make_supports();
        }
    }
}

module make_stud(x,y,z,w,h,l) {
    translate(v = [x, y, z]) cube([w, l, h], center = false);
}

module set_cutout(x,y,z,w,l,h) {
    color(CASEcolor)    translate(v = [x+(w/2), y+(l/2), z+(h/2)]) cube([w+0.4, l+0.2, h+0.2], center = true);
}

module set_cutoutv(x,y,z,w,l,h) {
    color(CASEcolor)    translate(v = [x+(w/2), y+(l/2), z+(h/2)]) cube([w+0.2, l+0.4, h+0.2], center = true);
}

module draw_pcbhold() {

}

module split_top() {

}

module remove_top() {

}

module remove_bottom() {
    split1=box_w1+Cpwr_x;
    split2=split1+Cpwr_w;
    split3=box_w2 - 7.1;
    possd1=box_w1 + Csd_x - 0.2;
    widesd1=Csd_w+0.6;
    // Different splitlevels for the shells
    // 1st half on split level
    translate(v = [-1,  -1, -1])    cube([box_w+2, box_l-6, casesplit+1], center = false);
    // back on 3 different levels
    translate(v = [-1, 20, -1])     cube([box_w+2  , box_l, pcb_c+1.1], center = false);
//    translate(v = [-1, 20, -1])     cube([split1+1.1 , box_l, casesplit+1], center = false);
//    translate(v = [-1, 20, -1])     cube([split2+1.1 , box_l, pcb_c+Cpwr_h+1.1], center = false);
//    translate(v = [split3, 20, -1]) cube([20       , box_l, casesplit+1], center = false);
}

module draw_case(bottom, top) {
    difference() {
        union() {
            // make empty case
            difference() {
                make_case(box_w,box_l,box_h, box_thickness,stud_w, rounded=true);
                if (top != 0 && bottom == 0)    remove_bottom();
                if (top == 0 && bottom != 0)    remove_top();
            }
            color(CASEcolor) {
                if (bottom != 0 ) {
                    // add bottom studs for pcb
                    // add bottom studs for pcb
                    make_stud(box_w1       , box_l1         , 0, 4,pcb_h,4);      // rj45
                    make_stud(box_w1       , box_lc-stud_l/2, 0, stud_w,pcb_h,stud_l);      // hdmi
                    make_stud(box_w1, box_lc/2, 0, 4,pcb_h,stud_l);
                    make_stud(box_w1, box_lc+(box_lc/2)-5, 0, 4,pcb_h,stud_l);

                    make_stud(box_w1, box_l2-stud_l-8, 0, stud_w,pcb_h,stud_l);        // BEFORE pwr
                    make_stud(box_w2-stud_w, box_l1         , 0, stud_w,pcb_h,stud_l);      // leds
                    make_stud(box_w2-4, box_lc-stud_l/2, 0, 4,pcb_h,stud_l);                // RCA
                    make_stud(box_w2-stud_w, box_l2-stud_l  , 0, stud_w,pcb_h,stud_l);      // GPIO


                    translate(v=[box_w1+Cusb_x-6,box_l1,1])  cube([3.0, 4,pcb_h-1.1]);
                    translate(v=[box_w2-15.8    ,box_l1,1])  cube([3.0, 4,pcb_h-1.1]);

                    draw_pcbhold();
                }

                if (top != 0) {

                }
            } // color
        } // end union
        // conn plate hole
        color(CASEcolor) {
        translate(v = [box_w1-5, box_l2-5, casesplit-3]) {
				rotate([0,90,0]) cylinder(r=0.5, h=10, $fn=100);
		 }
        translate(v = [box_w2-5, box_l1+5, casesplit-3]) {
				rotate([0,90,0]) cylinder(r=0.5, h=10, $fn=100);
		 }
        }
        if (bottom != 0) {
            if (top == 0) {
                remove_top();
            } else {
                split_top();
            }
        }
        make_connholes();
    }
    if (bottom) {
        draw_pcbhold();
        if (DRAWpcb == 1)  make_pcb();
    }
} // end module
