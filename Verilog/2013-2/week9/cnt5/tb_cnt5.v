`timescale 1ns/100ps

module tb_cnt5; //Module of tb_cnt5
	reg tb_clk,tb_reset_n,tb_inc;
	wire [2:0] tb_cnt;
	
	parameter STEP=10; //10ns parameter
	
	//5-Way Counter
	cnt5 U0_cnt5(.cnt(tb_cnt), .clk(tb_clk), .reset_n(tb_reset_n), .inc(tb_inc));
	
	always#(STEP/2) tb_clk=~tb_clk;
  
	initial
	begin
		tb_clk=1; 
		#(STEP) tb_reset_n = 0; tb_inc = 1;
		#(STEP) tb_reset_n =1;
		#(STEP*6) tb_reset_n =0;
		#(STEP-2) tb_reset_n =1; tb_inc = 0;
		#(STEP*5+2) $stop;
	end
endmodule