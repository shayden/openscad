use <inkscape.scad>;

translate([0, 0, 10])
rotate([0, 270, 0])
union() {
	difference() {
		hull() {
			union() {
				translate([50, 10, 25])
					rotate([90, 0, 0])  
						cylinder(r = 25, h = 10);
				cube([50, 10, 50]);
			}
		}
		rotate([180, 270, 90]) 
			scale([0.25, 0.25, 0.25]) 
				translate([95, 90, 36])
				flower();
	}
	rotate([0, 0, 90]) # cube([50, 10, 50]);
}
