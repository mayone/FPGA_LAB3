`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:41:09 12/30/2013 
// Design Name: 
// Module Name:    circle 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module circle(CLK, RESET, center_x, center_y, HSYNC, VSYNC, R, G, B);

	input		CLK, RESET;
	input	[10:0] center_x, center_y;
	output 	HSYNC, VSYNC;
	output	R, G, B;
	
	// variables
	
	reg [2:0]	RGB_buff;
	wire 			visible;
	
	reg [10:0]	pixel_col, pixel_row;
	wire[10:0]	col, row;
	reg [19:0]	d2;
	reg			row_inc;
	reg			INSIDE;
	
	// design
	
	assign HSYNC = ~( (pixel_col >= 919) & (pixel_col < 1039) );
	assign VSYNC = ~( (pixel_row >= 659) & (pixel_row < 665) );
	assign visible = ( (pixel_col > 104) & (pixel_col < 904) & (pixel_row > 23) & (pixel_row < 623) );
	
	assign R = ( visible ) ? RGB_buff[2] : 0;
	assign G = ( visible ) ? RGB_buff[1] : 0;
	assign B = ( visible ) ? RGB_buff[0] : 0;
	
	assign col = ( pixel_col > center_x ) ? pixel_col - center_x : center_x - pixel_col;     // dx
	assign row = ( pixel_row > center_y ) ? pixel_row - center_y : center_y - pixel_row;     // dy
	
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
		//d2 <= col * col + row * row;
		if((col*col + row*row) > 10000) INSIDE <= 0;
		else INSIDE <= 1;
	end
	/*
	always@( d2 ) begin
		if( d2 < 10000 ) INSIDE <= 1;
		else INSIDE <= 0;
	end
	*/

endmodule
