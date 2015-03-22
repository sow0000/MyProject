////////////////////////////////////////////////////////////////
//	TITLE : Data Memory
//	FILE : DM.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering	
//	STUDENT ID : 2010720092, 2010720117	
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim	
//	PLATFORM : Windows 7	
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines Data Memory.	
//								Read or Write for each memory.
//	LAST UPDATE : 04.07, 2014	
////////////////////////////////////////////////////////////////
module DM(i_clk,MemRead,MemWrite,i_addr,i_data,o_data);
	input i_clk,MemRead,MemWrite;
	input [31:0] i_addr,i_data;
	output reg [31:0] o_data;

endmodule
