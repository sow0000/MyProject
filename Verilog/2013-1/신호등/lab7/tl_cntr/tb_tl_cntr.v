`timescale 1ns/100ps

module tb_tl_cntr();
	reg 		  clk;
	reg 		  tb_reset_n;
	reg 		  tb_Ta, tb_Tb;
	wire [1:0] tb_La, tb_Lb;
	
	parameter STEP = 10;
	
// Instance of Traffic Light Controller
	tl_cntr tb_tl_cntr(clk, tb_reset_n, tb_Ta, tb_Tb, tb_La, tb_Lb);
	
	always # (STEP/2) clk = ~clk;			// clock
	
	initial
	begin
	#0; 			clk=1; tb_reset_n=0; tb_Ta=0; tb_Tb=0;
	#(STEP-7);  tb_Ta=1;
	#(STEP);		tb_reset_n=1; tb_Ta=1;			// d = 00, q = 00
	#(STEP);		tb_Ta=0; tb_Tb=1;					// d = 01, q = 00
	#(STEP);		tb_Ta=0; tb_Tb=1;					// d = 10, q = 01
	#(STEP);		tb_Ta=0; tb_Tb=1;					// d = 10, q = 10
	#(STEP);		tb_Ta=1; tb_Tb=0;					// d = 11, q = 10
	#(STEP);		tb_Ta=1; tb_Tb=0;					// d = 00, q = 11
	#(STEP);		tb_Ta=1; tb_Tb=0;					// d = 00, q = 00
	#(STEP);		$finish;
	end
endmodule
