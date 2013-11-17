use <WriteScad/write.scad>;

// write on a cube
module nametag() {
		translate([0,0,0]);
		//difference() {
				difference() {
						cube([40,15,2]);
						translate([2, 13, -1]) cylinder(h = 8, r=1, $fn=100);
						translate([38, 13, -1]) cylinder(h = 8, r=1, $fn=100);
				}
				//translate([3, 2.5, 1]) cube([34, 10, 2]);
		//}
}

module name() {
		writecube("HUNTER",[20,8,1],[40,30,2],face="top",h=8);
		writecube("HLH",[20,8,1],[40,30,1.01],face="bottom",h=8);
}

module ASide() {
		difference () {
			nametag();
			intersection() {
				nametag();
				name();
			}
		}
}

module BSide() {
		difference() {
			name();
			intersection() {
				nametag();
				name();
			}
		}
}


ASide();
//BSide();
