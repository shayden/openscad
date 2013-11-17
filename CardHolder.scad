include <WriteSCAD/Write.scad>;

cardWidth = 63.4;
cardStack = 45;
cardHeight = 88.1;

boxWidth = cardWidth + 10;
boxDepth = cardStack + 10;
boxHeight = cardHeight + 21;

lidHeight = boxHeight * .2;

module cardPack() {
	cube([cardWidth, cardStack, cardHeight]);
}

module cardHolder() {
	cube([cardWidth + 10, cardStack + 10, cardHeight + 10]);
}

module box() {
	difference() {
		cardHolder();
		translate([
			-(cardWidth - boxWidth) / 2, 
			-(cardStack - boxDepth) / 2,
			-(cardHeight - boxHeight + 20) / 2 
			])
				cardPack();
	}
}

module boxLid() {
	intersection() {
		cube([boxWidth, boxDepth, lidHeight]);
		box();
	}
}

grooveWidth = cardWidth + 5;
grooveDepth = cardStack + 5;
grooveHeight = 5;

module boxGroove(centerHole) {
	difference() {
		cube([grooveWidth, grooveDepth, grooveHeight]);
		translate([
			(grooveWidth - cardWidth) / 2,
			(grooveDepth - cardStack) / 2,
			-grooveHeight
			  ]) scale([1 * centerHole, 1 * centerHole, 1 ]) cardPack();
	}
}
module boxCut() {
	difference() {
		box();
		translate([-5, -5, -.1]) cube([boxWidth + 10, boxDepth + 10, lidHeight + .1]);
	}
}

module finalLid() {
	difference() {
		boxLid();
		translate([
			(boxWidth - grooveWidth) / 2,
			(boxDepth - grooveDepth) / 2,
			lidHeight - grooveHeight + 0.1 
			]) 
				boxGroove(0.1); 
	}
}
	
module finalBox() {
	union() {
		boxCut();
		translate([
			(boxWidth - grooveWidth) / 2,
			(boxDepth - grooveDepth) / 2,
			lidHeight - grooveHeight
			]) 
				boxGroove();
	}
}
module hunterBox() {
	difference() {	
		finalBox();
		union() {
			translate([225, 13.5, 70]) 
				rotate([90, 180, 0]) 
					import("Magic/black.stl");
			translate([boxWidth - 28 / 2, 2.5, 90]) 
				rotate([270, 0, 180]) 
					write("HUNTER", h = 10, t = 3, space = 1.3);	
		}
	}
}

module kaitieBox() {
	difference() {	
		finalBox();
		union() {
			translate([225, 13.5, 70]) 
				rotate([90, 180, 0]) 
					import("Magic/green.stl");
			translate([boxWidth - 28 / 2, 2.5, 90]) 
				rotate([270, 0, 180]) 
					write("KAITIE", h = 10, t = 3, space = 1.3);	
		}
	}
}

translate([0, 0, boxHeight - lidHeight / 2]) rotate([180, 0, 0]) kaitieBox();
//translate([-boxWidth * 1.5, 0 , 0]) finalLid();
