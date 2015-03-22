`timescale 1ns/100ps

module tb_ram;
	reg CLOCK,CEn,WEn;
	reg [7:0] ADDR;
	reg [31:0] DIN;
	wire [31:0] DOUT;
	
	parameter STEP=10;
	
	ram U0_ram(.clk(CLOCK),.cen(CEn),.wen(WEn),.addr(ADDR),.din(DIN),.dout(DOUT));
	
	always#(STEP/2) CLOCK=~CLOCK;
	
	initial
	begin
		CLOCK=1'b1; CEn=1'b0; WEn=1'b0; ADDR=8'h00; DIN=32'h00;
		#(STEP+7) CEn=1'b1; WEn=1'b1;
		#(STEP) ADDR=8'h01; DIN=32'd01;
		#(STEP) ADDR=8'h02; DIN=32'd02;
		#(STEP) ADDR=8'h03; DIN=32'd03;
		#(STEP) ADDR=8'h04; DIN=32'd04;
		#(STEP) ADDR=8'h05; DIN=32'd05;
		#(STEP) ADDR=8'h06; DIN=32'd06;
		#(STEP) ADDR=8'h07; DIN=32'd07;
		#(STEP) ADDR=8'h08; DIN=32'd08;
		#(STEP) ADDR=8'h09; DIN=32'd09;
		#(STEP) ADDR=8'h0a; DIN=32'd10;
		#(STEP) ADDR=8'h0b; DIN=32'd11;
		#(STEP) ADDR=8'h0c; DIN=32'd12;
		#(STEP) ADDR=8'h0d; DIN=32'd13;
		#(STEP) ADDR=8'h0e; DIN=32'd14;
		#(STEP) ADDR=8'h0f; DIN=32'd15;
		#(STEP) ADDR=8'h10; DIN=32'd16;
		#(STEP) ADDR=8'h11; DIN=32'd17;
		#(STEP) ADDR=8'h12; DIN=32'd18;
		#(STEP) ADDR=8'h13; DIN=32'd19;
		#(STEP) ADDR=8'h14; DIN=32'd20;
		#(STEP) ADDR=8'h15; DIN=32'd21;
		#(STEP) ADDR=8'h16; DIN=32'd22;
		#(STEP) ADDR=8'h17; DIN=32'd23;
		#(STEP) ADDR=8'h18; DIN=32'd24;
		#(STEP) ADDR=8'h19; DIN=32'd25;
		#(STEP) ADDR=8'h1a; DIN=32'd26;
		#(STEP) ADDR=8'h1b; DIN=32'd27;
		#(STEP) ADDR=8'h1c; DIN=32'd28;
		#(STEP) ADDR=8'h1d; DIN=32'd29;
		#(STEP) ADDR=8'h1e; DIN=32'd30;
		#(STEP) ADDR=8'h1f; DIN=32'd31;
		#(STEP) CEn=1'b0; WEn=1'b0; ADDR=8'h00; DIN=32'h00;
		#(STEP) CEn=1'b1;
		#(STEP) ADDR=8'h01;
		#(STEP) ADDR=8'h02;
		#(STEP) ADDR=8'h03;
		#(STEP) ADDR=8'h04;
		#(STEP) ADDR=8'h05;
		#(STEP) ADDR=8'h06;
		#(STEP) ADDR=8'h07;
		#(STEP) ADDR=8'h08;
		#(STEP) ADDR=8'h09;
		#(STEP) ADDR=8'h0a;
		#(STEP) ADDR=8'h0b;
		#(STEP) ADDR=8'h0c;
		#(STEP) ADDR=8'h0d;
		#(STEP) ADDR=8'h0e;
		#(STEP) ADDR=8'h0f;
		#(STEP) ADDR=8'h10;
		#(STEP) ADDR=8'h11;
		#(STEP) ADDR=8'h12;
		#(STEP) ADDR=8'h13;
		#(STEP) ADDR=8'h14;
		#(STEP) ADDR=8'h15;
		#(STEP) ADDR=8'h16;
		#(STEP) ADDR=8'h17;
		#(STEP) ADDR=8'h18;
		#(STEP) ADDR=8'h19;
		#(STEP) ADDR=8'h1a;
		#(STEP) ADDR=8'h1b;
		#(STEP) ADDR=8'h1c;
		#(STEP) ADDR=8'h1d;
		#(STEP) ADDR=8'h1e;
		#(STEP) ADDR=8'h1f;
		#(STEP) ADDR=8'h00;
		#(STEP) $stop;
	end

endmodule //End of module