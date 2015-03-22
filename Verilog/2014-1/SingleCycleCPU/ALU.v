////////////////////////////////////////////////////////////////
//	TITLE : Arithmetic Logic Unit
//	FILE : ALU.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering	
//	STUDENT ID : 2010720092, 2010720117	
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim	
//	PLATFORM : Windows 7	
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines Arithmetic Logic Unit.	
//								This mudule have six Logic.
//	LAST UPDATE : 04.07, 2014	
////////////////////////////////////////////////////////////////
module ALU(i_data1, i_data2, ALUop, o_result, o_zero);
	input [31:0] i_data1, i_data2;
	input [3:0] ALUop;	
	output reg [31:0] o_result;
	output o_zero;

	wire [31:0] w_and, w_or, w_add, w_sub, w_slt, w_nor;

	// six parameters
	parameter AND = 4'b0000;
	parameter OR = 4'b0001;
	parameter ADD = 4'b0010;
	parameter SUB = 4'b0110;
	parameter SLT = 4'b0111;
	parameter NOR = 4'b1100;
	
	// Define each Logic
	assign w_and = i_data1&i_data2; // And Logic
	assign w_or = i_data1|i_data2; // OR Logic
	assign w_nor = ~(i_data1|i_data2); // NOR Logic
	assign w_slt = (i_data1<i_data2) ? 32'h0000_0001 : 32'h0000_0000; // Set on Less Than Logic
	assign o_zero = (o_result==32'b0) ? 1'b1 : 1'b0;  // if result is 0, Zero signal is ON
	
	cla32 U0_cla32(.a(i_data1),.b(i_data2),.ci(1'b0),.s(w_add)); // ADD Logic
	cla32 U1_cla32(.a(i_data1),.b(~i_data2),.ci(1'b1),.s(w_sub)); // SUB Logic
	
	// Check Op code, and insert a result
	always@(ALUop, w_and, w_or, w_add, w_sub, w_slt, w_nor)
		begin
		case(ALUop)
			AND	: o_result <= w_and;
			OR : o_result <= w_or;
			ADD : o_result <= w_add;
			SUB : o_result <= w_sub;
			SLT : o_result <= w_slt;
			NOR : o_result <= w_nor;
			default	: o_result <= 32'h00;
		endcase
		end

endmodule

