////////////////////////////////////////////////////////////////
//	TITLE : Register File
//	FILE : RF.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering	
//	STUDENT ID : 2010720092, 2010720117	
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim	
//	PLATFORM : Windows 7	
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines Register File.	
//								Use two 32to1 MUX, 5to32 decoder, 32 bit Register.
//	LAST UPDATE : 04.07, 2014	
////////////////////////////////////////////////////////////////

module RF(i_Write_reg,RegWrite,i_Write_data,i_rst_n,i_clk,i_Read_reg1,i_Read_reg2,o_Read_data1,o_Read_data2);
	input RegWrite,i_rst_n,i_clk;
	input [4:0] i_Write_reg,i_Read_reg1,i_Read_reg2;
	input [31:0] i_Write_data;
	output [31:0] o_Read_data1,o_Read_data2;
	
	wire [31:0] w_dec0,w_dec1,
					w_reg0,w_reg1,w_reg2,w_reg3,w_reg4,w_reg5,w_reg6,w_reg7,w_reg8,w_reg9,w_reg10,w_reg11,
					w_reg12,w_reg13,w_reg14,w_reg15,w_reg16,w_reg17,w_reg18,w_reg19,w_reg20,w_reg21,
					w_reg22,w_reg23,w_reg24,w_reg25,w_reg26,w_reg27,w_reg28,w_reg29,w_reg30,w_reg31;
	
	// decoder result AND Write signal
	assign w_dec1[31:0]=w_dec0[31:0]&{RegWrite,RegWrite,RegWrite,RegWrite,RegWrite,RegWrite,RegWrite,RegWrite,
												RegWrite,RegWrite,RegWrite,RegWrite,RegWrite,RegWrite,RegWrite,RegWrite,
												RegWrite,RegWrite,RegWrite,RegWrite,RegWrite,RegWrite,RegWrite,RegWrite,
												RegWrite,RegWrite,RegWrite,RegWrite,RegWrite,RegWrite,RegWrite,RegWrite};
	
	// 32to1 MUX by i_Read_reg1, output is o_Read_data1
	MUX32_1 U0_MUX32_1(.i_data0(w_reg0),.i_data1(w_reg1),.i_data2(w_reg2),.i_data3(w_reg3),.i_data4(w_reg4),.i_data5(w_reg5),
						.i_data6(w_reg6),.i_data7(w_reg7),.i_data8(w_reg8),.i_data9(w_reg9),.i_data10(w_reg10),.i_data11(w_reg11),
						.i_data12(w_reg12),.i_data13(w_reg13),.i_data14(w_reg14),.i_data15(w_reg15),.i_data16(w_reg16),.i_data17(w_reg17),
						.i_data18(w_reg18),.i_data19(w_reg19),.i_data20(w_reg20),.i_data21(w_reg21),.i_data22(w_reg22),.i_data23(w_reg23),
						.i_data24(w_reg24),.i_data25(w_reg25),.i_data26(w_reg26),.i_data27(w_reg27),.i_data28(w_reg28),.i_data29(w_reg29),
						.i_data30(w_reg30),.i_data31(w_reg31),.sel(i_Read_reg1),.o_data(o_Read_data1));
	 
	// 32to1 MUX by i_Read_reg2, output is o_Read_data2
	MUX32_1 U1_MUX32_1(.i_data0(w_reg0),.i_data1(w_reg1),.i_data2(w_reg2),.i_data3(w_reg3),.i_data4(w_reg4),.i_data5(w_reg5),
						.i_data6(w_reg6),.i_data7(w_reg7),.i_data8(w_reg8),.i_data9(w_reg9),.i_data10(w_reg10),.i_data11(w_reg11),
						.i_data12(w_reg12),.i_data13(w_reg13),.i_data14(w_reg14),.i_data15(w_reg15),.i_data16(w_reg16),.i_data17(w_reg17),
						.i_data18(w_reg18),.i_data19(w_reg19),.i_data20(w_reg20),.i_data21(w_reg21),.i_data22(w_reg22),.i_data23(w_reg23),
						.i_data24(w_reg24),.i_data25(w_reg25),.i_data26(w_reg26),.i_data27(w_reg27),.i_data28(w_reg28),.i_data29(w_reg29),
						.i_data30(w_reg30),.i_data31(w_reg31),.sel(i_Read_reg2),.o_data(o_Read_data2));
	
	// thirty two 32bit Register
	_register32 U2_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[0]),.d(i_Write_data),.q(w_reg0));
	_register32 U3_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[1]),.d(i_Write_data),.q(w_reg1));
	_register32 U4_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[2]),.d(i_Write_data),.q(w_reg2));
	_register32 U5_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[3]),.d(i_Write_data),.q(w_reg3));
	_register32 U6_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[4]),.d(i_Write_data),.q(w_reg4));
	_register32 U7_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[5]),.d(i_Write_data),.q(w_reg5));
	_register32 U8_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[6]),.d(i_Write_data),.q(w_reg6));
	_register32 U9_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[7]),.d(i_Write_data),.q(w_reg7));
	_register32 U10_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[8]),.d(i_Write_data),.q(w_reg8));
	_register32 U11_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[9]),.d(i_Write_data),.q(w_reg9));
	_register32 U12_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[10]),.d(i_Write_data),.q(w_reg10));
	_register32 U13_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[11]),.d(i_Write_data),.q(w_reg11));
	_register32 U14_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[12]),.d(i_Write_data),.q(w_reg12));
	_register32 U15_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[13]),.d(i_Write_data),.q(w_reg13));
	_register32 U16_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[14]),.d(i_Write_data),.q(w_reg14));
	_register32 U17_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[15]),.d(i_Write_data),.q(w_reg15));
	_register32 U18_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[16]),.d(i_Write_data),.q(w_reg16));
	_register32 U19_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[17]),.d(i_Write_data),.q(w_reg17));
	_register32 U20_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[18]),.d(i_Write_data),.q(w_reg18));
	_register32 U21_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[19]),.d(i_Write_data),.q(w_reg19));
	_register32 U22_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[20]),.d(i_Write_data),.q(w_reg20));
	_register32 U23_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[21]),.d(i_Write_data),.q(w_reg21));
	_register32 U24_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[22]),.d(i_Write_data),.q(w_reg22));
	_register32 U25_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[23]),.d(i_Write_data),.q(w_reg23));
	_register32 U26_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[24]),.d(i_Write_data),.q(w_reg24));
	_register32 U27_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[25]),.d(i_Write_data),.q(w_reg25));
	_register32 U28_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[26]),.d(i_Write_data),.q(w_reg26));
	_register32 U29_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[27]),.d(i_Write_data),.q(w_reg27));
	_register32 U30_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[28]),.d(i_Write_data),.q(w_reg28));
	_register32 U31_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[29]),.d(i_Write_data),.q(w_reg29));
	_register32 U32_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[30]),.d(i_Write_data),.q(w_reg30));
	_register32 U33_register32(.clk(i_clk),.reset_n(i_rst_n),.en(w_dec1[31]),.d(i_Write_data),.q(w_reg31));
	
	// 5to32 Decoder by i_Write_reg value
	dec532 U34_dec532(.a(i_Write_reg),.y(w_dec0));
	
