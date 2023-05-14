`timescale 10ms / 1ms

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   05:54:01 05/07/2023
// Design Name:   elevatorc1
// Module Name:   /home/ise/Documents/ec1/elevatorn1/elevatorc1_tb.v
// Project Name:  elevatorn1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: elevatorc1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module elevator_tb;

	// Inputs
	reg [3:0] move_up_call;
	reg [3:0] move_down_call;
	reg [3:0] req_floor;
	reg clk;
	reg rst;
	reg over_weight;
	reg open_door;
	reg close_door;

	// Outputs
	wire [1:0] current_floor;
	wire [1:0] direction;
	wire door_state;
	wire over_weight_alert;

	// Instantiate the Unit Under Test (UUT)
	elevator uut (
		.move_up_call(move_up_call), 
		.move_down_call(move_down_call), 
		.req_floor(req_floor), 
		.clk(clk), 
		.rst(rst), 
		.over_weight(over_weight), 
		.open_door(open_door), 
		.close_door(close_door), 
		.current_floor(current_floor), 
		.direction(direction), 
		.door_state(door_state), 
		.over_weight_alert(over_weight_alert)
	);

	initial begin
		// Initialize Inputs
		move_up_call = 0;
		move_down_call = 0;
		req_floor = 0;
		clk = 0;
		rst = 0;
		over_weight = 0;
		open_door = 0;
		close_door = 0;

				// Wait 100 ns for global reset to finish
/*				
		#500;move_down_call = 4'b1000;
		#100;move_up_call = 4'b0100;
		#100;move_down_call = 4'b0010;
		#100;move_down_call = 4'b0100;
		#100;move_up_call = 4'b0010;
		#100;move_up_call = 4'b0010;
		#100;move_up_call = 4'b0001;
*/

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

