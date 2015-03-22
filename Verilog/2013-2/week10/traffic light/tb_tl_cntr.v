`timescale 1ns/100ps

module tb_tl_cntr;
	reg CLOCK,RESETn,tb_Ta,tb_Tb;
	wire [1:0] tb_La;
	wire [1:0] tb_Lb;
	
	parameter STEP=10;
	
	tl_cntr U0_tl_cntr(.clk(CLOCK),.reset_n(RESETn),.Ta(tb_Ta),.Tb(tb_Tb),.La(tb_La),.Lb(tb_Lb));
	
	always#(STEP/2) CLOCK=~CLOCK;
	
	initial
	begin
		CLOCK=1; RESETn=0; tb_Ta=0; tb_Tb=0;
		#(STEP) RESETn=1;
		#(STEP*5) tb_Ta=1;
		#(STEP*5) tb_Ta=0; tb_Tb=1;
		#(STEP*2) tb_Ta=1;
		#(STEP*3) tb_Tb=0;
		#(STEP*3) tb_Ta=0;
		#(STEP*4) $stop;
	end
	
endmodule //End of module