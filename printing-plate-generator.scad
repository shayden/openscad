// Plate parameters
plate_width = 60;
plate_height = 45;
plate_thickness = 3;

// Design parameters
design_filename = "Sample inputs/flourish-60x45.dxf";
design_thickness = 1.5;

// Call the name of the module you want to run
// (choose from relief(), intaglio() and stencil()
relief();

/*************************************************
 Generate an embossing plate
 - Extrudes your design and places it on top of a flat plate
**************************************************/
module relief() {
	translate([-plate_width/2, -plate_width/2, 0]) {
		// Create the plate under the design
		cube(size = [plate_width, plate_height, plate_thickness]);
	
		// Place the design on top of the plate
		translate([0,0,plate_thickness])
			linear_extrude(height = design_thickness)
				import(design_filename);
	}
}

/**************************************************
 Generate a debossing plate
 - Subtracts your design into the top of a single plate
***************************************************/
module intaglio() {
	translate([-plate_width/2, -plate_width/2, 0]) {
		difference() {
			// Create the plate under the design
			cube(size = [plate_width, plate_height, plate_thickness]);
	
			// Subtract the design from the top of the plate
			translate([0, 0, plate_thickness - design_thickness])
				linear_extrude(height = design_thickness)
					import(design_filename);
		}
	}
}

/***************************************************
 Generate a stencil
 - Cuts your design all the way through a plate
****************************************************/
module stencil() {
	translate([-plate_width/2, -plate_width/2, 0]) {
		difference() {
			// Create the plate under the design
			cube(size = [plate_width, plate_height, plate_thickness]);
	
			// Subtract the design from the plate
			linear_extrude(height = plate_thickness)
				import(design_filename);
		}
	}
}