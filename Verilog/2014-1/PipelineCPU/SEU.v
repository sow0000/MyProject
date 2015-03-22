////////////////////////////////////////////////////////////////
//	TITLE : Sign Extension Unit
//	FILE : SEU.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering	
//	STUDENT ID : 2010720092, 2010720117	
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim	
//	PLATFORM : Windows 7	
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines Sign Extension Unit.	
//								Make a 16 bit input to 32 bit output.
//	LAST UPDATE : 04.07, 2014	
////////////////////////////////////////////////////////////////
module SEU(i_halfword,o_word);
	input [15:0] i_halfword;
	output [31:0] o_word;
	
	wire [15:0] sign;
	
	// Use and gate check a input sign
	assign sign[0]=i_halfword[15]&1'b1;
	assign sign[1]=i_halfword[15]&1'b1;
	assign sign[2]=i_halfword[15]&1'b1;
	assign sign[3]=i_halfword[15]&1'b1;
	assign sign[4]=i_halfword[15]&1'b1;
	assign sign[5]=i_halfword[15]&1'b1;
	assign sign[6]=i_halfword[15]&1'b1;
	assign sign[7]=i_halfword[15]&1'b1;
	assign sign[8]=i_halfword[15]&1'b1;
	assign sign[9]=i_halfword[15]&1'b1;
	assign sign[10]=i_halfword[15]&1'b1;
	assign sign[11]=i_halfword[15]&1'b1;
	assign sign[12]=i_halfword[15]&1'b1;
	assign sign[13]=i_halfword[15]&1'b1;
	assign sign[14]=i_halfword[15]&1'b1;
	assign sign[15]=i_halfword[15]&1'b1;

	// output is 16 bit sign + 16 bit input 
	assign o_word={sign, i_halfword};
	
endmodule
