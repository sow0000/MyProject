module IF(i_clk,i_rst_n,i_PCSrc,i_branch_addr,o_next_pc,o_data);
	input i_clk,i_rst_n,i_PCSrc;
	input [31:0] i_branch_addr;
	output [31:0] o_next_pc,o_data;
	
	wire [31:0] w_pc,w_ADD_pc,w_next_pc,w_data;
	
	PC				U0_PC(.i_next_pc(w_next_pc),.o_pc(w_pc),.i_rst_n(i_rst_n),.i_clk(i_clk)); // Program Counter
	IM				U1_IM(.i_addr(w_pc),.o_instr(w_data)); // Instruction Memory
	R_IF_ID		U2_IF_ID(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_next_pc(w_pc),.i_data(w_data),.o_next_pc(o_next_pc),.o_data(o_data));
	ADD			U3_ADD_PC(.i_data1(w_pc),.i_data2(32'h0000_0004),.o_sum(w_ADD_pc)); // Adder for Program Counter
	MUX2_1		U4_MUX2_1(.i_data1(w_ADD_pc),.i_data2(i_branch_addr),.sel(i_PCSrc),.o_data(w_next_pc));
	
endmodule //End of module