//IF_ID Register
module R_IF_ID(i_clk,i_rst_n,i_next_pc,i_data,o_next_pc,o_data);
	input i_clk,i_rst_n;
	input [31:0] i_next_pc,i_data;
	output reg [31:0] o_next_pc,o_data;
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_next_pc <= 32'b0;
		else o_next_pc <= i_next_pc;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_data <= 32'b0;
		else o_data <= i_data;
	end
	
endmodule //End of module

//ID_EX Register
module R_ID_EX(i_clk,i_rst_n,i_next_pc,i_read_data1,i_read_data2,i_imm,i_tar_reg,i_des_reg,i_WB_control,i_MEM_control,i_EX_control,o_next_pc,o_read_data1,o_read_data2,o_imm,o_tar_reg,o_des_reg,o_WB_control,o_MEM_control,o_EX_control);
	input i_clk,i_rst_n;
	input [1:0] i_WB_control;
	input [2:0] i_MEM_control;
	input [3:0] i_EX_control;
	input [4:0] i_tar_reg,i_des_reg;
	input [31:0] i_next_pc,i_read_data1,i_read_data2,i_imm;
	output reg [1:0] o_WB_control;
	output reg [2:0] o_MEM_control;
	output reg [3:0] o_EX_control;
	output reg [4:0] o_tar_reg,o_des_reg;
	output reg [31:0] o_next_pc,o_read_data1,o_read_data2,o_imm;
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_WB_control <= 2'b0;
		else o_WB_control <= i_WB_control;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_MEM_control <= 3'b0;
		else o_MEM_control <= i_MEM_control;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_EX_control <= 4'b0;
		else o_EX_control <= i_EX_control;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_tar_reg <= 5'b0;
		else o_tar_reg <= i_tar_reg;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_des_reg <= 5'b0;
		else o_des_reg <= i_des_reg;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_next_pc <= 32'b0;
		else o_next_pc <= i_next_pc;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_read_data1 <= 32'b0;
		else o_read_data1 <= i_read_data1;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_read_data2 <= 32'b0;
		else o_read_data2 <= i_read_data2;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_imm <= 32'b0;
		else o_imm <= i_imm;
	end
	
endmodule //End of module
	
//EX_MEM Register
module R_EX_MEM(i_clk,i_rst_n,i_branch_pc,i_result,i_zero,i_read_data2,i_write_reg,i_WB_control,i_MEM_control,o_branch_pc,o_result,o_zero,o_read_data2,o_write_reg,o_WB_control,o_MEM_control);
	input i_clk,i_rst_n,i_zero;
	input [1:0] i_WB_control;
	input [2:0] i_MEM_control;
	input [4:0] i_write_reg;
	input [31:0] i_branch_pc,i_result,i_read_data2;
	output reg o_zero;
	output reg [1:0] o_WB_control;
	output reg [2:0] o_MEM_control;
	output reg [4:0] o_write_reg;
	output reg [31:0] o_branch_pc,o_result,o_read_data2;
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_zero <= 1'b0;
		else o_zero <= i_zero;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_WB_control <= 2'b0;
		else o_WB_control <= i_WB_control;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_MEM_control <= 3'b0;
		else o_MEM_control <= i_MEM_control;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_write_reg <= 5'b0;
		else o_write_reg <= i_write_reg;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_branch_pc <= 32'b0;
		else o_branch_pc <= i_branch_pc;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_result <= 32'b0;
		else o_result <= i_result;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_read_data2 <= 32'b0;
		else o_read_data2 <= i_read_data2;
	end

endmodule //End of module

//MEM_WB Register
module R_MEM_WB(i_clk,i_rst_n,i_write_reg,i_write_data,i_result,i_WB_control,o_write_reg,o_write_data,o_result,o_WB_control);
	input i_clk,i_rst_n;
	input [1:0] i_WB_control;
	input [4:0] i_write_reg;
	input [31:0] i_write_data,i_result;
	output reg [1:0] o_WB_control;
	output reg [4:0] o_write_reg;
	output reg [31:0] o_write_data,o_result;

	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_WB_control <= 2'b0;
		else o_WB_control <= i_WB_control;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_write_reg <= 5'b0;
		else o_write_reg <= i_write_reg;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_write_data <= 32'b0;
		else o_write_data <= i_write_data;
	end
	
	always@(posedge i_clk or negedge i_rst_n) begin
		if(i_rst_n==0) o_result <= 32'b0;
		else o_result <= i_result;
	end
	
endmodule //End of module