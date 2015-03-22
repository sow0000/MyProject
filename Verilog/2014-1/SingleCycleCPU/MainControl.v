////////////////////////////////////////////////////////////////
//	TITLE : Main Control
//	FILE : MainControl.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering
//	STUDENT ID : 2010720092, 2010720117
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim		
//	PLATFORM : Windows 7
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines Main Control.	
//								Use case function, operate each module.
//	LAST UPDATE : 04.07, 2014
////////////////////////////////////////////////////////////////
module MainControl(op,RegDst,Jump,Branch,MemRead,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite);
	input [5:0] op;
	output reg RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;
	output reg [1:0] ALUOp;
	
	// Use case function, operate each module by opcode.
	always@(op)
	begin
	case(op)
		6'b000000 : // instruction is R-format 
		begin
			RegDst<=1'b1;
			ALUSrc<=1'b0;
			MemtoReg<=1'b0;
			RegWrite<=1'b1;
			MemRead<=1'b0;
			MemWrite<=1'b0;
			Branch<=1'b0;
			Jump<=1'b0;
			ALUOp<=2'b10;
		end
		6'b100011 : // instruction is lw
		begin
			RegDst<=1'b0;
			ALUSrc<=1'b1;
			MemtoReg<=1'b1;
			RegWrite<=1'b1;
			MemRead<=1'b1;
			MemWrite<=1'b0;
			Branch<=1'b0;
			Jump<=1'b0;
			ALUOp<=2'b00;
		end
		6'b101011 : // instruction is sw
		begin
			RegDst<=1'bx;
			ALUSrc<=1'b1;
			MemtoReg<=1'bx;
			RegWrite<=1'b0;
			MemRead<=1'b0;
			MemWrite<=1'b1;
			Branch<=1'b0;
			Jump<=1'b0;
			ALUOp<=2'b00;
		end
		6'b000100 : // instruction is beq
		begin
			RegDst<=1'bx;
			ALUSrc<=1'b0;
			MemtoReg<=1'bx;
			RegWrite<=1'b0;
			MemRead<=1'b0;
			MemWrite<=1'b0;
			Branch<=1'b1;
			Jump<=1'b0;
			ALUOp<=2'b01;
		end
		6'b000010 : // instruction is j
		begin
			RegDst<=1'bx;
			ALUSrc<=1'bx;
			MemtoReg<=1'bx;
			RegWrite<=1'b0;
			MemRead<=1'b0;
			MemWrite<=1'b0;
			Branch<=1'b0;
			Jump<=1'b1;
			ALUOp<=2'bxx;
		end
		default : // else
		begin
			RegDst<=1'bx;
			ALUSrc<=1'bx;
			MemtoReg<=1'bx;
			RegWrite<=1'bx;
			MemRead<=1'bx;
			MemWrite<=1'bx;
			Branch<=1'bx;
			Jump<=1'bx;
			ALUOp<=2'bxx;
		end
	endcase
	end
	
endmodule //end of module