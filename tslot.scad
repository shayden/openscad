use <MCAD/shapes.scad>

topSlotHeight = 9.5;
topSlotWidth = 10.5;
slotWidth = 16.2;
slotLength = 20;
bottomSlotHeight = 5;
slotHeight = topSlotHeight + bottomSlotHeight;

bedWidth = 110;
bedLength = 125;
bedHeight = slotHeight * 1.2;

bedNutRadius = 5;
bedNutHeight = 0.226 * 25.4;

module tslotNutProfile() {
	union() {
	// bottom of tslot nut
		cube([slotWidth, slotLength, bottomSlotHeight]);
		translate([(slotWidth - topSlotWidth) / 2,0,bottomSlotHeight - 0.1]) 
			cube([topSlotWidth, slotLength, topSlotHeight + 0.1]);
	}
}
module tslotNut() {
	difference() {
		difference() {
			tslotNutProfile();
			// drill the center hole
			translate([slotWidth / 2, slotLength / 2, -0.1]) 
				cylinder(r = 4, h = slotHeight + 0.2, $fn = 10);
		}
		// Create a nut/hex head "insert"

		translate([slotWidth / 2, slotLength / 2,2.1]) 
			rotate([0,0,90]) # quarter20Nut();
			//cylinder (r = 5, h = 2, $fn = 6);
	}
}
module quarter20Nut() {
	union() {
		// .438" - .428" across the flats, .226" - 0.212" height
		hexagon(size = 0.442 * 25.4, height = 0.226 * 25.4);
		// tap size .2010 (aka #7 drill)
		translate([0, 0, -5])
			cylinder(r = (.2010 / 2) * 25.4, h = 1 * 25.4);
	}
}
module lineup(num, space) {
	for( i = [0 : num - 1])
		translate([ space * i, 0, 0 ]) child(0);
}

module linedown(num, space) {
	for ( i = [ 0 : num - 1])
		translate([ 0, space * i, 0]) child(0);
}
module bedPlate() {
	cube( [bedWidth, bedLength + 25, slotHeight / 2] );
}
module bed() {
	spaceBetweenSlots = slotWidth * 1.8;

	difference() {
		cube( [bedWidth, bedLength, bedHeight] );
		// kick over the first slot
		translate([slotWidth * 0.8, 0, 0])
		for (i = [ 0 : floor(bedWidth / (slotWidth + spaceBetweenSlots))]) {
			translate([spaceBetweenSlots * i, 
							-0.1, 
							bedHeight - slotHeight + 0.1]) {
				scale([1, bedLength, 1]) tslotNutProfile();
			}
		}
	}
}
module printBed() {
	// take the difference of the nut inserts and the bed+drilled holes
	difference() {
		// take the difference of the drilled holes and the bed
		difference() {
			bed();

			linedown(3, 50) 
			// left holes
			difference() {
				translate([7, 10, -1]) cylinder(r = 3, h = bedHeight + 5, $fn = 10);
			
			}
			linedown(3, 50) 
				translate([bedWidth - 7, 10, -1]) 
					cylinder(r = 3, h = bedHeight + 2, $fn = 10);
		}
		// These are the nut inserts/hex head inserts
		linedown(3, 50)translate([7, 10, bedHeight - bedNutHeight + 0.1]) 
			//rotate([0, 0, 90])cylinder(r = bedNutRadius, h = bedNutHeight, $fn = 6);
			# quarter20Nut();

		linedown(3, 50) translate([bedWidth - 7, 10, bedHeight - bedNutHeight + 0.1]) 
			//rotate([0, 0, 90]) cylinder(r = bedNutRadius, h = bedNutHeight, $fn = 6);
			# quarter20Nut();
	}
}

//translate([0, 100, 0]) rotate([-270,0,0])printBed();

linedown (3, 25) lineup(3, 25) tslotNut();

//tslotNut();