include <threads.scad>;

difference() {
	metric_thread(19, 2, 30);
	translate([0, 3.5, -0.2]) cylinder(r = 7/2, h = 30.3, $fn=10);
	translate([0, -4, -0.2]) cylinder(r = 7/2, h = 30.3, $fn=10);
}
