`timescale 1ns/100ps
module tb_and4;
	reg tb_a,tb_b,tb_c,tb_d;
	wire tb_y;
	
	_and4 U0_and4(.a(tb_a),.b(tb_b),.c(tb_c),.d(tb_d),.y(tb_y));
	
	initial
	begin
				tb_a=0; tb_b=0; tb_c=0; tb_d=0;
		#10	tb_a=1;
		#10	tb_b=1;
		#10	tb_c=1;
		#10	tb_d=1;
		#10	tb_a=0;
		#10	tb_b=0;
		#10	tb_c=0;
		#10	tb_d=0;
		#10	$stop;
	end
endmodule