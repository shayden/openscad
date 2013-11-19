include <threads.scad>;

connectorRadius = 26/2;
connectorHeight = 15;

module connector () {
		insetDepth = 5;
		insetRadius = 23/2;
		slotWidth = 5;
		slotHeight = 5;
		difference() {
				union() {
						// this is the locking key
						translate([0, 0, insetDepth - slotHeight/2]) 
							cube([(connectorRadius * 2) - 0.7, slotWidth, slotHeight], center = true);

						difference() {
								difference() {
										cylinder(r = connectorRadius, h = connectorHeight);
										// bottom inset
										translate([0,0,-0.1]) 
											cylinder(r = insetRadius, h = insetDepth + 0.01);
								}
										// top inset
										translate([0,0,connectorHeight - insetDepth + 0.01])
											cylinder(r = insetRadius, h = insetDepth + 0.02);
						}
				}
			translate([0,0, -0.01]) cylinder(r = 4, h = connectorHeight + 0.01);		
		}
}

difference() {
		hull() {
				rotate([0,0,90]) cylinder(r = );
				translate([0.5, 25, 5]) cube([25, 25, 10], center = true);
		}
		rotate([0,0,90]) connector();
}
