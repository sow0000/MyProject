`timescale 1ns/100ps //time unit=1ns, precision=100ps

module tb_dff_en; //Module of tb_dff_en
	reg tb_clk,tb_en,tb_d; //tb_clk=clock pulse; //tb_en=enable switch; //tb_d=input value
	wire tb_q; //output value
	
	parameter STEP=10; //10ns parameter
	
	_dff_en U0_dff_en(.clk(tb_clk),.en(tb_en),.d(tb_d),.q(tb_q)); //Enabled D flip-flop
	
	always#(STEP/2) tb_clk=~tb_clk; //100kHz clock pulse
	
	initial //initial
	begin
		tb_clk=0; tb_en=1; tb_d=0;
		#(STEP-7) tb_d=1;
		#(STEP) tb_d=0;
		#(STEP) tb_d=1;
		#(STEP) tb_d=0;
		#(STEP) tb_d=1;
		#(STEP) tb_d=0; tb_en=0;
		#(STEP) tb_d=1;
		#(STEP) tb_d=0;
		#(STEP) tb_d=1;
		#(STEP) tb_d=0;
		#(STEP) $stop;
	end //end of initial
endmodule //End of module