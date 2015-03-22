//2-to-1 multiplexer
module mx2(d0, d1, s, y);
	input d0, d1, s; //input
	output y; //output data
	
	assign y = (s == 0) ? d0 : d1; //if s is 0, output d0 or not, output d1
endmodule //End of module

//8-bit 2-to-1 multiplexer
module mx2_8bits(d0, d1, s, y);
	input [7:0] d0, d1; //8-bit input
	input s; //selection
	output [7:0] y; //8-bit output data
	
	assign y = (s == 0) ? d0 : d1; //if s is 0, output d0 or not, output d1
endmodule //End of module

//32-bit 2-to-1 multiplexer
module mx2_32bits(y,d0,d1,d2,d3,s);
	input [31:0] d0, d1, d2, d3; //d0~3 : input data.
	input s; //s : seletion input data
	output [31:0] y; //Output value
	
	wire [31:0] w0,w1;
	
	assign y = (s == 0) ? d0 : d1;
endmodule //End of module

//64-bit 2-to-1 multiplexer
module mx2_64bits(y,d0,d1,d2,d3,s);
	input [63:0] d0, d1, d2, d3; //d0~3 : input data.
	input s; //s : seletion input data
	output [63:0] y; //Output value
	
	wire [63:0] w0,w1;
	
	assign y = (s == 0) ? d0 : d1;
endmodule //End of module

//8-bit 4-to-1 multiplexer
module mx4_8bits(d0, d1, d2, d3, s, y);
	input [7:0] d0, d1, d2, d3; //8-bit input
	input [1:0] s; //selection
	output [7:0] y; //8-bit output data
	
	wire [7:0] w0,w1;
	
	assign w0 = (s[0] == 0) ? d0 : d1;
	assign w1 = (s[0] == 0) ? d2 : d3;
	assign y = (s[1] == 0) ? w0 : w1;
endmodule //End of module

//32-bit 4-to-1 multiplexer
module mx4_32bits(y,d0,d1,d2,d3,s);
	input [31:0] d0, d1, d2, d3; //d0~3 : input data.
	input [2:0] s; //s : seletion input data
	output [31:0] y; //Output value
	
	wire [31:0] w0,w1;
	
	assign w1 = (s[0] == 0) ? d3 : d2;
	assign w0 = (s[1] == 0) ? w1 : d1;
	assign y = (s[2] == 0) ? w0 : d0;
endmodule //End of module

//128-bit 4-to-1 multiplexer
module mx4_128bits(y,d0,d1,d2,d3,s);
	input [127:0] d0, d1, d2, d3; //d0~3 : input data.
	input [1:0] s; //s : seletion input data
	output [127:0] y; //Output value
	
	wire [127:0] w0,w1;
	
	assign w0 = (s[0] == 0) ? d0 : d1;
	assign w1 = (s[0] == 0) ? d2 : d3;
	assign y = (s[1] == 0) ? w0 : w1;
endmodule //End of module