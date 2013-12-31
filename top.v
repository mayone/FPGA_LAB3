`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    27/12/2013 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: VGA
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(CLK, RESET, HSYNC, VSYNC, R, G, B);
	 
input 	CLK, RESET;
output 	HSYNC, VSYNC, R, G, B;
	
// variables

wire	[10:0] center_x, center_y;
wire 	HSYNC, VSYNC, R, G, B;

// design

bounce bouncing(CLK, RESET, center_x, center_y);
circle O_o(CLK, RESET, center_x, center_y, HSYNC, VSYNC, R, G, B);



endmodule
