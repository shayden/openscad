// test

difference()
{
		union()
		{
				union()
				{
					cube([5,5,1]);
					rotate([0, 0, 180]) cube([5,5,1]);
					sphere(5);
				}
				translate([0, 0, -5]) cylinder(h=5, r1=5, r2=3);
		}
		// x y z
		translate([0, 0, -6])
			cylinder(h=20, r1=1, r2=1);
}
