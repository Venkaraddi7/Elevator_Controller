`timescale 10ms / 1ms


////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:14:29 05/10/2023
// Design Name:   elevator_cont_Machine
// Module Name:   /home/ise/Documents/ec1/elevatorn1/elevator_cont_Machine_tb.v
// Project Name:  elevatorn1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: elevator_cont_Machine
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module elevator_cont_Machine_tb;

	// Inputs
	reg [3:0] move_up_call;
	reg [3:0] move_down_call;
	reg [3:0] req_floor;
	reg clk;
	reg rst;
	reg open_door;
	reg close_door;
	reg over_weight;

	// Outputs
	wire door_state;
	wire over_weight_alert;
	wire [7:0] disp;
	wire [3:0] q;

	// Instantiate the Unit Under Test (UUT)
	elevator_cont_Machine uut (
		.move_up_call(move_up_call), 
		.move_down_call(move_down_call), 
		.req_floor(req_floor), 
		.clk(clk), 
		.rst(rst), 
		.open_door(open_door), 
		.close_door(close_door), 
		.over_weight(over_weight), 
		.door_state(door_state), 
		.over_weight_alert(over_weight_alert), 
		.disp(disp), 
		.q(q)
	);

	initial begin
		// Initialize Inputs
		move_up_call = 0;
		move_down_call = 0;
		req_floor = 0;
		clk = 0;
		rst = 0;
		open_door = 0;
		close_door = 0;
		over_weight = 0;



		#500;move_down_call = 4'b1000;//3
		
		#100;move_up_call = 4'b0100;//2

		#400;req_floor = 4'b0010;//1
		#50;req_floor = 4'b0001;//0

		#1400;open_door = 1;
		#200;open_door =0;

		#650;close_door = 1;
		#100;close_door = 0;

		#50;req_floor = 4'b1000;//3
		#750;over_weight = 1;
		#300;over_weight = 0;
		// Add stimulus here

	end
       always #5 clk=~clk;
endmodule

