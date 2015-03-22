`timescale 1ns/100ps //time unit=1ns, precision=100ps

module tb_srlatch; //Module of srlatch
	reg tb_r,tb_s; //input value
	wire tb_q,tb_q_bar; //output value
	
	_srlatch U0_srlatch(.r(tb_r),.s(tb_s),.q(tb_q),.q_bar(tb_q_bar)); //SR-Latch
	
	initial //initial
	begin
		tb_r=0; tb_s=0;
		#10; tb_r=1;
		#10; tb_r=0; tb_s=1;
		#10; tb_r=1;
		#10; tb_s=0;
		#10; tb_r=0;
		#10; $stop;
	end //end of initial
endmodule //End of module