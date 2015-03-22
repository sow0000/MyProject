`timescale 1ns/100ps

module tb_blocking_and_nonblocking;
	reg clock, tb_a;
	wire tb_b, tb_c, tb_d, tb_e;
	
	parameter STEP=10;
	
	blocking_and_nonblocking U0_blocking_and_nonblocking(.clk(clock), .a(tb_a), .b(tb_b), .c(tb_c), .d(tb_d), .e(tb_e));
	
	always#(STEP/2) clock=~clock;

	initial
	begin
		clock=1'b1; tb_a=1'b0;
		#(STEP-2); tb_a=1'b1;
		#(STEP); tb_a=1'b0;
		#(STEP); tb_a=1'b0;
		#(STEP); tb_a=1'b1;
		#(STEP); tb_a=1'b1;
		#(STEP); tb_a=1'b0;
		#(STEP); $stop;
	end
endmodule