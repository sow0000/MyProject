`timescale 1ns/100ps

module tb_top;
	reg M_req, M_wr;
	reg [7:0] M_address;
	reg [31:0] result0,result1,M_dout;
	reg reset_n, clk;
	
	wire M_grant;
	wire [31:0] M_din;
	wire f_interrupt, m_interrupt;
	wire [63:0] result;
	
	parameter STEP = 10;
	
	top U0_top(clk,reset_n,M_req,M_wr,M_address,M_dout,M_grant,M_din,f_interrupt,m_interrupt);
	
	assign result={result1,result0};
	
	always#(STEP/2) clk = ~clk;
	
	initial begin
	reset_n=0; clk=1; M_req=0; M_wr=0; M_address=8'h00; M_dout=32'h00; result0=32'h00; result1=32'h00; #3; // initialize.
	reset_n=1; #(STEP*5);
	M_req=1; #(STEP*5);
	M_address=8'h22; #(STEP*5);
	M_wr=1; M_address=8'h20; M_dout=32'h14; #(STEP*5);
	M_wr=1; M_address=8'h21; M_dout=32'h01; #(STEP*5);
	M_wr=1; M_address=8'h23; M_dout=32'h01; #(STEP*5);
	M_req=0; M_wr=0; #(STEP*900)
	M_req=1; M_wr=0; M_address=8'h25; #(STEP);
	result0=M_din; M_address=8'h26; #(STEP);
	result1=M_din; M_wr=1; M_address=8'h24; M_dout=32'h01; #(STEP);
	$stop;
	end
endmodule