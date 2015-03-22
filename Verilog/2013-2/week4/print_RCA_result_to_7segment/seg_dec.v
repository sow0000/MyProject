///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Seven segment
//FILE : seg_dec.v
//TESTBENCH : tb_seg_dec.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Seven segment. 
//LAST UPDATE : Sep. 29, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module seg_dec(iHex, oSEG7); //Module of Seven segment
	input [3:0] iHex; //iHex : Variable for input hexadecimal number
	output reg [6:0] oSEG7; //oSEG7 : Output port for seven segment
	
	always @ (iHex) //If iHex has changed, do this operation
	begin //Start of always
	case (iHex) //start case statement with condition iHex
      4'h0 : oSEG7=7'b1000000; //if iHex is 0, input 1000000 into oSEG7
      4'h1 : oSEG7=7'b1111001; //if iHex is 1, input 1111001 into oSEG7
      4'h2 : oSEG7=7'b0100100; //if iHex is 2, input 0100100 into oSEG7
      4'h3 : oSEG7=7'b0110000; //if iHex is 3, input 0110000 into oSEG7
      4'h4 : oSEG7=7'b0011001; //if iHex is 4, input 0011001 into oSEG7
      4'h5 : oSEG7=7'b0010010; //if iHex is 5, input 0010010 into oSEG7
      4'h6 : oSEG7=7'b0000010; //if iHex is 6, input 0000010 into oSEG7
      4'h7 : oSEG7=7'b1111000; //if iHex is 7, input 1111000 into oSEG7
      4'h8 : oSEG7=7'b0000000; //if iHex is 8, input 0000000 into oSEG7
      4'h9 : oSEG7=7'b0011000; //if iHex is 9, input 0011000 into oSEG7
      4'ha : oSEG7=7'b0001000; //if iHex is a, input 0001000 into oSEG7
      4'hb : oSEG7=7'b0000011; //if iHex is b, input 0000011 into oSEG7
      4'hc : oSEG7=7'b1000110; //if iHex is c, input 1000110 into oSEG7
      4'hd : oSEG7=7'b0100001; //if iHex is d, input 0100001 into oSEG7
      4'he : oSEG7=7'b0000110; //if iHex is e, input 0000110 into oSEG7
      4'hf : oSEG7=7'b0001110; //if iHex is f, input 0001110 into oSEG7
    endcase //end case statement
	end //End of always
endmodule //End of module