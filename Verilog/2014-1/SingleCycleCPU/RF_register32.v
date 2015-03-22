///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 32-bit resettable Register
//FILE : RF_register32.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//DESCRIPTION : This module defines 32-bit Register
//LAST UPDATE : Mar. 26, 2014
///////////////////////////////////////////////////////////////////////////////////////////////////

module _register32(clk,reset_n,en,d,q); //Module of 32-bit Register
	input clk,reset_n,en; //clock pulse
	input [31:0] d; //32-bit input
	output reg [31:0] q; //32-bit output
	
	always@(posedge clk or negedge reset_n)
	begin
		if(reset_n==0) q <= 32'b0;
		else if(en==1) q <= d;
	end
	
endmodule //End of module