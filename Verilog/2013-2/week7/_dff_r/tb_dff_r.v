`timescale 1ns/100ps //time unit=1ns, precision=100ps

module tb_dff_r; //Module of tb_dff_r
	reg tb_clk,tb_reset_n,tb_d; //tb_clk=clock pulse; //tb_reset_n=reset switch; //tb_d=input value
	wire tb_q; //output value
	
	parameter STEP=10; //10ns parameter
	
	_dff_r U0_dff_r(.clk(tb_clk),.reset_n(tb_reset_n),.d(tb_d),.q(tb_q)); //Resettable D flip-flop
	
	always#(STEP/2) tb_clk=~tb_clk; //100kHz clock pulse
	
	initial //initial
	begin
		tb_clk=0; tb_reset_n=0; tb_d=0;
		#(STEP-7) tb_d=1;
		#(STEP) tb_reset_n=1; tb_d=0;
		#(STEP) tb_d=1;
		#(STEP) tb_d=0;
		#(STEP) tb_d=1;
		#(STEP) tb_d=0;
		#(STEP) tb_d=1;
		#(STEP) tb_d=0;
		#(STEP) tb_d=1;
		#(STEP) tb_d=0;
		#(STEP) tb_d=1;
		#(STEP) tb_d=0;
		#(STEP) tb_d=1;
		#(STEP) tb_reset_n=0;
		#(STEP) tb_d=0;
		#(STEP) tb_d=1;
		#(STEP) $stop;
	end //end of initial
endmodule //End of module