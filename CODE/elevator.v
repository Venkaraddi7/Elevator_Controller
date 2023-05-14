`timescale 10ms / 1ms

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Venkaraddi Raddi
// 
// Create Date:    10:01:04 05/08/2023
// Design Name: 
// Module Name:    elevator controller design 
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


module elevator(
    move_up_call,move_down_call,req_floor,
    clk,rst,over_weight,open_door,close_door,
    current_floor, direction, door_state,over_weight_alert
    );
  //Floor call input is given to calls the elevator to come to a particular floor 
  input [3:0]move_up_call;//floor call to move upwards
  input [3:0]move_down_call;//floor call to move downwards
  input [3:0]req_floor;//floor request input is given when a passenger in the elevator requests to go to a specified floor. 
  input clk;
  input rst;
  input open_door;//To reopen the elevator doors and wait for extra time.
  input close_door;//To close door immediately when it's in open
  input over_weight;//Input by overload sensor, if wight grater than 750kg in lift then 1 or if not then 0 
 
  output reg [1:0] current_floor;//To display current floor of elevator
  output reg [1:0] direction;//Its input to dc/stepper motor to move
  output reg door_state;//It shows door state, if 0 then door is closed  or 1 is to open door
  output reg over_weight_alert;//To give overwight alert so 
  

  reg [1:0] next_floor;//This is used to assign next floor to be reachred from request's
  //these used to store inputs vales into array,which are used in process code 
  reg wire_open_door=0;
  reg wire_close_door=1;
  reg upflr_call_arr[3:0];
  reg downflr_call_arr[3:0];
  reg flr_req_arr[3:0];
  
  integer i,d=0,x=0,cf=0;
  reg st=0;//This is used to start/Initialize when number of requests are 0 to 1
  reg complete=1;//This variable is used to return scan block from functionality block when current floor is equal to next floor
  reg goto=0;//This variable is used to return functionality block from scan block when new value is assigned to next floor
  reg scan_direction=1;//It shows the direction of elevator moving in SCAN algorithm,If it's 1 then lift moves up after reaches top then it becomes 0 nd vice vrasa
  reg [3:0]req_count=0;//TO count total request's 
  reg d_c=0;//
  reg rpt=0;
  reg rpt1=0;

  parameter f0=2'b00, // it's for first floor
				f1=2'b01,// it's for second floor
				f2=2'b10,// it's for third floor
				f3=2'b11;// it's for fourth floor

  // direction of elevator motion 
  parameter move_up =2'b01,   // to move upwards 
				move_down=2'b10,// to move downwards
				stop = 2'b11;    // to stop 

  //door colsed or open state
  parameter open=1, //to open door
				close=0;//to close door

  
  initial 
    begin 
      current_floor = f0;
      for(i=0;i<4;i=i+1)
        begin
          upflr_call_arr[i]=0;
          downflr_call_arr[i]=0;
          flr_req_arr[i]=0;
        end
	   next_floor=f0;
      direction = stop;
      door_state = close;
      over_weight_alert=0;
    end


  //This block used to store requests inside arrys like
  //			move_up_call(input) --> upflr_call_arr(wire)
  always @( posedge move_up_call[0] or posedge move_up_call[1] or posedge move_up_call[2])
  begin
    if(move_up_call[0]==1 &  upflr_call_arr[0]==0)
    begin
        upflr_call_arr[0]=1;
		  req_count=req_count+1;
		   $display("upflr_call_arr[0] is %b ,total requests %d",upflr_call_arr[0],req_count);
    end

    if(move_up_call[1]==1 &  upflr_call_arr[1]==0)
    begin
        upflr_call_arr[1]=1;
		  req_count=req_count+1;
		   $display("upflr_call_arr[1] is %b ,total requests %d",upflr_call_arr[1],req_count);
    end

    if(move_up_call[2]==1 &  upflr_call_arr[2]==0)
    begin
        upflr_call_arr[2]=1;
		  req_count=req_count+1;
		   $display("upflr_call_arr[2] is %b ,total requests %d",upflr_call_arr[2],req_count);
    end
  end


  //This block used to store requests inside arrys like
  //			move_down_call(input) --> downflr_call_arr(wire)
  always @( posedge move_down_call[1] or posedge move_down_call[2] or posedge move_down_call[3])
  begin
    
    if(move_down_call[1]==1 &  downflr_call_arr[1]==0)
    begin
        downflr_call_arr[1]=1;
		  req_count=req_count+1;
		   $display("downflr_call_arr[1] is %b ,total requests %d",downflr_call_arr[1],req_count);
    end

    if(move_down_call[2]==1 &  downflr_call_arr[2]==0)
    begin
        downflr_call_arr[2]=1;
		  req_count=req_count+1;
		   $display("downflr_call_arr[2] is %b ,total requests %d",downflr_call_arr[2],req_count);
    end

    if(move_down_call[3]==1 &  downflr_call_arr[3]==0)
    begin
        downflr_call_arr[3]=1;
		  req_count=req_count+1;
		   $display("downflr_call_arr[3] is %b ,total requests %d",downflr_call_arr[3],req_count);
    end
  end


  //This block used to store requests inside arrys like
  //			req_floor(input) --> flr_req_arr(wire)
  always @( posedge req_floor[0] or posedge req_floor[1] or posedge req_floor[2] or posedge req_floor[3])
  begin
    if(req_floor[0]==1 &  flr_req_arr[0]==0)
    begin
        flr_req_arr[0]=1;
		  req_count=req_count+1;
		   $display("flr_req_arr[0] is %b ,total requests %d",flr_req_arr[0],req_count);
    end

    if(req_floor[1]==1 &  flr_req_arr[1]==0)
    begin
        flr_req_arr[1]=1;
		  req_count=req_count+1;
		   $display("flr_req_arr[1] is %b ,total requests %d",flr_req_arr[1],req_count);
    end

    if(req_floor[2]==1 &  flr_req_arr[2]==0)
    begin
        flr_req_arr[2]=1;
		  req_count=req_count+1;
		   $display("flr_req_arr[2] is %b ,total requests %d",flr_req_arr[2],req_count);
    end

    if(req_floor[3]==1 &  flr_req_arr[3]==0)
    begin
        flr_req_arr[3]=1;
		  req_count=req_count+1;
		   $display("flr_req_arr[3] is %b ,total requests %d",flr_req_arr[3],req_count);
    end
  end

  //When currrent floor and next floor are equal
  //This is uesd to store input to wire like open_door -- > wire_open_door
  always @(open_door)
  begin 
    wire_open_door=open_door;
  end
  
  //This uesd to store input to wire like close_door -- > wire_close_door
  always @(close_door)
  begin 
    wire_close_door=close_door;
  end
  
  //This block is to initiate SCAN block, when number of requests becom 1 from 0
  always@( req_count)
  begin
    if(req_count==0)
      st=0;
    else if(req_count==1 & st==0)
      st=1;
  end

 //This block is used to loop scan algorithm blook until requests become 0
 always @(posedge clk)
  begin 
  if(rpt==1)
  begin
    rpt=0;
	 if(req_count!=0)
    rpt1=1;
	end
  end

  //SCAN algorithm block
  always@( current_floor or posedge st or posedge complete or posedge rpt1)
  begin
    complete=0;
	 goto=0;
	 rpt1=0;
	 $display("entered always@(scan_direction or current_floor or posedge st or posedge completet) block ");
	 $display("	   befor entered scan_direction=%d ,, req_count =%d  condition block ",scan_direction,req_count );
      //scan_direction=1 mean's checking for requests avaiable from bottom floor to top floor 
		if((scan_direction==1) & (req_count!=0))
      begin
		$display("	entered if((scan_direction==1) & (req_count!=0)) condition block d_c= %d ",d_c);
		for(i=d_c?0:current_floor;i<=3 & x==0 ;i=i+1)
        begin
		  $display("		entered for(i=p;i<=3;i=i+1) loop block i=%d   ", i);
          if(upflr_call_arr[i]==1 | flr_req_arr[i]==1)//when any request is found then we can enter this block
          begin
			   if(i==0&current_floor==2'b01)
					d_c=0;
            else if(i!=0)
               d_c=0;
            next_floor=i;//Assiging value that to be reached next 
            $display("			entered if(upflr_call_arr[i]==1 | flr_req_arr[i]==1)  is %d ",i);
				x=1;//This is used to exit from for loop 
				goto=1;//This is used to shift to functionality block
          end
			 if(i==3)//After reaching (last)top floor,scan direction will change 1 to 0
			 begin
            scan_direction=0;
				d_c=1;
		    end
        end
		  x=0;
		  $display("at end of scan_direction==1 end ,  req_count %d",req_count);
      end
		
		//scan_direction=0 mean's checking for requests avaiable from top floor to bottom floor 
      if((scan_direction==0) & (req_count!=0))
      begin
		$display("	entered if((scan_direction==0) & (req_count!=0)) condition block d_c= %d ",d_c);		  for(i=d_c?3:current_floor;i>=0 & x==0;i=i-1)
        begin
		  $display("		entered for(i=p;i>=0;i=i-1) loop block i=%d   ,", i);
          if(downflr_call_arr[i]==1 | flr_req_arr[i]==1)//when any request is found then we can enter this block
          begin
            if(i==3&current_floor==2'b10)
			      d_c=0;
            else if(i!=3)
               d_c=0;
            next_floor=i;//Assiging value that to be reached next 
				$display("			entered if(upflr_call_arr[i]==1 | flr_req_arr[i]==1)  is %d ",i);
				x=1;//This is used to exit from for loop 
				goto=1;//This is used to shift to functionality block
          end
			 if(i==0)//After reaching (last)bottom floor,scan direction will change 0 to 1
			 begin
            scan_direction=1;
				d_c=1;
				$display("			dsdsdjfjsdjfhhdfsdfkfjfjsjkdjk ");
			 end
        end
		  x=0;
		  $display(" at end  of if scan_direction==0 end,  req_count %d goto ",req_count);
      end
		if(req_count!=0)//If requests count not equal to 0,then it'll loop and start  execte scan block agian
		begin
		$display("  agian repeat rpt=%d ",rpt);
		 rpt=1;
		$display("  agian repeat rpt=%d ",rpt);
		 end
    end
  
	 
	 //functionality block
	always @ (posedge goto or wire_open_door or wire_close_door or over_weight)
	begin
	 $display("        im inside  momevent function");
	 goto=0;
	 if(~over_weight)//if overweight is low then it'll start execute this block
    begin
	 over_weight_alert=0;
		if( next_floor == current_floor )//to chaeck next floor to be reach and current floor are equal 
		begin
			if(wire_open_door)//if there is any requests from user to reopen door and extent time(4 sec)
			  begin
				for(d=0;(d<20 & wire_close_door==0 );d=d+1)//If any close door requests it close door immediately
				begin
				  #20 direction=stop;
				  door_state=open;
				end
				wire_open_door=close;
				wire_close_door=close;
			   door_state=close;
			  end
			else
			  begin
				for(d=0;(d<20 & wire_close_door==0 & wire_open_door==0);d=d+1)//
				begin
					#15 direction=stop;
               door_state=open;
				end
			   //to extend time to open door 
				if(wire_open_door)//if there is any requests from user to reopen door and extent time(4 sec)
				begin
					for(d=0;(d<20);d=d+1)
					begin
						#20 direction=stop;
						door_state=open;
					end
					wire_open_door=close;
				end
				door_state=close;
				wire_close_door=close;
			   $display($time,"== current_floor is %b , direction %d ,door state %d  ",current_floor,direction,door_state);
				
				cf=current_floor;
				//these line use to reduce request count and to make request arrays from high to low
				if((scan_direction==1) & (req_count!=0)) 
				begin
				$display(" 1st scan_direction==1 upflr_call_arr[%d]==%d) & (flr_req_arr[%d]==%d)",cf,upflr_call_arr[cf],cf,flr_req_arr[cf]);
				  if((upflr_call_arr[cf]==1) & (flr_req_arr[cf]==1))//if both high then request count will reduce by 2
				    req_count=req_count-2;
				  else if((upflr_call_arr[cf]==1) | (flr_req_arr[cf]==1))//if any one high then request count will reduce by 1
					  req_count=req_count-1;
					//To make request array  value of current floor from high to low
					upflr_call_arr[cf]=0;
					flr_req_arr[cf]=0;
				$display(" 2nd scan_direction==1 upflr_call_arr[%d]==%d) & (flr_req_arr[%d]==%d)",cf,upflr_call_arr[cf],cf,flr_req_arr[cf]);
				end
				
				else if((scan_direction==0) & (req_count!=0)) 
				begin
				  if(downflr_call_arr[cf]==1 & flr_req_arr[cf]==1)//if both high then request count will reduce by 2
				    req_count=req_count-2;
				  else if(downflr_call_arr[cf]==1 | flr_req_arr[cf]==1)//if any one high then request count will reduce by 1
				    req_count=req_count-1;
					 //To make request array  value of current floor from high to low
				  downflr_call_arr[cf]=0;
              flr_req_arr[cf]=0;
				  $display("  scan_direction==0 downflr_call_arr[%d]==%d) & (flr_req_arr[%d]==%d)",i,downflr_call_arr[i],i,flr_req_arr[i]);
				end
				complete=1;//this use to shift execution to SCAN algorithm block after serving request
			end
		end
		
		else if ( next_floor>current_floor)//to chaeck next floor to be reach and current floor are grater ,then it will move upwords
		  begin	
			$display($time,"> current_floor is %b , direction %d ,door state %d  ",current_floor,direction,door_state);
			direction=move_up;
			door_state=close;
			// this dealy of 3 sec to  move from one floor to another floor
			#300  current_floor=current_floor+1;
			$display($time,"> current_floor is %b , direction %d ,door state %d  ",current_floor,direction,door_state);
		  end
			
		else if ( next_floor<current_floor)//to chaeck next floor to be reach and current floor are less ,then it will move downwords
		  begin
			$display($time,"< current_floor is %b , direction %d ,door state %d  ",current_floor,direction,door_state);
			direction=move_down;
			door_state=close;
			// this dealy of 3 sec to move from one floor to another floor
			#300 current_floor=current_floor-1;
			$display($time,"< current_floor is %b , direction %d ,door state %d  ",current_floor,direction,door_state);
		  end
	 end
	 else if( over_weight)//if overweight is high then it'll stop movement until it goes low ,overweight alert will be given  
	   begin
		 direction=stop;
		 door_state=open;
		 over_weight_alert=1;
	   end
	 $display($time,"             current_floor is %b , direction %d ,door state %d and next floor is %d ",current_floor,direction,door_state,next_floor);
	end
	
endmodule



