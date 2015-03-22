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
//	LAST UPDATE : 05.14, 2014	
////////////////////////////////////////////////////////////////
module ALU(i_data1, i_data2, shamt, ALUop, o_result, o_zero);
	input [31:0] i_data1, i_data2;
	input [4:0] shamt;
	input [3:0] ALUop;	
	output reg [31:0] o_result;
	output o_zero;

	wire [31:0] w_and, w_or, w_add, w_sub, w_slt, w_nor, w_sll, w_srl, w_sra;

	// six parameters
	parameter AND = 4'b0000;
	parameter OR = 4'b0001;
	parameter ADD = 4'b0010;
	parameter SUB = 4'b0110;
	parameter SLT = 4'b0111;
	parameter NOR = 4'b1100;
	parameter SLL = 4'b1000;
	parameter SRL = 4'b1001;
	parameter SRA = 4'b1010;
	
	// Define each Logic
	assign w_and = i_data1&i_data2; // And Logic
	assign w_or = i_data1|i_data2; // OR Logic
	assign w_nor = ~(i_data1|i_data2); // NOR Logic
	assign w_slt = (i_data1<i_data2) ? 32'h0000_0001 : 32'h0000_0000; // Set on Less Than Logic
	assign w_sll = i_data2<<shamt; // SLL Logic
	assign w_srl = i_data2>>shamt; // SRL Logic
	
	assign o_zero = (o_result==32'b0) ? 1'b1 : 1'b0;  // if result is 0, Zero signal is ON

	cla32 U0_cla32(.a(i_data1),.b(i_data2),.ci(1'b0),.s(w_add)); // ADD Logic
	cla32 U1_cla32(.a(i_data1),.b(~i_data2),.ci(1'b1),.s(w_sub)); // SUB Logic
	ASR32 U2_ASR32(.d_in(i_data2), .shamt(shamt), .d_out(w_sra)); // SRA Logic
	
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
			SLL : o_result <= w_sll;
			SRL : o_result <= w_srl;
			SRA : o_result <= w_sra;
			default	: o_result <= 32'h00;
		endcase
		end

endmodule

// arithmetic shift right
module ASR32(d_in, shamt, d_out);
	input[31:0] d_in; // 32 bit input
	input[4:0] shamt; // how many shift
	output reg[31:0] d_out; // 32 bit output

	always@(*)
	begin
		case(shamt)
			5'b00000 : d_out <= d_in[31:0];
			5'b00001 : d_out <= {d_in[31],d_in[31:1]};
			5'b00010 : d_out <= {d_in[31],d_in[31],d_in[31:2]};
			5'b00011 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31:3]};
			5'b00100 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:4]};
			5'b00101 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:5]};
			5'b00110 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:6]};
			5'b00111 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:7]};
			5'b01000 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:8]};
			5'b01001 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:9]};
			5'b01010 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:10]};
			5'b01011 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:11]};
			5'b01100 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:12]};
			5'b01101 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:13]};
			5'b01110 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:14]};
			5'b01111 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:15]};
			5'b10000 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:16]};
			5'b10001 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:17]};
			5'b10010 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:18]};
			5'b10011 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:19]};
			5'b10100 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:20]};
			5'b10101 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:21]};
			5'b10110 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:22]};
			5'b10111 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:23]};
			5'b11000 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:24]};
			5'b11001 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:25]};
			5'b11010 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:26]};
			5'b11011 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:27]};
			5'b11100 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:28]};
			5'b11101 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:29]};
			5'b11110 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:30]};
			5'b11111 : d_out <= {d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31],d_in[31:31]};
			default : d_out <= 32'bx;
		endcase
	end

endmodule