endmodule

//Module of 5-to-32 decoder
module dec532(a,y);
	input [4:0] a;
	output reg [32:0] y;
	
	// Use case function, insert each 32 bit value
	always@(a)
	begin
	case(a)
		5'b00000 : y <= 32'b00000000_00000000_00000000_00000001;
		5'b00001 : y <= 32'b00000000_00000000_00000000_00000010;
		5'b00010 : y <= 32'b00000000_00000000_00000000_00000100;
		5'b00011 : y <= 32'b00000000_00000000_00000000_00001000;
		5'b00100 : y <= 32'b00000000_00000000_00000000_00010000; 
		5'b00101 : y <= 32'b00000000_00000000_00000000_00100000; 
		5'b00110 : y <= 32'b00000000_00000000_00000000_01000000; 
		5'b00111 : y <= 32'b00000000_00000000_00000000_10000000; 
		5'b01000 : y <= 32'b00000000_00000000_00000001_00000000; 
		5'b01001 : y <= 32'b00000000_00000000_00000010_00000000; 
		5'b01010 : y <= 32'b00000000_00000000_00000100_00000000; 
		5'b01011 : y <= 32'b00000000_00000000_00001000_00000000; 
		5'b01100 : y <= 32'b00000000_00000000_00010000_00000000; 
		5'b01101 : y <= 32'b00000000_00000000_00100000_00000000;
		5'b01110 : y <= 32'b00000000_00000000_01000000_00000000;
		5'b01111 : y <= 32'b00000000_00000000_10000000_00000000;
		5'b10000 : y <= 32'b00000000_00000001_00000000_00000000;
		5'b10001 : y <= 32'b00000000_00000010_00000000_00000000;
		5'b10010 : y <= 32'b00000000_00000100_00000000_00000000;
		5'b10011 : y <= 32'b00000000_00001000_00000000_00000000;
		5'b10100 : y <= 32'b00000000_00010000_00000000_00000000;
		5'b10101 : y <= 32'b00000000_00100000_00000000_00000000;
		5'b10110 : y <= 32'b00000000_01000000_00000000_00000000;
		5'b10111 : y <= 32'b00000000_10000000_00000000_00000000;
		5'b11000 : y <= 32'b00000001_00000000_00000000_00000000;
		5'b11001 : y <= 32'b00000010_00000000_00000000_00000000;
		5'b11010 : y <= 32'b00000100_00000000_00000000_00000000;
		5'b11011 : y <= 32'b00001000_00000000_00000000_00000000;
		5'b11100 : y <= 32'b00010000_00000000_00000000_00000000;
		5'b11101 : y <= 32'b00100000_00000000_00000000_00000000;
		5'b11110 : y <= 32'b01000000_00000000_00000000_00000000;
		5'b11111 : y <= 32'b10000000_00000000_00000000_00000000;
	endcase
	end
	
endmodule//End of module