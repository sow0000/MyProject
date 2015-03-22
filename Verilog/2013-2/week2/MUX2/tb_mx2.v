`timescale 1ns/100ps
module tb_mx2;
	reg tb_d0,tb_d1,tb_s;
	wire tb_y;
	
	mx2 test_mx2(.y(tb_y),.d0(tb_d0),.d1(tb_d1),.s(tb_s));
	
	initial
	
	begin
		tb_s=0; tb_d0=0; tb_d1=0;
		#10;	tb_d1=1;
		#10;	tb_d0=1; tb_d1=0;
		#10;	tb_d1=1;
		#10;	tb_s=1; tb_d0=0; tb_d1=0;
		#10;	tb_d1=1;
		#10;	tb_d0=1; tb_d1=0;
		#10;	tb_d1=1;
		#10;	$finish;
	end
endmodule