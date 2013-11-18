// Broom Handle Screw End Plug
// Ed Nisley KE4ZNU March 2013
 
// Extrusion parameters must match reality!
//  Print with +1 shells and 3 solid layers
 
ThreadThick = 0.25;
ThreadWidth = 2.0 * ThreadThick;
 
HoleWindage = 0.2;
 
function IntegerMultiple(Size,Unit) = Unit * ceil(Size / Unit);
 
Protrusion = 0.1;           // make holes end cleanly
 
//----------------------
// Dimensions
 
PI = 3.14159265358979;
 
PostOD = 22.3;              // post inside metal handle
PostLength = 25.0;
 
FlangeOD = 24.0;            // stop flange
FlangeLength = 3.0;
 
PitchDia = 15.5;            // thread center diameter
ScrewLength = 20.0;
 
ThreadFormOD = 2.5;         // diameter of thread form
ThreadPitch = 5.0;
 
BoltOD = 7.0;               // clears 1/4-20 bolt
BoltSquare = 6.5;           // across flats
BoltHeadThick = 3.0;
 
RecessDia = 6.0;            // recesss to secure post in handle
 
OALength = PostLength + FlangeLength + ScrewLength; // excludes bolt head extension
 
$fn=8*4;
 
echo("Pitch dia: ",PitchDia);
echo("Root dia: ",PitchDia - ThreadFormOD);
echo("Crest dia: ",PitchDia + ThreadFormOD);
 
//----------------------
// Useful routines
 
module Cyl_Thread(pitch,length,pitchdia,cyl_radius,resolution=32) {
 
Cyl_Adjust = 1.25;                      // force overlap
 
    Turns = length/pitch;
    Slices = Turns*resolution;
    RotIncr = 1/resolution;
    PitchRad = pitchdia/2;
    ZIncr = length/Slices;
    helixangle = atan(pitch/(PI*pitchdia));
    cyl_len = Cyl_Adjust*(PI*pitchdia)/resolution;
 
    union() {
        for (i = [0:Slices-1]) {
            translate([PitchRad*cos(360*i/resolution),PitchRad*sin(360*i/resolution),i*ZIncr])
                rotate([90+helixangle,0,360*i/resolution])
                    cylinder(r=cyl_radius,h=cyl_len,center=true,$fn=12);
        }
    }
}
 
module PolyCyl(Dia,Height,ForceSides=0) {           // based on nophead's polyholes
 
  Sides = (ForceSides != 0) ? ForceSides : (ceil(Dia) + 2);
 
  FixDia = Dia / cos(180/Sides);
 
  cylinder(r=(FixDia + HoleWindage)/2,
           h=Height,
       $fn=Sides);
}
 
module ShowPegGrid(Space = 10.0,Size = 1.0) {
 
  Range = floor(50 / Space);
 
    for (x=[-Range:Range])
      for (y=[-Range:Range])
        translate([x*Space,y*Space,Size/2])
          %cube(Size,center=true);
 
}
 
//-------------------
// Build it...
 
ShowPegGrid();
 
difference() {
    union() {
        cylinder(r=PostOD/2,h=PostLength);
        cylinder(r=PitchDia/2,h=OALength);
        translate([0,0,PostLength])
            cylinder(r=FlangeOD/2,h=FlangeLength);
        translate([0,0,(PostLength + FlangeLength)])
            Cyl_Thread(ThreadPitch,(ScrewLength - ThreadFormOD/2),PitchDia,ThreadFormOD/2);
    }
 
    translate([0,0,-Protrusion])
        PolyCyl(BoltOD,(OALength + 2*Protrusion),6);
    translate([0,0,(OALength - BoltHeadThick)])
        PolyCyl(BoltSquare,(BoltHeadThick + Protrusion),4);
 
//    translate([0,0,(PostLength + FlangeLength + ThreadFormOD)])
//        Cyl_Thread(ThreadPitch,(ScrewLength - ThreadFormOD/2),PitchDia,ThreadFormOD/2);
 
    for (i = [0:90:270]) {
        rotate(i)
            translate([PostOD/2,0,PostLength/2])
                sphere(r=RecessDia/2,$fn=8);
    }
}
