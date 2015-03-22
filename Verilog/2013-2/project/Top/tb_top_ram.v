`timescale 1ns/100ps

module tb_top_ram;
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
	M_req=1; M_wr=1; #(STEP*5);
	M_address=8'h4b; M_dout=32'h00; #(STEP*5);
	M_address=8'h00; M_dout=32'h05; #(STEP*5);
	M_address=8'h01; M_dout=32'h00; #(STEP*5);
	M_address=8'h02; M_dout=32'h07; #(STEP*5);
	M_address=8'h03; M_dout=32'hFF; #(STEP*5);
	M_address=8'h04; M_req=0; M_wr=0; #(STEP*5);
	M_address=8'h04; M_req=1; M_wr=0; #(STEP*5);

	M_address=8'h00; #(STEP*5);
	M_address=8'h01; #(STEP*5);
	M_address=8'h02; #(STEP*5);
	M_address=8'h03; #(STEP*5);
	
	$stop;
	end
endmodule