///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 32-bit Register
//FILE : _register32_r.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 32-bit Register
//LAST UPDATE : Nov. 29, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module _register32_r(clk,reset_n,d,q); //Module of 32-bit Register
	input clk,reset_n; //clock pulse
	input [31:0] d; //3-bit input
	output [31:0] q; //3-bit output
	
	_register8_r U0_register8_r(.clk(clk),.reset_n(reset_n),.d(d[7:0]),.q(q[7:0])); //save input
	_register8_r U1_register8_r(.clk(clk),.reset_n(reset_n),.d(d[15:8]),.q(q[15:8]));
	_register8_r U2_register8_r(.clk(clk),.reset_n(reset_n),.d(d[23:16]),.q(q[23:16]));
	_register8_r U3_register8_r(.clk(clk),.reset_n(reset_n),.d(d[31:24]),.q(q[31:24]));

endmodule //End of module

//8-bit Register
module _register8_r(clk,reset_n,d,q);
	input clk,reset_n; //clock pulse
	input [7:0] d; //3-bit input
	output [7:0] q; //3-bit output
	
	_dff_r U0_dff_r(.clk(clk),.reset_n(reset_n),.d(d[0]),.q(q[0])); //save input
	_dff_r U1_dff_r(.clk(clk),.reset_n(reset_n),.d(d[1]),.q(q[1]));
	_dff_r U2_dff_r(.clk(clk),.reset_n(reset_n),.d(d[2]),.q(q[2]));
	_dff_r U3_dff_r(.clk(clk),.reset_n(reset_n),.d(d[3]),.q(q[3]));
	_dff_r U4_dff_r(.clk(clk),.reset_n(reset_n),.d(d[4]),.q(q[4]));
	_dff_r U5_dff_r(.clk(clk),.reset_n(reset_n),.d(d[5]),.q(q[5]));
	_dff_r U6_dff_r(.clk(clk),.reset_n(reset_n),.d(d[6]),.q(q[6]));
	_dff_r U7_dff_r(.clk(clk),.reset_n(reset_n),.d(d[7]),.q(q[7]));

endmodule //End of module

//3-bit Register
module _register3_r(clk,reset_n,d,q);
	input clk,reset_n; //clock pulse
	input [2:0] d; //3-bit input
	output [2:0] q; //3-bit output
	
	_dff_r U0_dff_r(.clk(clk),.reset_n(reset_n),.d(d[0]),.q(q[0])); //save input
	_dff_r U1_dff_r(.clk(clk),.reset_n(reset_n),.d(d[1]),.q(q[1]));
	_dff_r U2_dff_r(.clk(clk),.reset_n(reset_n),.d(d[2]),.q(q[2]));

endmodule //End of module

//2-bit Register
module _register2_r(clk,reset_n,d,q);
	input clk,reset_n; //clock pulse
	input [1:0] d; //3-bit input
	output [1:0] q; //3-bit output
	
	_dff_r U0_dff_r(.clk(clk),.reset_n(reset_n),.d(d[0]),.q(q[0])); //save input
	_dff_r U1_dff_r(.clk(clk),.reset_n(reset_n),.d(d[1]),.q(q[1]));

endmodule //End of module

//Resettable D flip-flop
module _dff_r(clk,reset_n,d,q); 
	input clk,reset_n,d; //clk=clock pulse; //d=input; //reset_n=reset switch
	output reg q; //output
	
	always@(posedge clk or negedge reset_n)
	begin
		if(reset_n==0) q <= 1'b0;
		else q <= d;
	end
endmodule //End of module