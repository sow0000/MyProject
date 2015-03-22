`timescale 1ns/100ps

module tb_alu4;
	reg [3:0] tb_a, tb_b;
	reg [2:0] tb_op;
	wire [3:0] tb_result;
	wire tb_c, tb_n, tb_z, tb_v;
	
	alu4 U0_alu4(.a(tb_a),.b(tb_b),.op(tb_op),.result(tb_result),.c(tb_c),.n(tb_n),.z(tb_z),.v(tb_v));
	
	initial
	begin
		tb_a=4'b0000; tb_b=4'b0000; tb_op=3'b000; #10;
		if(tb_result!==4'b1111) $display("00000000000 failed.");
		tb_a=4'b1100; #10;
		if(tb_result!==4'b0011) $display("11000000000 failed.");
		tb_b=4'b0011; tb_op=3'b001; #10;
		if(tb_result!==4'b1100) $display("11000011001 failed.");
		tb_a=4'b0101; tb_b=4'b1001; tb_op=3'b010; #10;
		if(tb_result!==4'b0001) $display("01011001010 failed.");
		tb_b=4'b1010; tb_op=3'b011; #10;
		if(tb_result!==4'b1111) $display("01011010011 failed.");
		tb_a=4'b0011; tb_b=4'b0101; tb_op=3'b100; #10;
		if(tb_result!==4'b0110) $display("00110101100 failed.");
		tb_op=3'b101; #10;
		if(tb_result!==4'b1001) $display("00110101101 failed.");
		tb_a=4'b0100; tb_b=4'b0011; tb_op=3'b110; #10;				//po+po
		if(tb_result!==4'b0111) $display("01000011110 failed.");
		if(tb_v===1'b1) $display("01000011110 overflow.");
		tb_b=4'b0100; #10;													//po+po v
		if(tb_result!==4'b1000) $display("01000100110 failed.");
		if(tb_v===1'b1) $display("01000100110 overflow.");
		tb_b=4'b1000; #10;													//po+ne
		if(tb_result!==4'b1100) $display("01001000110 failed.");
		if(tb_v===1'b1) $display("01001000110 overflow.");
		tb_b=4'b1100; #10;													//po+ne z, c
		if(tb_result!==4'b0000) $display("01001100110 failed.");
		if(tb_v===1'b1) $display("01001100110 overflow.");
		tb_a=4'b1100; tb_b=4'b1111; #10;									//ne+ne c
		if(tb_result!==4'b1011) $display("11001111110 failed.");
		if(tb_v===1'b1) $display("11001111110 overflow.");
		tb_b=4'b1011; #10;													//ne+ne v
		if(tb_result!==4'b0111) $display("11001011110 failed.");
		if(tb_v===1'b1) $display("11001011110 overflow.");
		tb_a=4'b1000; tb_b=4'b1000; #10;									//ne+ne z, c, v
		if(tb_result!==4'b0000) $display("10001000110 failed.");
		if(tb_v===1'b1) $display("10001000110 overflow.");
		tb_a=4'b0101; tb_b=4'b0101; tb_op=3'b111; #10;				//po-po z, c
		if(tb_result!==4'b0000) $display("01010101111 failed.");
		if(tb_v===1'b1) $display("01010101111 overflow.");
		tb_b=4'b0111; #10;													//po-po n
		if(tb_result!==4'b1110) $display("01010111111 failed.");
		if(tb_v===1'b1) $display("01010111111 overflow.");
		tb_b=4'b1110; #10;													//po-ne
		if(tb_result!==4'b0111) $display("01011110111 failed.");
		if(tb_v===1'b1) $display("01011110111 overflow.");
		tb_b=4'b1010; #10;													//po-ne v
		if(tb_result!==4'b1011) $display("01011010111 failed.");
		if(tb_v===1'b1) $display("01011010111 overflow.");
		tb_a=4'b1010; tb_b=4'b1100;  #10;								//ne-ne
		if(tb_result!==4'b1110) $display("10101100111 failed.");
		if(tb_v===1'b1) $display("10101100111 overflow.");
		tb_b=4'b1010;  #10;													//ne-ne z, c
		if(tb_result!==4'b0000) $display("10101010111 failed.");
		if(tb_v===1'b1) $display("10101010111 overflow.");
		tb_b=4'b0101;  #10;													//ne-po c, v
		if(tb_result!==4'b0101) $display("10100101111 failed.");
		if(tb_v===1'b1) $display("10100101111 overflow.");
		tb_a=4'b1110; tb_b=4'b0111;  #10;								//ne-po c, v
		if(tb_result!==4'b0111) $display("11100111111 failed.");
		if(tb_v===1'b1) $display("11100111111 overflow.");
		$stop;
	end
endmodule