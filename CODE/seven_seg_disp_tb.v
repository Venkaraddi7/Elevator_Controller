`timescale 10ms / 1ms

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:17:00 05/10/2023
// Design Name:   seven_seg_disp
// Module Name:   /home/ise/Documents/ec1/elevatorn1/seven_seg_disp_tb.v
// Project Name:  elevatorn1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: seven_seg_disp
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module seven_seg_disp_tb;

	// Inputs
	reg clk;
	reg [1:0] current_floor;

	// Outputs
	wire [7:0] disp;

	// Instantiate the Unit Under Test (UUT)
	seven_seg_disp uut (
		.clk(clk), 
		.current_floor(current_floor), 
		.disp(disp)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		current_floor = 0;

		// Wait 100 ns for global reset to finish
		#1000;current_floor = 1;
		#1000;current_floor = 0;
		#1000;current_floor = 3;
		#1000;current_floor = 2;

        
		// Add stimulus here

	end
      
endmodule

