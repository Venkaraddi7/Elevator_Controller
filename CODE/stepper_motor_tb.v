`timescale 10ms / 1ms

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:06:06 05/07/2023
// Design Name:   stepper_motor
// Module Name:   /home/ise/Documents/ec1/elevatorn1/stepper_motor_tb.v
// Project Name:  elevatorn1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: stepper_motor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module stepper_motor_tb;

	// Inputs
	reg clk;
	reg [1:0] direction;


	// Outputs
	wire [3:0] q;

	// Instantiate the Unit Under Test (UUT)
	stepper_motor uut (
		.clk(clk), 
		.direction(direction), 
		.q(q)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		direction = 2;

		// Wait 100 ns for global reset to finish
		#100;direction = 3;
		#300;direction = 2;
		

        
		// Add stimulus here

	end
      always #5 clk=~clk;
endmodule

