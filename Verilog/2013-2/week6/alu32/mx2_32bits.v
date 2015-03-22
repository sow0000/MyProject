///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 32-bit 2-to-1 multiplexer
//FILE : mx2_32bits.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 32-bit 2-to-1 Multiplexer.
//LAST UPDATE : Oct. 15, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module mx2_32bits(d0, d1, s, y); //Module of 32-bit 2-to-1 Multiplexer.
	input [31:0] d0, d1; //32-bit input
	input s; //selection
	output [31:0] y; //32-bit output data
	
	assign y = (s == 0) ? d0 : d1; //if s is 0, output d0 or not, output d1
endmodule //End of module