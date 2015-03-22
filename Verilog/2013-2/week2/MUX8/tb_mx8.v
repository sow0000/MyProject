`timescale 1ns/100ps
module tb_mx8;
	reg tb_a,tb_b,tb_c,tb_d,tb_e,tb_f,tb_g,tb_h,tb_s0,tb_s1,tb_s2;
	wire tb_y;
	
	mx8 test_mx8(.y(tb_y),.a(tb_a),.b(tb_b),.c(tb_c),.d(tb_d),.e(tb_e),.f(tb_f),.g(tb_g),.h(tb_h),.s0(tb_s0),.s1(tb_s1),.s2(tb_s2));
	
	initial
	
	begin
		tb_s0=0; tb_s1=0; tb_s2=0; tb_a=0; tb_b=0; tb_c=0; tb_d=0; tb_e=0; tb_f=0; tb_g=0; tb_h=0;
		#10;	tb_a=1;
		#10;	tb_s0=1; tb_a=0;
		#10;	tb_b=1;
		#10;	tb_s0=0; tb_s1=1; tb_b=0;
		#10;	tb_c=1;
		#10;	tb_s0=1; tb_c=0;
		#10;	tb_d=1;
		#10;	tb_s0=0; tb_s1=0; tb_s2=1; tb_d=0;
		#10;	tb_e=1;
		#10;	tb_s0=1; tb_e=0;
		#10;	tb_f=1;
		#10;	tb_s0=0; tb_s1=1; tb_f=0;
		#10;	tb_g=1;
		#10;	tb_s0=1; tb_g=0;
		#10;	tb_h=1;
		#10;	$finish;
	end
endmodule