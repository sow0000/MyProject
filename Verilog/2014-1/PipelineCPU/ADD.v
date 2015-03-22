////////////////////////////////////////////////////////////////
//	TITLE : 32 bit Adder
//	FILE : ADD.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering	
//	STUDENT ID : 2010720092, 2010720117	
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim	
//	PLATFORM : Windows 7	
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines 32 bit Adder.	
//								Use 32-bits Carry Look-ahead Adder module.
//	LAST UPDATE : 04.07, 2014	
////////////////////////////////////////////////////////////////
module ADD(i_data1,i_data2,o_sum);
	input [31:0] i_data1,i_data2;
	output [31:0] o_sum;
	
	cla32 U0_cla32(.a(i_data1),.b(i_data2),.ci(1'b0),.s(o_sum),.co());

endmodule //end of module

//32-bits Carry Look-ahead Adder module
module cla32(a,b,ci,s,co);
	input [31:0] a,b;
	input ci;
	output [31:0] s;
	output co;

	wire c1,c2,c3,c4,c5,c6,c7;

	cla4 U0_cla4(.a(a[3:0]), .b(b[3:0]), .ci(ci), .s(s[3:0]), .co(c1));
	cla4 U1_cla4(.a(a[7:4]), .b(b[7:4]), .ci(c1), .s(s[7:4]), .co(c2));
	cla4 U2_cla4(.a(a[11:8]), .b(b[11:8]), .ci(c2), .s(s[11:8]), .co(c3));
	cla4 U3_cla4(.a(a[15:12]), .b(b[15:12]), .ci(c3), .s(s[15:12]), .co(c4));
	cla4 U4_cla4(.a(a[19:16]), .b(b[19:16]), .ci(c4), .s(s[19:16]), .co(c5));
	cla4 U5_cla4(.a(a[23:20]), .b(b[23:20]), .ci(c5), .s(s[23:20]), .co(c6));
	cla4 U6_cla4(.a(a[27:24]), .b(b[27:24]), .ci(c6), .s(s[27:24]), .co(c7));
	cla4 U7_cla4(.a(a[31:28]), .b(b[31:28]), .ci(c7), .s(s[31:28]), .co(co));

endmodule //End of module

//4-bit Carry Look Ahead
module cla4(a,b,ci,s,co);
	input [3:0] a, b;
	input ci;
	output [3:0] s;
	output co;
	
	wire [3:0] g,p;
	wire c1, c2, c3;
	wire w0_c2, w1_c2;
	wire w0_c3, w1_c3, w2_c3;
	wire w0_co, w1_co, w2_co, w3_co;
		
	assign g=a&b;
	assign p=a|b;
	
	assign c1=(g[0])|(p[0]&ci);
	
	assign w0_c2=p[1]&g[0];
	assign w1_c2=p[1]&p[0]&ci;
	assign c2=g[1]|w0_c2|w1_c2;
	
	assign w0_c3=p[2]&g[1];
	assign w1_c3=p[2]&p[1]&g[0];
	assign w2_c3=p[2]&p[1]&p[0]&ci;
	assign c3=g[2]|w0_c3|w1_c3|w2_c3;
	
	assign w0_co=p[3]&g[2];
	assign w1_co=p[3]&p[2]&g[1];
	assign w2_co=p[3]&p[2]&p[1]&g[0];
	assign w3_co=p[3]&p[2]&p[1]&p[0]&ci;
	assign co=g[3]|w0_co|w1_co|w2_co|w3_co;

	assign s[0]=a[0]^b[0]^ci;
	assign s[1]=a[1]^b[1]^c1;
	assign s[2]=a[2]^b[2]^c2;
	assign s[3]=a[3]^b[3]^c3;
	
endmodule //End of module