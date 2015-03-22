///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 32-bit Carry Look Ahead
//FILE : CarryLookAhead32.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 32bit Carry Look Ahead Adder.
//LAST UPDATE : Oct. 10, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module CarryLookAhead32(a,b,ci,s,co); //Module of 32-bit Carry Look Ahead
	input [31:0] a,b; //a,b : Variable of input binary number
	input ci; //ci : Variable of input carry value
	output [31:0] s; //s : Output port for result
	output co; //co : Output port for carry of result
	
	wire c1, c2, c3, c4, c5, c6, c7; //Wire for internal carry
	
	CarryLookAhead4 U0_CarryLookAhead4 (.a(a[3:0]),.b(b[3:0]),.ci(ci), .s(s[3:0]),.co(c1)); //Calculate first 4-bit use carry look ahead adder
	CarryLookAhead4 U1_CarryLookAhead4 (.a(a[7:4]),.b(b[7:4]),.ci(c1), .s(s[7:4]),.co(c2)); //Calculate second 4-bit use carry look ahead adder
	CarryLookAhead4 U2_CarryLookAhead4 (.a(a[11:8]),.b(b[11:8]),.ci(c2), .s(s[11:8]),.co(c3)); //Calculate third 4-bit use carry look ahead adder
	CarryLookAhead4 U3_CarryLookAhead4 (.a(a[15:12]),.b(b[15:12]),.ci(c3), .s(s[15:12]),.co(c4)); //Calculate fourth 4-bit use carry look ahead adder
	CarryLookAhead4 U4_CarryLookAhead4 (.a(a[19:16]),.b(b[19:16]),.ci(c4), .s(s[19:16]),.co(c5)); //Calculate fifth 4-bit use carry look ahead adder
	CarryLookAhead4 U5_CarryLookAhead4 (.a(a[23:20]),.b(b[23:20]),.ci(c5), .s(s[23:20]),.co(c6)); //Calculate sixth 4-bit use carry look ahead adder
	CarryLookAhead4 U6_CarryLookAhead4 (.a(a[27:24]),.b(b[27:24]),.ci(c6), .s(s[27:24]),.co(c7)); //Calculate seventh 4-bit use carry look ahead adder
	CarryLookAhead4 U7_CarryLookAhead4 (.a(a[31:28]),.b(b[31:28]),.ci(c7), .s(s[31:28]),.co(co)); //Calculate eighth 4-bit use carry look ahead adder
	
endmodule //End of module