////////////////////////////////////////////////////////////////
//	TITLE : Multiplexer
//	FILE : MUX.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering	
//	STUDENT ID : 2010720092, 2010720117	
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim	
//	PLATFORM : Windows 7	
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines Multiplexer.	
//								Implement 32-bit 32-to-1 Multiplexer, 
//								32-bit 2-to-1 Multiplexer, 5-bit 2-to-1 Multiplexer.
//	LAST UPDATE : 04.07, 2014	
////////////////////////////////////////////////////////////////

//32-bit 32-to-1 Multiplexer
module mx32_32b(i_data0,i_data1,i_data2,i_data3,i_data4,i_data5,i_data6,i_data7,i_data8,i_data9,i_data10,i_data11,i_data12,i_data13,i_data14,i_data15,i_data16,i_data17,i_data18,i_data19,i_data20,i_data21,i_data22,i_data23,i_data24,i_data25,i_data26,i_data27,i_data28,i_data29,i_data30,i_data31,i_sel,o_data);
	input [31:0] i_data0,i_data1,i_data2,i_data3,i_data4,i_data5,i_data6,i_data7,i_data8,i_data9,i_data10,i_data11,i_data12,i_data13,i_data14,i_data15,i_data16,i_data17,i_data18,i_data19,i_data20,i_data21,i_data22,i_data23,i_data24,i_data25,i_data26,i_data27,i_data28,i_data29,i_data30,i_data31;
	input [4:0] i_sel;
	output [31:0] o_data;
	wire [31:0] w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22,w23,w24,w25,w26,w27,w28,w29,w30;
	
	mx2_32b U0_mx2_32b(.o_data(w0),.i_data1(i_data0),.i_data2(i_data1),.i_sel(i_sel[0]));
	mx2_32b U1_mx2_32b(.o_data(w1),.i_data1(i_data2),.i_data2(i_data3),.i_sel(i_sel[0]));
	mx2_32b U2_mx2_32b(.o_data(w2),.i_data1(i_data4),.i_data2(i_data5),.i_sel(i_sel[0]));
	mx2_32b U3_mx2_32b(.o_data(w3),.i_data1(i_data6),.i_data2(i_data7),.i_sel(i_sel[0]));
	mx2_32b U4_mx2_32b(.o_data(w4),.i_data1(i_data8),.i_data2(i_data9),.i_sel(i_sel[0]));
	mx2_32b U5_mx2_32b(.o_data(w5),.i_data1(i_data10),.i_data2(i_data11),.i_sel(i_sel[0]));
	mx2_32b U6_mx2_32b(.o_data(w6),.i_data1(i_data12),.i_data2(i_data13),.i_sel(i_sel[0]));
	mx2_32b U7_mx2_32b(.o_data(w7),.i_data1(i_data14),.i_data2(i_data15),.i_sel(i_sel[0]));
	mx2_32b U8_mx2_32b(.o_data(w8),.i_data1(i_data16),.i_data2(i_data17),.i_sel(i_sel[0]));
	mx2_32b U9_mx2_32b(.o_data(w9),.i_data1(i_data18),.i_data2(i_data19),.i_sel(i_sel[0]));
	mx2_32b U10_mx2_32b(.o_data(w10),.i_data1(i_data20),.i_data2(i_data21),.i_sel(i_sel[0]));
	mx2_32b U11_mx2_32b(.o_data(w11),.i_data1(i_data22),.i_data2(i_data23),.i_sel(i_sel[0]));
	mx2_32b U12_mx2_32b(.o_data(w12),.i_data1(i_data24),.i_data2(i_data25),.i_sel(i_sel[0]));
	mx2_32b U13_mx2_32b(.o_data(w13),.i_data1(i_data26),.i_data2(i_data27),.i_sel(i_sel[0]));
	mx2_32b U14_mx2_32b(.o_data(w14),.i_data1(i_data28),.i_data2(i_data29),.i_sel(i_sel[0]));
	mx2_32b U15_mx2_32b(.o_data(w15),.i_data1(i_data30),.i_data2(i_data31),.i_sel(i_sel[0]));
	
	mx2_32b U16_mx2_32b(.o_data(w16),.i_data1(w0),.i_data2(w1),.i_sel(i_sel[1]));
	mx2_32b U17_mx2_32b(.o_data(w17),.i_data1(w2),.i_data2(w3),.i_sel(i_sel[1]));
	mx2_32b U18_mx2_32b(.o_data(w18),.i_data1(w4),.i_data2(w5),.i_sel(i_sel[1]));
	mx2_32b U19_mx2_32b(.o_data(w19),.i_data1(w6),.i_data2(w7),.i_sel(i_sel[1]));
	mx2_32b U20_mx2_32b(.o_data(w20),.i_data1(w8),.i_data2(w9),.i_sel(i_sel[1]));
	mx2_32b U21_mx2_32b(.o_data(w21),.i_data1(w10),.i_data2(w11),.i_sel(i_sel[1]));
	mx2_32b U22_mx2_32b(.o_data(w22),.i_data1(w12),.i_data2(w13),.i_sel(i_sel[1]));
	mx2_32b U23_mx2_32b(.o_data(w23),.i_data1(w14),.i_data2(w15),.i_sel(i_sel[1]));
	
	mx2_32b U24_mx2_32b(.o_data(w24),.i_data1(w16),.i_data2(w17),.i_sel(i_sel[2]));
	mx2_32b U25_mx2_32b(.o_data(w25),.i_data1(w18),.i_data2(w19),.i_sel(i_sel[2]));
	mx2_32b U26_mx2_32b(.o_data(w26),.i_data1(w20),.i_data2(w21),.i_sel(i_sel[2]));
	mx2_32b U27_mx2_32b(.o_data(w27),.i_data1(w22),.i_data2(w23),.i_sel(i_sel[2]));
 
	mx2_32b U28_mx2_32b(.o_data(w28),.i_data1(w24),.i_data2(w25),.i_sel(i_sel[3]));
	mx2_32b U29_mx2_32b(.o_data(w29),.i_data1(w26),.i_data2(w27),.i_sel(i_sel[3]));
	
	mx2_32b U30_mx2_32b(.o_data(o_data),.i_data1(w28),.i_data2(w29),.i_sel(i_sel[4]));
	
endmodule //End of module

//32-bit 2-to-1 Multiplexer
module mx2_32b(i_data1,i_data2,i_sel,o_data);
	input [31:0] i_data1,i_data2;
	input i_sel;
	output [31:0] o_data;
	
	assign o_data=(i_sel==0) ? i_data1 : i_data2;
	
endmodule //End of module

//5-bit 2-to-1 Multiplexer
module mx2_5b(i_data1,i_data2,i_sel,o_data);
	input [4:0] i_data1,i_data2;
	input i_sel;
	output [4:0] o_data;
	
	assign o_data=(i_sel==0) ? i_data1 : i_data2;
	
endmodule //End of module