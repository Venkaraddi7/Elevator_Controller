`timescale 10ms / 1ms
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:53:55 05/07/2023 
// Design Name: 
// Module Name:    stepper_motor 
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


module stepper_motor( clk, direction, q);
 input clk;
 input [1:0] direction;
 output [3:0] q;
 
 reg [3:0]q=4'h3;
 reg [1:0]state=0; 
 
/*
  direction of elevator motion 
		move_up =  2'b01,   // to move upwards 
		move_down= 2'b10,// to move downwards
		stop =     2'b11;    // to stop
 */

 always@(posedge clk)
 begin
	
	if(direction==2'b01 | direction==2'b10)
	begin
		case(state)
			2'd0: begin
			if(direction==2'b01)
				q=4'h3;
			else
				q=4'h6;
			end
		2'd1: begin
			if(direction==2'b01)
				q= 4'h9;
			else
				q=4'hC;
			end
		2'd2: begin
			if(direction==2'b01)
				q=4'hC;
			else
				q=4'h9;
			end
		2'd3: begin
			if(direction==2'b01)
				q=4'h6;
			else
				q=4'h3;
			end
		endcase
		state=state+1;
	end
	else if(direction==2'b11)
	begin
		q=q;
	end
 end
endmodule
