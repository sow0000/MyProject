module Fact_os_logic(state,op_done,S_grant,M_din,M_req,M_wr,M_address,N_value,M_dout,result);
	input [3:0] state;
	input [31:0] M_din,N_value;
	output reg op_done,S_grant,M_req,M_wr;
	output reg [7:0] M_address;
	output reg [31:0] M_dout;
	output [63:0] result;

	reg [31:0] reg_N_value,result0,result1;
	
	wire [31:0] next_N_value;
	
	parameter IDLE=4'b0000;
	parameter DONE=4'b0001;
	parameter CHK_N=4'b0010;
	parameter GRANT=4'b0011;
	parameter CHK_S=4'b0100;
	parameter BUSY=4'b0101;
	parameter SEND_N1=4'b0110;
	parameter SEND_N2=4'b0111;
	parameter SEND_N3=4'b1000;
	parameter SEND_N4=4'b1001;
	parameter SEND_IE=4'b1010;
	parameter SEND_OP=4'b1011;
	parameter WAIT=4'b1100;
	parameter READ_R1=4'b1101;
	parameter READ_R2=4'b1110;
	parameter SEND_CR=4'b1111;
	
	assign result={result1,result0};
	
	always@(state)
	begin
	case(state)
		IDLE :
		begin
			op_done=1'b0;
			S_grant=1'b0;
			result0=32'h00;
			result1=N_value;
			reg_N_value=N_value;
		end
		DONE :
		begin
			op_done=1'b0;
			S_grant=1'b0;
		end
		CHK_N :
		begin
		reg_N_value=next_N_value;
		case(reg_N_value)
			32'h00 : 
			begin
				op_done=1'b1;
				result0<=32'h01;
				result1<=32'h00;
			end
			32'h01 :	op_done=1'b1;
			default : op_done=1'b0;
		endcase
		end
		GRANT : M_req=1'b1;
		CHK_S :
		begin
			M_wr=1'b0;
			M_address=8'h29;
			case(M_din[0])
				32'h00 : S_grant=1'b1;
				default : S_grant=1'b0;
			endcase
		end
		BUSY : M_req=1'b0;
		SEND_N1 :
		begin
			M_wr=1'b1;
			M_address=8'h20;
			M_dout=result0;
		end
		SEND_N2 :
		begin
			M_wr=1'b1;
			M_address=8'h21;
			M_dout=result1;
		end
		SEND_N3 :
		begin
			M_wr=1'b1;
			M_address=8'h22;
			M_dout=reg_N_value;
		end
		SEND_N4 :
		begin
			M_wr=1'b1;
			M_address=8'h23;
			M_dout=32'h00;
		end
		SEND_IE :
		begin
			M_wr=1'b1;
			M_address=8'h28;
			M_dout=32'h01;
		end
		SEND_OP :
		begin
			M_wr=1'b1;
			M_address=8'h28;
			M_dout=32'h01;
		end
		WAIT : S_grant=1'b0;
		READ_R1 :
		begin
			M_wr=1'b0;
			M_address=8'h24;
			result0=M_din;
		end
		READ_R2 :
		begin
			M_wr=1'b0;
			M_address=8'h25;
			result1=M_din;
		end
		SEND_CR :
		begin
			M_wr=1'b1;
			M_address=8'h2B;
			M_dout=32'h01;
		end
	endcase
	end
	
	cla32 U0_cla32(.a(reg_N_value),.b(32'hFFFF_FFFF),.ci(1'b0),.s(next_N_value));
	
endmodule //End of module