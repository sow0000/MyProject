`timescale 1ns/100ps

module tb_print_RCA_result_to_7segment;
	reg [3:0] tb_a, tb_b;
	reg tb_ci;
	wire [13:0] tb_dec_out;
	
	print_RCA_result_to_7segment U0_print_RCA_result_to_7segment(.a(tb_a),.b(tb_b),.cin(tb_ci),.dec_out(tb_dec_out));
	
	initial
	begin
		tb_a=4'b0000; tb_b=4'b0000; tb_ci=4'b0000;
		#10; tb_a=4'b0101; tb_b=4'b0100;
		#10; tb_a=4'b1111; tb_b=4'b1111;
		#10; tb_ci=1;
		#10; $stop;
	end
	
	
endmodule