use <MCAD/shapes.scad>

module iphone4s_withcase() {
	$fn = 50;
	minkowski() {
			cube([118.5, 61.9, 11.75]);
			cylinder(r = 5, h = 1);
	}
}

module nintendo_ds() {
}

module iphone4s_clamp() {
		difference() {
				difference() {
						 translate([25, 12, -13])
							 rotate([90, 0, 0])  cube([75, 50, 11.75 * 3]);
						 rotate([90, 0, 0])  iphone4s_withcase();
				}
				translate([35, -35, -5])
						cube([55, 50, 50]);
		}

}

module iphone4s_rounded_clamp() {
		$fn=50;
		minkowski() {
				iphone4s_clamp();
				translate([25, 15, 30]) cylinder(r = 0.75, h = 1);
		}
}

module quarter20Nut() {
	union() {
		// .438" - .428" across the flats, .226" - 0.212" height
		hexagon(size = 0.430 * 25.4, height = 0.226 * 25.4);
		// tap size .2010 (aka #7 drill)
		translate([0, 0, -5])
			cylinder(r = (.2010 / 2) * 25.4, h = 1 * 25.4);
	}
}

module iphone4_tripod() {
		difference() {
				iphone4s_rounded_clamp();
				translate([85, 10, 17]) quarter20Nut();
		}
}

iphone4_tripod();
