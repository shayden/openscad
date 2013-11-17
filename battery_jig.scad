
module subC_NiCd() {
	cylinder(r=23.1/2, h=50);
}

union() {
		translate([-10, -10, 0]) cube([125, 75, 10]);
		translate([0, 0, 8])
		difference() {
			cube([100, 55, 40]);
				for(j = [ 0 : 1]) {
					for( i = [ 0 : 3 ] ) {
						translate([2, 2, 0])
						translate([12.5 + (i * 24), 
								   12.5 + (j * 24), 
								   -1]) 
									subC_NiCd();
					}
				}
		}
}
