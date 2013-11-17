//inner dia 2.960"
// about 1" tall

lenscapID = 2.960 * 25.4;
lenscapOD = lenscapID + 15;
lenscapHeight = 1 * 25.4 + 1;

module eyelets(height) {
		difference() {
			cylinder(r = 7, h = height);
			translate([0, 0, -1]) cylinder(r = 5, h = height + 10);
	}
}

module bottom() {
		translate([0, lenscapOD / 2 + 5, 0]) eyelets(lenscapHeight);
		translate([0, -(lenscapOD / 2 + 5), 0]) eyelets(lenscapHeight);
		difference() {
			cylinder(r = lenscapOD / 2, h = lenscapHeight);
			translate([0, 0, 5]) cylinder(r1 = lenscapID / 2, r2 = lenscapID / 2 + 4, h = lenscapHeight);
		}
}

module top() {
	// 2.840 height
	// 1.925 dia top
	topHeight = 2.9 * 25.4;
	translate([0, 0, lenscapHeight + 2]) {
		translate([0, lenscapOD / 2 + 5, -5]) eyelets(topHeight + 1);
		translate([0, -(lenscapOD / 2 + 5), -5]) eyelets(topHeight + 1);
			difference() {
					translate([0, 0, -5]) cylinder(r = lenscapOD / 2, h = topHeight  + 1);
					translate([0, 0, -5.2]) cylinder(r = (lenscapID / 2) + 5, h = 0.2 * 25.4);
					translate([0, 0, -5]) cylinder(r = lenscapID / 2, h = topHeight);
				}
	}
}

//bottom();
$fn = 50;
top();
