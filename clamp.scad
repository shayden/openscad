difference() {
	union() {
		translate([25/2, 0, 0]) cylinder(r = 25/2, h = 10);
		translate([25/2, 75, 0]) cylinder(r = 25/2, h = 10);
		cube([25, 75, 10]);
	}
	translate([(25 - 10) / 2, (75 - 55) /2, -0.1])
	union() {
		translate([10/2, 0, 0]) cylinder(r = 10/2, h = 10.2);
		translate([10/2, 55, 0]) cylinder(r = 10/2, h = 10.2);
		cube([10, 55, 10.2]);
	}
}