////////////////////////////////////////////////////////////////
//	TITLE : Write Back
//	FILE : WB.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering	
//	STUDENT ID : 2010720092, 2010720117	
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim	
//	PLATFORM : Windows 7	
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines Write Back.	
//								Use 2to1 MUX module.
//	LAST UPDATE : 05.19, 2014	
////////////////////////////////////////////////////////////////

module WB(i_clk,i_rst_n,i_write_reg,i_write_data,i_result,i_WB_control,o_write_reg,o_write_data,o_RegWrite);
	input i_clk,i_rst_n;
	input [1:0] i_WB_control;
	input [4:0] i_write_reg;
	input [31:0] i_write_data,i_result;
	output o_RegWrite;
	output [4:0] o_write_reg;
	output [31:0] o_write_data;
	
	assign o_RegWrite=i_WB_control[0];
	assign o_write_reg=i_write_reg;
	
	MUX2_1		U4_MUX_data(.i_data1(i_result),.i_data2(i_write_data),.sel(i_WB_control[1]),.o_data(o_write_data)); // 2to1 MUX
	
endmodule //End of module