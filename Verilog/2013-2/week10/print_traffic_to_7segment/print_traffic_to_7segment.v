///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Traffic light controller with 7Segment
//FILE : print_traffic_to_7segment.v
//TESTBENCH : tb_print_traffic_to_7segment.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Traffic light controller with 7Segment
//LAST UPDATE : Nov. 11, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module print_traffic_to_7segment(clk,reset_n,Ta,Tb,dec_out); //Module of Traffic light controller with 7Segment
	input clk,reset_n,Ta,Tb; //clk: clock pulse; //reset_n : reset switch; //Ta,Tb : Traffic
	output [27:0] dec_out; //output with 7segment
	
	wire [1:0] w_La; //wire of Light A
	wire [1:0] w_Lb; //wire of Light B
	
	tl_cntr U0_cntr(.clk(clk),.reset_n(reset_n),.Ta(Ta),.Tb(Tb),.La(w_La),.Lb(w_Lb)); //Traffic light controller
	seg_dec U1_seg_dec(.iHex({3'b0,w_La[1]}),.oSEG7(dec_out[27:21])); //output Light A with 7segment
	seg_dec U2_seg_dec(.iHex({3'b0,w_La[0]}),.oSEG7(dec_out[20:14]));
	seg_dec U3_seg_dec(.iHex({3'b0,w_Lb[1]}),.oSEG7(dec_out[13:7])); //output Light B with 7segment
	seg_dec U4_seg_dec(.iHex({3'b0,w_Lb[0]}),.oSEG7(dec_out[6:0]));

endmodule //End of module