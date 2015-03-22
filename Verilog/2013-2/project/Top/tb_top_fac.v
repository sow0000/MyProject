`timescale 1ns/100ps

module tb_top_fac;
	reg M_req, M_wr;
	reg [7:0] M_address;
	reg [31:0] M_dout;
	reg reset_n, clk;
	
	wire M_grant;
	wire [31:0] M_din;
	wire f_interrupt, m_interrupt;
	
	top U0_top(clk,reset_n,M_req,M_wr,M_address,M_dout,M_grant,M_din,f_interrupt,m_interrupt);
	
	parameter STEP = 10;
	always#(STEP/2) clk = ~clk;
	
	initial begin
	reset_n=0; clk=0; M_req=0; M_wr=0; M_address=8'h00; M_dout=32'h00; #3; // initialize.
	
	reset_n=1; #(STEP*5);
	M_req=1; #(STEP*5);
	M_address=8'h22; #(STEP*5);
	M_wr=1; M_address=8'h20; M_dout=32'h04; #(STEP*5);
	M_wr=1; M_address=8'h21; M_dout=32'h01; #(STEP*5);
	M_wr=1; M_address=8'h23; M_dout=32'h01; #(STEP*5);
	M_req=0; M_wr=0; 
	 #(STEP*200);
	 
	M_req=1; #(STEP*5);
	M_address=8'h25; #(STEP*5);
	M_address=8'h26; #(STEP*5);
	M_wr=1; M_address=8'h24; #(STEP*5);
	M_req=0; #(STEP*5);
	M_req=1; #(STEP*5);
	
	$stop;
	end
endmodule