module beam() {
		difference() {
				rotate(a=[0,90,0]) cylinder(h=50, r=5, $fn=50);
				translate([25, 0, -3])  
					cube( size = [55, 15, 8], center = true );
		}
}

module endPiece() {
		cube( size = [5, 12, 5], center = true);
}


module moldedEndPiece() {
		difference() {
				endPiece();
				translate([50, 0, 0]) endPiece();
				translate([0, 0, -1]) beam();
		}
}

translate([5, 0, 0]) beam();
//translate([0, 0, 4]) moldedEndPiece();
//translate([-10, 0, 4]) moldedEndPiece();
