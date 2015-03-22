`timescale 1ns/100ps
module tb_SingleCycleCPU;
	reg i_clk,i_rst_n;
	parameter STEP=100;
	always#(STEP/2) i_clk = ~i_clk;

	SingleCycleCPU U0_SingleCycleCPU(i_clk,i_rst_n);
	initial
	begin
		i_clk = 0; i_rst_n = 0; #20;
		i_rst_n = 1; #STEP;
		i_rst_n = 1; #(STEP*200);
		$stop;
	end
endmodule
