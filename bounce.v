`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:58:11 12/30/2013 
// Design Name: 
// Module Name:    bounce 
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
module bounce(CLK, RESET, center_x, center_y);
	input CLK;
	input RESET;
	output reg center_x, center_y;
	
	reg [19:0] counter;
	reg enable;
	reg [5:0] velocity;
	reg v_dir; //1 represents upward, 0 represents downward
	
	always @ (posedge CLK) begin
		if (RESET) begin
			counter <= 0;
		end else if (counter == 692639) begin
			counter <= 0;
		end else begin
			counter <= counter + 1;
		end
	end
	
	always @ (counter) begin
		if (counter == 0) begin
			enable <= 1;
		end else begin
			enable <= 0;
		end
	end
	
	always @ (posedge CLK) begin
		if (RESET) begin
			v_dir <= 0;
			velocity <= 1;
		end else if (enable == 0) begin
			v_dir <= v_dir;
			velocity <= velocity;
		end else if (center_y == 500) begin
			v_dir <= !v_dir;
			velocity <= velocity / 2;
		end else if (velocity == 0) begin
			v_dir <= !v_dir;
			velocity <= 1;
		end else begin
			case (v_dir)
			1'b0: 
			begin
				v_dir <= v_dir;
				velocity <= velocity + 1;
			end
			1'b1:
			begin
				v_dir <= v_dir;
				velocity <= velocity - 1;
			end
			endcase
		end
	end
	
	always begin
		center_x <= 504;
	end
	
	always @ (posedge CLK) begin
		if (RESET) begin
			center_y <= 0;
		end else if (enable == 0) begin
			center_y <= center_y;
		end else if (v_dir == 0 && center_y + velocity > 500) begin
			center_y <= 500;
		end else begin
			case (v_dir)
			1'b0:
				center_y <= center_y + velocity;
			1'b1:
				center_y <= center_y - velocity;
			endcase
		end
	end
endmodule
