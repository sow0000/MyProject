///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Booth selector
//FILE : booth_sel.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Booth selector
//LAST UPDATE : Dec. 01, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module booth_sel(B_operation,multiplicand,op_code,B_multiplicand,next_multiplicand); //module of Booth selector
	input [2:0] B_operation; //booth operation
	input [127:0] multiplicand; //input multiplicand
	output reg op_code; //operation code
	output [127:0] B_multiplicand,next_multiplicand; //selected multiplicand, shifted next multiplicand
	
	reg [31:0] B_multiplicand0,B_multiplicand1,B_multiplicand2,B_multiplicand3; //32-bit register of booth multiplicand
	
	parameter ZERO=3'b000; //add 0
	parameter ADD1=3'b001; //add 1
	parameter SUB1=3'b010; //sub 1
	parameter ADD2=3'b011; //add 2
	parameter SUB2=3'b100; //sub 2
	
	assign B_multiplicand={B_multiplicand3,B_multiplicand2,B_multiplicand1,B_multiplicand0}; //booth multiplicand
	assign next_multiplicand={multiplicand[125:0],2'b00}; //shift 2 bits
	
	always@(B_operation,multiplicand)
	begin
	case(B_operation)
		ZERO :  //add 0
		begin
			op_code=1'b0; //add
			B_multiplicand0=32'h00;
			B_multiplicand1=32'h00;
			B_multiplicand2=32'h00;
			B_multiplicand3=32'h00;
		end
		ADD1 : //add multiplicand x 1
		begin
			op_code=1'b0; //add
			B_multiplicand0=multiplicand[31:0];
			B_multiplicand1=multiplicand[63:32];
			B_multiplicand2=multiplicand[95:64];
			B_multiplicand3=multiplicand[127:96];
		end
		SUB1 : //sub multiplicand x 1
		begin
			op_code=1'b1; //sub
			B_multiplicand0=~multiplicand[31:0]; //invert
			B_multiplicand1=~multiplicand[63:32];
			B_multiplicand2=~multiplicand[95:64];
			B_multiplicand3=~multiplicand[127:96];
		end
		ADD2 : //add multiplicand x 2
		begin
			op_code=1'b0; //add
			B_multiplicand0={multiplicand[30:0],1'b0}; //shift 1 bit
			B_multiplicand1=multiplicand[62:31];
			B_multiplicand2=multiplicand[94:63];
			B_multiplicand3=multiplicand[126:95];
		end
		SUB2 : //sub multiplicand x 2
		begin
			op_code=1'b1; //sub
			B_multiplicand0=~{multiplicand[30:0],1'b0}; //invert and shift 1 bit
			B_multiplicand1=~multiplicand[62:31];
			B_multiplicand2=~multiplicand[94:63];
			B_multiplicand3=~multiplicand[126:95];
		end
		default : //default 0
		begin
			op_code=1'b0; //add
			B_multiplicand0=32'h00;
			B_multiplicand1=32'h00;
			B_multiplicand2=32'h00;
			B_multiplicand3=32'h00;
		end
	endcase
	end
endmodule //End of module