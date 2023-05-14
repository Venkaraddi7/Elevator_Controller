`timescale 10ms / 1ms

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:01:28 05/10/2023 
// Design Name: 
// Module Name:    elevator_cont_Machine 
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
module elevator_cont_Machine(
  input [3:0]move_up_call,
  input [3:0]move_down_call,

  input [3:0]req_floor,
  input clk,
  input rst,
  input open_door,
  input close_door,
  input over_weight,// if wight grater than 4500 lbs in lift then 1 or if not then 0 
 
  //output reg [1:0] current_floor;
  //output reg [1:0] direction;
  output  door_state,// if 0 then door is closed  or 1 is to open door
  output  over_weight_alert,
  output  [7:0] disp,
  output  [3:0] q
  );
  
   wire [1:0] wire_current_floor;
	wire [1:0] wire_direction;

	elevator ec1 (
		.move_up_call(move_up_call), 
		.move_down_call(move_down_call), 
		.req_floor(req_floor), 
		.clk(clk), 
		.rst(rst), 
		.over_weight(over_weight), 
		.open_door(open_door), 
		.close_door(close_door), 
		.current_floor(wire_current_floor), 
		.direction(wire_direction), 
		.door_state(door_state), 
		.over_weight_alert(over_weight_alert)
	);

	stepper_motor sm1 (
		.clk(clk),
		.direction(wire_direction),
		.q(q)
	);
	
   seven_seg_disp ssd1 (
		.clk(clk),
		.current_floor(wire_current_floor),
		.disp(disp)
	);

endmodule
