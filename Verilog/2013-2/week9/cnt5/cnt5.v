///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 5-Way Counter
//FILE : cnt5.v
//TESTBENCH : tb_cnt5.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 5-Way Counter
//LAST UPDATE : Nov. 06, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module cnt5(cnt, clk, reset_n, inc); //Module of 5-Way Counter
	input clk,reset_n,inc; //clk : clock pulse; //reset_n : reset switch; //inc : increase
	output [2:0] cnt; //output value
	parameter zero = 3'b000; //state zero 
	parameter one = 3'b001; //state one 
	parameter two = 3'b010; //state two
	parameter three = 3'b011; //state three
	parameter four = 3'b100; //state four
	
	//Sequential circuit part
	reg [2:0] cnt; //current state
	reg [2:0] next_cnt; //next state
	
	always @ (posedge clk or negedge reset_n) //posedge clk, negedge reset_n
	begin
		if(reset_n == 1'b0) cnt<=zero; //reset
		else cnt<=next_cnt; //count
	end //end of always

	//Combinational circuit part
	always @ (inc or cnt) //increse, count
	begin
		case({cnt,inc})
		{zero,1'b0} : next_cnt<=four;
		{zero,1'b1} : next_cnt<=one;
		{one,1'b0} : next_cnt<=zero;
		{one,1'b1} : next_cnt<=two;
		{two,1'b0} : next_cnt<=one;
		{two,1'b1} : next_cnt<=three;
		{three,1'b0} : next_cnt<=two;
		{three,1'b1} : next_cnt<=four;
		{four,1'b0} : next_cnt<=three;
		{four,1'b1} : next_cnt<=zero;
		default : next_cnt <= 3'bx;
		endcase //end case
	end //end of always
endmodule //End of module