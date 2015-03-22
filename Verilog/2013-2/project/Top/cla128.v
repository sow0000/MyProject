///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 128-bit Carry Look Ahead
//FILE : cla128.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 128bit Carry Look Ahead Adder.
//LAST UPDATE : DEC, 01, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module cla128(a,b,ci,s,co); //Module of 128-bit Carry Look Ahead
	input [127:0] a, b; //a,b : Variable of input binary number
	input ci; //ci : Variable of input carry value
	output [127:0] s; //s : Output port for result
	output co; //co : Output port for carry of result
	
	wire c1,c2,c3; //Wire for co
	
	cla32 U0_cla32(.a(a[31:0]),.b(b[31:0]),.ci(ci),.s(s[31:0]),.co(c1));
	cla32 U1_cla32(.a(a[63:32]),.b(b[63:32]),.ci(c1),.s(s[63:32]),.co(c2));
	cla32 U2_cla32(.a(a[95:64]),.b(b[95:64]),.ci(c2),.s(s[95:64]),.co(c3));
	cla32 U3_cla32(.a(a[127:96]),.b(b[127:96]),.ci(c3),.s(s[127:96]),.co(co));
	
endmodule //End of module

//32-bit Carry Look Ahead
module cla32(a,b,ci,s,co); 
	input [31:0] a,b; //a,b : Variable of input binary number
	input ci; //ci : Variable of input carry value
	output [31:0] s; //s : Output port for result
	output co; //co : Output port for carry of result
	
	wire c1, c2, c3, c4, c5, c6, c7; //Wire for internal carry
	
	cla4 U0_cla4 (.a(a[3:0]),.b(b[3:0]),.ci(ci), .s(s[3:0]),.co(c1)); //a+b
	cla4 U1_cla4 (.a(a[7:4]),.b(b[7:4]),.ci(c1), .s(s[7:4]),.co(c2));
	cla4 U2_cla4 (.a(a[11:8]),.b(b[11:8]),.ci(c2), .s(s[11:8]),.co(c3));
	cla4 U3_cla4 (.a(a[15:12]),.b(b[15:12]),.ci(c3), .s(s[15:12]),.co(c4));
	cla4 U4_cla4 (.a(a[19:16]),.b(b[19:16]),.ci(c4), .s(s[19:16]),.co(c5));
	cla4 U5_cla4 (.a(a[23:20]),.b(b[23:20]),.ci(c5), .s(s[23:20]),.co(c6));
	cla4 U6_cla4 (.a(a[27:24]),.b(b[27:24]),.ci(c6), .s(s[27:24]),.co(c7));
	cla4 U7_cla4 (.a(a[31:28]),.b(b[31:28]),.ci(c7), .s(s[31:28]),.co(co));
	
endmodule //End of module

//8-bit Carry Look Ahead
module cla8(a,b,ci,s,co); 
	input [7:0] a,b; //a,b : Variable of input binary number
	input ci; //ci : Variable of input carry value
	output [7:0] s; //s : Output port for result
	output co; //co : Output port for carry of result
	
	wire c1; //Wire for internal carry
	
	cla4 U0_cla4 (.a(a[3:0]),.b(b[3:0]),.ci(ci), .s(s[3:0]),.co(c1)); //a+b
	cla4 U1_cla4 (.a(a[7:4]),.b(b[7:4]),.ci(c1), .s(s[7:4]),.co(co));
	
endmodule //End of module

//4-bit Carry Look Ahead
module cla4(a,b,ci,s,co);
	input [3:0] a, b; //a,b : Variable of input binary number
	input ci; //ci : Variable of input carry value
	output [3:0] s; //s : Output port for result
	output co; //co : Output port for carry of result
	
	wire [3:0] g,p; //g : Wire for generate //p : Wire for propagate
	wire c1, c2, c3; //Wire for intenal carry
	wire w0_c2, w1_c2; //Wire for intenal carry
	wire w0_c3, w1_c3, w2_c3; //Wire for intenal carry
	wire w0_co, w1_co, w2_co, w3_co; //Wire for intenal carry
		
	assign g=a&b; //Calculate generate
	assign p=a|b; //Calculate propagate
	
	assign c1=(g[0])|(p[0]&ci); //Calculate c1
	
	assign w0_c2=p[1]&g[0]; //Calculate c2
	assign w1_c2=p[1]&p[0]&ci;
	assign c2=g[1]|w0_c2|w1_c2;
	
	assign w0_c3=p[2]&g[1]; //Calculate c3
	assign w1_c3=p[2]&p[1]&g[0];
	assign w2_c3=p[2]&p[1]&p[0]&ci;
	assign c3=g[2]|w0_c3|w1_c3|w2_c3;
	
	assign w0_co=p[3]&g[2]; //Calculate co
	assign w1_co=p[3]&p[2]&g[1];
	assign w2_co=p[3]&p[2]&p[1]&g[0];
	assign w3_co=p[3]&p[2]&p[1]&p[0]&ci;
	assign co=g[3]|w0_co|w1_co|w2_co|w3_co;

	assign s[0]=a[0]^b[0]^ci; //a+b
	assign s[1]=a[1]^b[1]^c1;
	assign s[2]=a[2]^b[2]^c2;
	assign s[3]=a[3]^b[3]^c3;
	
endmodule //End of module