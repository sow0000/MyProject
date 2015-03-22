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
	input i_clk, MemRead, MemWrite;
	input [31:0] i_addr, i_data;
	output reg [31:0] o_data;

	reg [7:0]	data_mem[2047:0]; // Data Memory

	initial begin
		$readmemb("data.txt", data_mem);
	end // initialize memory for data.txt

	// Write Memory Part
	always @ (posedge i_clk)
	begin
		if(MemWrite == 1'b1 && MemRead == 1'b0) // if Write Signal is ON,
		begin
			data_mem[i_addr][7:0] <= i_data[31:24];
			data_mem[i_addr+1][7:0] <= i_data[23:16];
			data_mem[i_addr+2][7:0] <= i_data[15:8];
			data_mem[i_addr+3][7:0]	 <= i_data[7:0];
		end // Insert a input data to Memory.
		else ;
	end

	// Read Memory Part
	always @ (*)
	begin
		if(MemRead == 1'b1 && MemWrite == 1'b0) // if Read Signal is ON,
		begin
			o_data[7:0] <= data_mem[i_addr+3][7:0];	
			o_data[15:8] <= data_mem[i_addr+2][7:0];
			o_data[23:16] <= data_mem[i_addr+1][7:0];
			o_data[31:24] <= data_mem[i_addr][7:0];
		end // Output is memory by address.
		else if(MemRead == 1'b0 && MemWrite == 1'b0)
			o_data <= 32'h0000_0000;
	end
	
endmodule
