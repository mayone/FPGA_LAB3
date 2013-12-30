module circle(CLK, RESET, center_x, center_y, HSYNC, VSYNC, R, G, B);

	input		CLK, RESET;
	input 	center_x, center_y;
	output 	HSYNC, VSYNC;
	output	R, G, B;
	
	// variables
	
	wire			HSYNC, VSYNC;
	wire			R, G, B;
	reg [2:0]	RGB_buff;
	wire 			visible;
	
	reg [10:0]	pixel_col, pixel_row;
	reg [10:0]	col, row;
	reg [10:0]	d2;
	reg [10:0]	dist;
	reg			row_inc;
	reg			INSIDE;
	
	// design
	
	assign HSYNC = ~( (pixel_col >= 919) & (pixel_col < 1039) );
	assign VSYNC = ~( (pixel_col >= 659) & (pixel_col < 665) );
	assign visible = ( (pixel_col > 104) & (pixel_col < 904) & (pixel_row > 23) & (pixel_col < 623) );
	
	assign R = ( visible ) ? RGB_buff[2] : 0;
	assign G = ( visible ) ? RGB_buff[1] : 0;
	assign B = ( visible ) ? RGB_buff[0] : 0;
	
	assign col = pixel_col - center_x;     // dx
	assign row = pixel_row - center_y;     // dy
	
	always@( posedge CLK ) begin     // move horizontally
		if( RESET ) pixel_col <= 0;
		else if( pixel_col == 1039 ) pixel_col <= 0;
		else pixel_col <= pixel_col + 1;
	end
	
	always@( posedge CLK ) begin     // carry of changing row
		if( RESET ) row_inc <= 0;
		else if( pixel_col == 1039 ) row_inc <= 1;
		else row_inc <= 0;
	end
	
	always@( posedge CLK ) begin     // move vertically
		if( RESET ) pixel_row <= 0;
		else if ( pixel_row == 665 ) pixel_row <= 0; 
		else if( row_inc ) pixel_row <= pixel_row + 1;
		else pixel_row <= pixel_row;
	end
	
	always@( posedge CLK ) begin
		if( RESET ) RGB_buff <= 3'b000;
		else if( INSIDE ) RGB_buff <= 3'b100;
		else RGB_buff <= 3'b111;
	end
	
	always@( posedge CLK ) begin
		d2 = col * col + row * row;
	end
	
	always@( d2 ) begin
		dist
	end

endmodule
