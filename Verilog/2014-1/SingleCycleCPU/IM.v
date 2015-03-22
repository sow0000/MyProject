////////////////////////////////////////////////////////////////
//	TITLE : Instruction memory
//	FILE : IM.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering	
//	STUDENT ID : 2010720092, 2010720117	
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim	
//	PLATFORM : Windows 7	
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines Instruction memory.	
//								Save machinecode and find instruction.
//	LAST UPDATE : 04.07, 2014	
////////////////////////////////////////////////////////////////
module IM(i_addr, o_instr);
	input [31:0] i_addr;
	output reg [31:0] o_instr;
	
	reg [7:0] inst_mem[2047:0]; // instruction Memory

	initial begin
		$readmemb("machinecode.txt", inst_mem);
	end // initialize memory for machinecode.txt

	always @ (i_addr)
	begin
		o_instr[31:24] <= inst_mem[i_addr][7:0];
		o_instr[23:16] <= inst_mem[i_addr+1][7:0];
		o_instr[15:8] <= inst_mem[i_addr+2][7:0];
		o_instr[7:0] <= inst_mem[i_addr+3][7:0]; // find instruction by input address.
	end
	
endmodule
