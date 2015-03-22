///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Next State Logic
//FILE : ns_logic.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Next State Logic
//LAST UPDATE : Nov. 06, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module ns_logic(load,inc,state,next_state); //Module of Next State Logic
	input load, inc; //input switch
	input [2:0] state; //current state
	output [2:0] next_state; //next state

	reg [2:0] next_state; //register of next state
 
	parameter IDLE_STATE=3'b000; //Ideal state
	parameter LOAD_STATE=3'b001; //Load state
	parameter INC_STATE=3'b010; //Increase state
	parameter INC2_STATE=3'b011; //Increase state 2
	parameter DEC_STATE=3'b100; //Decrease state
	parameter DEC2_STATE=3'b101; //Decrease state 2
	
	always@(load,inc,state)
	begin
	case(state)
		IDLE_STATE  : //Ideal state
		begin
		casex({load,inc})
			{1'b0,1'b0} : next_state=3'b100;
			{1'b0,1'b1} : next_state=3'b010;
			{1'b1,1'bx} : next_state=3'b001;
			default  : next_state=3'bx;
		endcase
		end
 
		LOAD_STATE  : //Load state
		begin
		casex({load,inc})
			{1'b0,1'b0} : next_state=3'b100;
			{1'b0,1'b1} : next_state=3'b010;
			{1'b1,1'bx} : next_state=3'b001;
			default  : next_state=3'bx;
		endcase
		end
  
		INC_STATE : //Increase state
		begin
		casex({load,inc})
			{1'b0,1'b0} : next_state=3'b100;
			{1'b0,1'b1} : next_state=3'b011;
			{1'b1,1'bx} : next_state=3'b001;
			default  : next_state=3'bx;
		endcase
		end
  
		INC2_STATE  : //Increase state 2
		begin
		casex({load,inc})
			{1'b0,1'b0} : next_state=3'b100;
			{1'b0,1'b1} : next_state=3'b010;
			{1'b1,1'bx} : next_state=3'b001;
			default  : next_state=3'bx;
		endcase
		end
  
		DEC_STATE : //Decrease state
		begin
		casex({load,inc})
			{1'b0,1'b0} : next_state=3'b101;
			{1'b0,1'b1} : next_state=3'b010;
			{1'b1,1'bx} : next_state=3'b001;
			default  : next_state=3'bx;
		endcase
		end
  
		DEC2_STATE  : //Decrease state 2
		begin
		casex({load,inc})
			{1'b0,1'b0} : next_state=3'b100;
			{1'b0,1'b1} : next_state=3'b010;
			{1'b1,1'bx} : next_state=3'b001;
			default  : next_state=3'bx;
		endcase
		end
  
		default  :
		begin
		casex({load,inc})
			{1'b0,1'b0} : next_state=3'b100;
			{1'b0,1'b1} : next_state=3'b010;
			{1'b1,1'bx} : next_state=3'b001;
			default  : next_state=3'bx;
		endcase
		end
	endcase
	end
endmodule //End of module