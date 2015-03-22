module booth_sel(B_operation,multiplicand,op_code,B_multiplicand,next_multiplicand);
	input [2:0] B_operation;
	input [127:0] multiplicand;
	output reg op_code;
	output [127:0] B_multiplicand,next_multiplicand;
	
	reg [31:0] B_multiplicand0,B_multiplicand1,B_multiplicand2,B_multiplicand3;
	
	parameter ZERO=3'b000;
	parameter ADD1=3'b001;
	parameter SUB1=3'b010;
	parameter ADD2=3'b011;
	parameter SUB2=3'b100;
	
	assign B_multiplicand={B_multiplicand3,B_multiplicand2,B_multiplicand1,B_multiplicand0};
	assign next_multiplicand={multiplicand[125:0],2'b00};
	
	always@(B_operation,multiplicand)
	begin
	case(B_operation)
		ZERO : 
		begin
			op_code=1'b0;
			B_multiplicand0=32'h00;
			B_multiplicand1=32'h00;
			B_multiplicand2=32'h00;
			B_multiplicand3=32'h00;
		end
		ADD1 :
		begin
			op_code=1'b0;
			B_multiplicand0=multiplicand[31:0];
			B_multiplicand1=multiplicand[63:32];
			B_multiplicand2=multiplicand[95:64];
			B_multiplicand3=multiplicand[127:96];
		end
		SUB1 :
		begin
			op_code=1'b1;
			B_multiplicand0=~multiplicand[31:0];
			B_multiplicand1=~multiplicand[63:32];
			B_multiplicand2=~multiplicand[95:64];
			B_multiplicand3=~multiplicand[127:96];
		end
		ADD2 :
		begin
			op_code=1'b0;
			B_multiplicand0={multiplicand[30:0],1'b0};
			B_multiplicand1=multiplicand[62:31];
			B_multiplicand2=multiplicand[94:63];
			B_multiplicand3=multiplicand[126:95];
		end
		SUB2 :
		begin
			op_code=1'b1;
			B_multiplicand0=~{multiplicand[30:0],1'b0};
			B_multiplicand1=~multiplicand[62:31];
			B_multiplicand2=~multiplicand[94:63];
			B_multiplicand3=~multiplicand[126:95];
		end
		default :
		begin
			op_code=1'b0;
			B_multiplicand0=32'h00;
			B_multiplicand1=32'h00;
			B_multiplicand2=32'h00;
			B_multiplicand3=32'h00;
		end
	endcase
	end
endmodule //End of module