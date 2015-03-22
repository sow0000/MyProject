////////////////////////////////////////////////////////////////
//	TITLE : Register
//	FILE : REG.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering	
//	STUDENT ID : 2010720092, 2010720117	
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim	
//	PLATFORM : Windows 7	
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines each Register.
//								IR, MDR, A, ALUOut, 32 bit Register.
//	LAST UPDATE : 04.28, 2014	
////////////////////////////////////////////////////////////////
module IR(i_clk,IRWrite,i_Instr,o_op,o_rs,o_rt,o_Imm16);
	input i_clk,IRWrite;
	input [31:0] i_Instr;
	output reg [5:0] o_op;
	output reg [4:0] o_rs,o_rt;
	output reg [15:0] o_Imm16;
	
	initial begin
		o_op <= 6'b0;
		o_rs <= 5'b0;
		o_rt <= 5'b0;
		o_Imm16 <= 16'b0;
	end // initialize to zero
	
	always@(posedge i_clk) begin
	if(IRWrite == 1) // if Write Signal is ON,
	begin
		o_op <= i_Instr[31:26];
		o_rs <= i_Instr[25:21];
		o_rt <= i_Instr[20:16];
		o_Imm16 <= i_Instr[15:0];
	end
	end
	
endmodule //End of module

module MDR(i_clk,i_data,o_data);
	input i_clk;
	input [31:0] i_data;
	output reg [31:0] o_data; // 32 bit output register
	
	initial begin
		o_data <= 32'b0;
	end // initialize to zero
	
	always@(posedge i_clk) begin
		o_data <= i_data;
	end
	
endmodule //End of module

module A(i_clk,i_x,o_y);
	input i_clk;
	input [31:0] i_x;
	output reg [31:0] o_y; // 32 bit output register
	
	initial begin
		o_y <= 32'b0;
	end // initialize to zero
	
	always@(posedge i_clk) begin
		o_y <= i_x;
	end
	
endmodule //End of module

module ALUOut(i_clk,i_alu_result,o_alu_out);
	input i_clk;
	input [31:0] i_alu_result;
	output reg [31:0]	o_alu_out; // 32 bit output register

	initial begin
		o_alu_out <= 32'b0;
	end // initialize to zero
	
	always@(posedge i_clk) begin
		o_alu_out <= i_alu_result;
	end
	
endmodule //End of module

//Module of 32-bit Register
module _register32(clk,reset_n,en,d,q);
	input clk,reset_n,en; //clock pulse
	input [31:0] d; //32-bit input
	output reg [31:0] q; //32-bit output
	
	always@(posedge clk or negedge reset_n)
	begin
		if(reset_n==0) q <= 32'b0;
		else if(en==1) q <= d;
	end
	
endmodule //End of module