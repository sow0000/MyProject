`timescale 1ns/100ps

module tb_cntr8;
	reg CLOCK,RESETn,INC,LOAD;
	reg [7:0] DATA_IN;
	wire [7:0] DATA_OUT;
	wire [2:0] vSTATE;
	
	parameter STEP=10;
	
	cntr8 U0_cntr8(.clk(CLOCK),.reset_n(RESETn),.inc(INC),.load(LOAD),.d_in(DATA_IN),.d_out(DATA_OUT),.o_state(vSTATE));
	
	always#(STEP/2) CLOCK=~CLOCK;
	
	initial
	begin
		CLOCK=1; RESETn=0; INC=0; LOAD=0; DATA_IN=8'h00;
		#(STEP*3-7) RESETn=1; INC=1;
		#(STEP*5) INC=0;
		#(STEP*5) LOAD=1; DATA_IN=8'h44;
		#(STEP*2) INC=1; LOAD=0; DATA_IN=8'h00;
		#(STEP*4) RESETn=0; INC=0;
		#(STEP) RESETn=1;
		#(STEP*4) $stop;
	end
endmodule //End of module