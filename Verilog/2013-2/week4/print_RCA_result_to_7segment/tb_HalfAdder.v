`timescale 1ns/100ps

module tb_HalfAdder;
	reg tb_a, tb_b;
	wire tb_s, tb_co;
	
	HalfAdder U0_HalfAdder(.a(tb_a),.b(tb_b),.s(tb_s),.co(tb_co));
	
	initial
	begin
		tb_a=0; tb_b=0;
		#10; tb_b=1;
		#10; tb_a=1; tb_b=0;
		#10; tb_b=1;
		#10; $stop;
	end
endmodule