`timescale 1ns/100ps

module tb_multiplier;
	reg clk,reset_n,S_sel,S_wr;
	reg [7:0] S_address;
	reg [31:0] S_din;
	wire [31:0] S_dout;
	wire m_interrupt;
	
	parameter STEP = 10;
	
	Multiplier U0_Multiplier(clk,reset_n,S_sel,S_wr,S_address,S_din,S_dout,m_interrupt);
	
	always#(STEP/2) clk = ~clk;
	
	initial
	begin
		clk=1; reset_n=0; S_sel=0; S_wr=0; S_address=8'h0; S_din=32'h00;
		#(STEP+3); reset_n=1;
		#(STEP); S_sel=1; S_wr=1; S_address=8'h0; S_din=32'h20;
		#(STEP); S_address=8'h1; S_din=32'h00;
		#(STEP); S_address=8'h2; S_din=32'h19;
		#(STEP); S_address=8'h3; S_din=32'h00;
		#(STEP); S_address=8'h8; S_din=32'h01;
		#(STEP); S_address=8'ha;
		#(STEP); S_din=32'h00;
		#(STEP*36); S_wr=0; S_address=8'h4;
		#(STEP); S_address=8'h5;
		#(STEP); S_address=8'h6;
		#(STEP); S_address=8'h7;
		#(STEP); S_wr=1; S_address=8'hb; S_din=32'h01;
		#(STEP); $stop;
	end
endmodule //End of module