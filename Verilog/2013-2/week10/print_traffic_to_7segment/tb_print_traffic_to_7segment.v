`timescale 1ns/100ps

module tb_print_traffic_to_7segment;
	reg CLOCK,RESETn,tb_Ta,tb_Tb;
	wire [27:0] tb_dec_out;
	
	parameter STEP=10;
	
	print_traffic_to_7segment U0_print_traffic_to_7segment(.clk(CLOCK),.reset_n(RESETn),.Ta(tb_Ta),.Tb(tb_Tb),.dec_out(tb_dec_out));
	
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