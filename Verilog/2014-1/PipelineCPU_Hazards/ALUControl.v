////////////////////////////////////////////////////////////////
//	TITLE : ALU Control
//	FILE : ALUControl.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering
//	STUDENT ID : 2010720092, 2010720117
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim		
//	PLATFORM : Windows 7
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines ALU Control.	
//								Use casex function, insert each signal.
//	LAST UPDATE : 05.14, 2014
////////////////////////////////////////////////////////////////

module ALUControl(funct,ALUOp,ALU_control_signal);
	input [5:0] funct;
	input [1:0] ALUOp;
	output reg [3:0] ALU_control_signal;
	
	// Use casex function, find each control signal.
	always@(funct or ALUOp)
	begin
	casex({funct,ALUOp})
		{6'bxxxxxx,2'b00} : ALU_control_signal<=4'b0010; // LW/SW
		{6'bxxxxxx,2'b01} : ALU_control_signal<=4'b0110; // Branch

		// R_type
		{6'b100000,2'b10} : ALU_control_signal<=4'b0010; // ADD
		{6'b100010,2'b10} : ALU_control_signal<=4'b0110; // SUB
		{6'b100100,2'b10} : ALU_control_signal<=4'b0000; // AND
		{6'b100101,2'b10} : ALU_control_signal<=4'b0001; // OR
		{6'b101010,2'b10} : ALU_control_signal<=4'b0111; // SLT
		{6'b100111,2'b10} : ALU_control_signal<=4'b1100; // NOR

		{6'b000000,2'b10} : ALU_control_signal<=4'b1000; // SLL
		{6'b000010,2'b10} : ALU_control_signal<=4'b1001; // SRL
		{6'b000011,2'b10} : ALU_control_signal<=4'b1010; // SRA
		default : ALU_control_signal<=4'bxxxx;
	endcase
	end

endmodule //end of module