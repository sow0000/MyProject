////////////////////////////////////////////////////////////////
//	TITLE : Multiplexer
//	FILE : MUX.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering	
//	STUDENT ID : 2010720092, 2010720117	
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim	
//	PLATFORM : Windows 7	
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines each Multiplexer.
//								32-bit 32-to-1 Mux, 5-bit 2-to-1 Mux, 32-bit 2-to-1 Mux, 4-to-1 Mux, 3-to-1 Mux.
//						 		Total Five Multiplexer.
//	LAST UPDATE : 04.28, 2014	
////////////////////////////////////////////////////////////////

//32-bit 32-to-1 Multiplexer
module MUX32_1(i_data0,i_data1,i_data2,i_data3,i_data4,i_data5,i_data6,i_data7,i_data8,i_data9,i_data10,i_data11,i_data12,i_data13,i_data14,i_data15,i_data16,i_data17,i_data18,i_data19,i_data20,i_data21,i_data22,i_data23,i_data24,i_data25,i_data26,i_data27,i_data28,i_data29,i_data30,i_data31,sel,o_data);
	input [31:0] i_data0,i_data1,i_data2,i_data3,i_data4,i_data5,i_data6,i_data7,i_data8,i_data9,i_data10,i_data11,i_data12,i_data13,i_data14,i_data15,i_data16,i_data17,i_data18,i_data19,i_data20,i_data21,i_data22,i_data23,i_data24,i_data25,i_data26,i_data27,i_data28,i_data29,i_data30,i_data31;
	input [4:0] sel;
	output [31:0] o_data;
	wire [31:0] w_data1,w_data2,w_data3,w_data4,w_data5,w_data6,w_data7,w_data8,w_data9,w_data10,w_data11,w_data12,w_data13,w_data14,w_data15,w_data16,w_data17,w_data18,w_data19,w_data20,w_data21,w_data22,w_data23,w_data24,w_data25,w_data26,w_data27,w_data28,w_data29,w_data30;
	
	assign w_data1=(sel[0]==0) ? i_data0 : i_data1;
	assign w_data2=(sel[0]==0) ? i_data2 : i_data3;
	assign w_data3=(sel[0]==0) ? i_data4 : i_data5;
	assign w_data4=(sel[0]==0) ? i_data6 : i_data7;
	assign w_data5=(sel[0]==0) ? i_data8 : i_data9;
	assign w_data6=(sel[0]==0) ? i_data10 : i_data11;
	assign w_data7=(sel[0]==0) ? i_data12 : i_data13;
	assign w_data8=(sel[0]==0) ? i_data14 : i_data15;
	assign w_data9=(sel[0]==0) ? i_data16 : i_data17;
	assign w_data10=(sel[0]==0) ? i_data18 : i_data19;
	assign w_data11=(sel[0]==0) ? i_data20 : i_data21;
	assign w_data12=(sel[0]==0) ? i_data22 : i_data23;
	assign w_data13=(sel[0]==0) ? i_data24 : i_data25;
	assign w_data14=(sel[0]==0) ? i_data26 : i_data27;
	assign w_data15=(sel[0]==0) ? i_data28 : i_data29;
	assign w_data16=(sel[0]==0) ? i_data30 : i_data31;
	
	assign w_data17=(sel[1]==0) ? w_data1 : w_data2;
	assign w_data18=(sel[1]==0) ? w_data3 : w_data4;
	assign w_data19=(sel[1]==0) ? w_data5 : w_data6;
	assign w_data20=(sel[1]==0) ? w_data7 : w_data8;
	assign w_data21=(sel[1]==0) ? w_data9 : w_data10;
	assign w_data22=(sel[1]==0) ? w_data11 : w_data12;
	assign w_data23=(sel[1]==0) ? w_data13 : w_data14;
	assign w_data24=(sel[1]==0) ? w_data15 : w_data16;
	
	assign w_data25=(sel[2]==0) ? w_data17 : w_data18;
	assign w_data26=(sel[2]==0) ? w_data19 : w_data20;
	assign w_data27=(sel[2]==0) ? w_data21 : w_data22;
	assign w_data28=(sel[2]==0) ? w_data23 : w_data24;
	
	assign w_data29=(sel[3]==0) ? w_data25 : w_data26;
	assign w_data30=(sel[3]==0) ? w_data27 : w_data28;
	
	assign o_data=(sel[4]==0) ? w_data29 : w_data30;
	
endmodule //End of module

//32bits 4-to-1 multiplexer
module MUX4_1(i_data1,i_data2,i_data3,i_data4,sel,o_data);
	input [31:0] i_data1,i_data2,i_data3,i_data4;
	input [1:0] sel;
	output [31:0] o_data;
	
	wire [31:0] w_data1,w_data2;
	
	assign w_data1=(sel[0]==0) ? i_data1 : i_data2;
	assign w_data2=(sel[0]==0) ? i_data3 : i_data4;
	assign o_data=(sel[1]==0) ? w_data1 : w_data2;
	
endmodule //End of module

//32bits 3-to-1 multiplexer
module MUX3_1(i_data1,i_data2,i_data3,sel,o_data);
	input [31:0] i_data1,i_data2,i_data3;
	input [1:0] sel;
	output [31:0] o_data;
	
	wire [31:0] w_data1,w_data2;
	
	assign w_data1=(sel[0]==0) ? i_data1 : i_data2;
	assign o_data=(sel[1]==0) ? w_data1 : i_data3;
	
endmodule //End of module

//32bits 2-to-1 multiplexer
module MUX2_1(i_data1,i_data2,sel,o_data);
	input [31:0] i_data1,i_data2;
	input sel;
	output [31:0] o_data;
	
	assign o_data=(sel==0) ? i_data1 : i_data2;
	
endmodule //End of module

//5bits 2-to-1 multiplexer
module MUX2_1_5bits(i_data1,i_data2,sel,o_data);
	input [4:0] i_data1,i_data2;
	input sel;
	output [4:0] o_data;
	
	assign o_data=(sel==0) ? i_data1 : i_data2;
	
endmodule //End of module