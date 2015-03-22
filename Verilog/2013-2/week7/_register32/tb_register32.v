`timescale 1ns/100ps //time unit=1ns, precision=100ps

module tb_register32;
	reg tb_clk; //clock pulse
	reg [31:0] tb_d; //input value
	wire [31:0] tb_q; //output value
	
	_register32 U0_register32(.clk(tb_clk),.d(tb_d),.q(tb_q)); //32-bit register
	
	always#5 tb_clk=~tb_clk; //100kHz clock pulse
	
	initial //initial
	begin
		tb_clk=0; tb_d=32'h12345678;
		#3 tb_d=32'h98765432;
		#3 tb_d=32'hffeeddcc;
		#6 tb_d=32'hbbaaccdd;
		#2 tb_d=32'h77665544;
		#4 tb_d=32'h33221100;
		#4 tb_d=32'h12345678;
		#8 $stop;
	end //end of initial
endmodule //End of module