`timescale 1ns/100ps

module tb_arbitrator;
	reg M0_req, M1_req, reset_n, clk;
	wire M0_grant, M1_grant;
	
	arbitrator U0_arbitrator(.clk(clk),.reset_n(reset_n),.M0_req(M0_req),.M1_req(M1_req),.M0_grant(M0_grant),.M1_grant(M1_grant));
	
	parameter STEP = 10;
	always#(STEP/2) clk = ~clk;
	
	initial begin
	M0_req=0; M1_req=0; reset_n=0; clk=0; #3; // initialize.
	
	reset_n=1; #(STEP*5);
	
	M0_req=1; M1_req=0; #(STEP*5);
	M0_req=0; M1_req=0; #(STEP*5);
	M0_req=0; M1_req=1; #(STEP*5);
	M0_req=0; M1_req=0; #(STEP*5);
	M0_req=1; M1_req=1; #(STEP*5);
	M0_req=0; M1_req=0; #(STEP*5);
	M0_req=1; M1_req=1; #(STEP*5);
	M0_req=0; M1_req=0; #(STEP*5);
	M0_req=1; M1_req=1; #(STEP*5);
	M0_req=0; M1_req=0; #(STEP*5);
	M0_req=1; M1_req=1; #(STEP*5);
	M0_req=0; M1_req=0; #(STEP*5);
	M0_req=1; M1_req=1; #(STEP*5);
	M0_req=0; M1_req=0; #(STEP*5);
	M0_req=1; M1_req=1; #(STEP*5);
	M0_req=0; M1_req=0; #(STEP*5);
	M0_req=1; M1_req=0; #(STEP*5);
	M0_req=1; M1_req=1; #(STEP*5);
	M0_req=0; M1_req=1; #(STEP*5);
	M0_req=0; M1_req=0; #(STEP*5);
	
	reset_n=0; #(STEP*5);
	
	$stop;
	end
endmodule