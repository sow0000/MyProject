`timescale 1ns/100ps

module tb_shifter8;
	reg tb_clk, tb_reset_n;
	reg [2:0] tb_op;
	reg [1:0] tb_shamt;
	reg [7:0] tb_d_in;
	wire [7:0] tb_d_out;
 
	parameter NOP=3'b000;
	parameter LOAD=3'b001;
	parameter LSL=3'b010;
	parameter LSR=3'b011;
	parameter ASR=3'b100;
	parameter STEP=10;
 
	shifter8 U0_shifter8(.clk(tb_clk), .reset_n(tb_reset_n), .op(tb_op), .shamt(tb_shamt), .d_in(tb_d_in), .d_out(tb_d_out));
 
	always#(STEP/2) tb_clk = ~tb_clk;
 
	initial
	begin
		tb_clk = 1; tb_reset_n = 0; tb_op=NOP; tb_shamt=2'b00; tb_d_in=8'b00000000;
		#(STEP-7) tb_reset_n = 1; 
		#(STEP) tb_op=LOAD; tb_d_in=8'b01110111; 
		#(STEP*2) tb_op=LSL;
		#(STEP*2) tb_shamt=2'b01; 
		#(STEP*3) tb_op=LSR; 
		#(STEP*2) tb_op=LOAD; tb_d_in=8'b10000111; tb_shamt=2'b11; 
		#(STEP*3) tb_op=ASR; tb_shamt=2'b01;
		#(STEP*3) tb_shamt=2'b11; 
		#(STEP*2) tb_reset_n = 0; 
		#(STEP) $stop;
	end
endmodule //End of module