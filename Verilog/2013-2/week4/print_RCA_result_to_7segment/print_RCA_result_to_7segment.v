///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Print RCA result to 7segment
//FILE : print_RCA_result_to_7segment.v
//TESTBENCH : tb_print_RCA_result_to_7segment.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines print out RCA result to 7segment. 
//LAST UPDATE : Sep. 29, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module print_RCA_result_to_7segment(a, b, cin, dec_out); //Module of print_RCA_result_to_7segment
	input [3:0] a,b; //a,b : Variable of input binary number
	input cin; //ci : Variable of input carry value for full adder
	output [13:0] dec_out; //dec_out : Output port fot result to 7segment
	
	wire [3:0] s; //s : Wire for internal result
	wire c; //c : Wire for internal carry
	
	RippleCarryAdder U0_RippleCarryAdder(.a(a),.b(b),.ci(cin),.s(s),.co(c)); //Calculate a and b use ripple carry adder
	seg_dec U1_seg_dec(.iHex(s), .oSEG7(dec_out[6:0])); //Transfer result to second 7segment
	seg_dec U2_seg_dec(.iHex({3'b000,c}), .oSEG7(dec_out[13:7])); //If there is carry in result, print out "1" to first 7segment
	
endmodule //End of module