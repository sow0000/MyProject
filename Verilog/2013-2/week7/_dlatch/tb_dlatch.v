`timescale 1ns/100ps //time unit=1ns, precision=100ps

module tb_dlatch; //Module of tb_dlatch
	reg tb_clk,tb_d; //tb_clk=clock pulse; //tb_d=input value
	wire tb_q,tb_q_bar; //output value
	
	_dlatch U0_dlatch(.clk(tb_clk),.d(tb_d),.q(tb_q),.q_bar(tb_q_bar)); //D-latch
	
	always#5 tb_clk=~tb_clk; //100kHz clock pulse
	
	initial //initial
	begin
		tb_clk=0; tb_d=0;
		#3; tb_d=1;
		#3; tb_d=0;
		#6; tb_d=1;
		#2; tb_d=0;
		#4; tb_d=1;
		#4; tb_d=0;
		#8; $stop;
	end //end of initial
endmodule //End of module
		