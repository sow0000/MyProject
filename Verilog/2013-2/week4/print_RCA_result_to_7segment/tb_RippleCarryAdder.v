`timescale 1ns/100ps

module tb_RippleCarryAdder;
	reg [3:0] tb_a, tb_b;
	reg tb_ci;
	wire [3:0] tb_s;
	wire tb_co;
	wire [4:0] tb_result;
	
	RippleCarryAdder U0_RippleCarryAdder(.a(tb_a),.b(tb_b),.ci(tb_ci),.s(tb_s),.co(tb_co));
	
	initial
	begin
		tb_a=4'b0000; tb_b=4'b0000; tb_ci=4'b0000;
		#10; tb_a=4'b0101; tb_b=4'b0100;
		#10; tb_a=4'b1111; tb_b=4'b1111;
		#10; tb_ci=1;
		#10; $stop;
	end
	
	assign tb_result={tb_co, tb_s};
	
endmodule