`timescale 1ns/100ps //time unit=1ns, precision=100ps

module tb_dff_rs_sync_async; //Module of tb_dff_rs_sync_async
	reg tb_clk,tb_set_n,tb_reset_n,tb_d; //tb_clk=clock pulse; //tb_set_n=set switch //tb_reset_n=reset switch; //tb_d=input value
	wire tb_q_sync,tb_q_async; //output value
 
	parameter STEP=10; //10ns parameter
	
	 //Sync/Async Set/Resettable D flip-flop
	_dff_rs_sync_async U0_dff_rs_sync_async(.clk(tb_clk),.set_n(tb_set_n),.reset_n(tb_reset_n),.d(tb_d),.q_sync(tb_q_sync),.q_async(tb_q_async));
 
	always#(STEP/2) tb_clk=~tb_clk; //100kHz clock pulse
 
	initial //initial
	begin
		tb_clk=0; tb_set_n=0; tb_reset_n=0; tb_d=0;
		#(STEP-7) tb_reset_n=1;
		#(STEP) tb_reset_n=0;
		#(STEP) tb_reset_n=1;
		#(STEP) tb_set_n=1;
		#(STEP) tb_set_n=0;
		#(STEP) tb_set_n=1;
		#(STEP) tb_reset_n=0;
		#(STEP) tb_reset_n=1;
		#(STEP) tb_d=1; tb_reset_n=0; tb_set_n=0;
		#(STEP) tb_reset_n=1;
		#(STEP) tb_reset_n=0;
		#(STEP) tb_reset_n=1;
		#(STEP) tb_set_n=1;
		#(STEP) tb_set_n=0;
		#(STEP) tb_set_n=1;
		#(STEP) tb_reset_n=0;
		#(STEP) tb_reset_n=1;
		#(STEP) $stop;
	end //end of initial
endmodule //End of module