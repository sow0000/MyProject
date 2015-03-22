///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Factorial Output state logic
//FILE : fact_os_logic.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Factorial Output state logic
//LAST UPDATE : DEC, 01, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module fact_os_logic(state,op_done,S_grant,M_din,M_req,M_wr,M_address,N_value,M_dout,result,next_result,next_N_value); //module of Factorial Output state logic
	input [4:0] state; //state
	input [31:0] M_din,N_value; //master input, N value
	input [63:0] result; //current result
	output reg op_done,S_grant,M_req,M_wr; //operation doen, multiplier state, master requirement, master write/read
	output reg [7:0] M_address; //master address
	output reg [31:0] next_N_value,M_dout; //next N value, master output
	output [63:0] next_result; //next result

	reg [31:0] result0,result1; //32-bit register of reasult
	
	wire [31:0] w_N_value; //wire of N value
	
	parameter IDLE=5'b00000; //idle
	parameter DONE=5'b00001; //operation done
	parameter START=5'b00010; //operation start
	parameter NEXT_N=5'b00011; //calculate next N
	parameter CHK_N=5'b00100; //check N
	parameter GRANT=5'b00101; //require grant
	parameter CHK_S1=5'b00110; //check multiplier state
	parameter CHK_S2=5'b00111; //check multiplier state
	parameter BUSY=5'b01000; //multiplier is not idle
	parameter SEND_N1=5'b01001; //input N[31:0]
	parameter SEND_N2=5'b01010; //input N[63:32]
	parameter SEND_N3=5'b01011; //input N-1[31:0]
	parameter SEND_N4=5'b01100; //input N-1[63:32]
	parameter SEND_IE=5'b01101; //input interrupt enable
	parameter SEND_OP=5'b01110; //input operation start
	parameter WAIT=5'b01111; //multiplier operating
	parameter READ_R1=5'b10000; //read result[31:0]
	parameter READ_R2=5'b10001; //read result[63:32]
	parameter SEND_CR=5'b10010; //input operation clear
	
	assign next_result={result1,result0}; //result
	
	always@(state)
	begin
	case(state)
		IDLE :
		begin
			op_done<=1'b0; //initialize
			S_grant<=1'b0;
			M_req<=1'b0;
			M_wr<=1'b0;
			M_address<=8'h00;
			M_dout<=32'h00;
			result0<=32'h00;
			result1<=32'h00;
			next_N_value<=32'h00;
		end
		DONE :
		begin
			op_done<=1'b0; //initialize
			S_grant<=1'b0;
			M_req<=1'b0;
			M_wr<=1'b0;
			M_address<=8'h00;
			M_dout<=32'h00;
			result0<=result[31:0];
			result1<=result[63:32];
			next_N_value<=32'h00;
		end
		START :
		begin
			op_done<=1'b0;
			S_grant<=1'b0;
			M_req<=1'b0;
			M_wr<=1'b0;
			M_address<=8'h00;
			M_dout<=32'h00;
			result0<=N_value; //set N value
			result1<=result[63:32];
			next_N_value<=N_value; //set N-1
		end
		NEXT_N :
		begin
			op_done<=1'b0;
			S_grant<=1'b0;
			M_req<=1'b0;
			M_wr<=1'b0;
			M_address<=8'h00;
			M_dout<=32'h00;
			result0<=result[31:0];
			result1<=result[63:32];
			next_N_value<=w_N_value; //N=N-1
		end
		CHK_N :
		begin
		case(N_value)
			32'h00 : //N=0
			begin
				op_done<=1'b1; //result=1
				S_grant<=1'b0;
				M_req<=1'b0;
				M_wr<=1'b0;
				M_address<=8'h00;
				M_dout<=32'h00;
				result0<=32'h01;
				result1<=32'h00;
				next_N_value<=N_value;
			end
			32'h01 :
			begin
				op_done<=1'b1; //N=1
				S_grant<=1'b0;
				M_req<=1'b0;
				M_wr<=1'b0;
				M_address<=8'h00;
				M_dout<=32'h00;
				result0<=result[31:0];
				result1<=result[63:32];
				next_N_value<=N_value;
			end
			default :
			begin
				op_done<=1'b0;
				S_grant<=1'b0;
				M_req<=1'b0;
				M_wr<=1'b0;
				M_address<=8'h00;
				M_dout<=32'h00;
				result0<=result[31:0];
				result1<=result[63:32];
				next_N_value<=N_value;
			end
		endcase
		end
		GRANT :
		begin
			op_done<=1'b0;
			S_grant<=1'b0;
			M_req<=1'b1; //require grant
			M_wr<=1'b0;
			M_address<=8'h00;
			M_dout<=32'h00;
			result0<=result[31:0];
			result1<=result[63:32];
			next_N_value<=N_value;
		end
		CHK_S1 :
		begin
			op_done<=1'b0;
			S_grant<=1'b0;
			M_req<=1'b1;
			M_wr<=1'b0; //read state of multiplier
			M_address<=8'h49;
			M_dout<=32'h00;
			result0<=result[31:0];
			result1<=result[63:32];
			next_N_value<=N_value;
		end
		CHK_S2 :
		begin
		case(M_din[0])
			32'h00 : 
			begin
				op_done<=1'b0;
				S_grant<=1'b1; //multiplier is idle
				M_req<=1'b1;
				M_wr<=1'b0;
				M_address<=8'h00;
				M_dout<=32'h00;
				result0<=result[31:0];
				result1<=result[63:32];
				next_N_value<=N_value;
			end
			default :
			begin
				op_done<=1'b0;
				S_grant<=1'b0; //operating
				M_req<=1'b1;
				M_wr<=1'b0;
				M_address<=8'h00;
				M_dout<=32'h00;
				result0<=result[31:0];
				result1<=result[63:32];
				next_N_value<=N_value;
			end
		endcase
		end
		BUSY :
		begin
			op_done<=1'b0;
			S_grant<=1'b0;
			M_req<=1'b0; //multiplier is operating
			M_wr<=1'b0;
			M_address<=8'h00;
			M_dout<=32'h00;
			result0<=result[31:0];
			result1<=result[63:32];
			next_N_value<=N_value;
		end
		SEND_N1 :
		begin
			op_done<=1'b0;
			S_grant<=1'b1;
			M_req<=1'b1;
			M_wr<=1'b1; //input N[31:0]
			M_address<=8'h40;
			M_dout<=result0;
			result0<=result[31:0];
			result1<=result[63:32];
			next_N_value<=N_value;
		end
		SEND_N2 :
		begin
			op_done<=1'b0;
			S_grant<=1'b1;
			M_req<=1'b1;
			M_wr<=1'b1;//input N[63:32]
			M_address<=8'h41;
			M_dout<=result1;
			result0<=result[31:0];
			result1<=result[63:32];
			next_N_value<=N_value;
		end
		SEND_N3 :
		begin
			op_done<=1'b0;
			S_grant<=1'b1;
			M_req<=1'b1;
			M_wr<=1'b1; //input N-1[31:0]
			M_address<=8'h42;
			M_dout<=N_value;
			result0<=result[31:0];
			result1<=result[63:32];
			next_N_value<=N_value;
		end
		SEND_N4 :
		begin
			op_done<=1'b0;
			S_grant<=1'b1;
			M_req<=1'b1;
			M_wr<=1'b1; //input N-1[63:32]
			M_address<=8'h43;
			M_dout<=32'h00;
			result0<=result[31:0];
			result1<=result[63:32];
			next_N_value<=N_value;
		end
		SEND_IE :
		begin
			op_done<=1'b0;
			S_grant<=1'b1;
			M_req<=1'b1;
			M_wr<=1'b1; //input interrupt enable
			M_address<=8'h48;
			M_dout<=32'h01;
			result0<=result[31:0];
			result1<=result[63:32];
			next_N_value<=N_value;
		end
		SEND_OP :
		begin
			op_done<=1'b0;
			S_grant<=1'b1;
			M_req<=1'b1;
			M_wr<=1'b1; //input operation start
			M_address<=8'h4A;
			M_dout<=32'h01;
			result0<=result[31:0];
			result1<=result[63:32];
			next_N_value<=N_value;
		end
		WAIT :
		begin
			op_done<=1'b0;
			M_wr<=1'b1; //operation start off
			M_address<=8'h4A;
			M_dout<=32'h00;
			S_grant<=1'b0; //multiplier operating
			M_req<=1'b0; //require abandon
			result0<=result[31:0];
			result1<=result[63:32];
			next_N_value<=N_value;
		end
		READ_R1 :
		begin
			op_done<=1'b0;
			S_grant<=1'b1;
			M_req<=1'b1;
			M_wr<=1'b0; //read result[31:0]
			M_address<=8'h44;
			M_dout<=32'h00;
			result0<=result[31:0];
			result1<=result[63:32];
			next_N_value<=N_value;
		end
		READ_R2 :
		begin
			op_done<=1'b0;
			S_grant<=1'b1;
			M_req<=1'b1;
			M_wr<=1'b0; //read result[63:32]
			M_address<=8'h45;
			M_dout<=32'h00;
			result0<=M_din;
			result1<=result[63:32];
			next_N_value<=N_value;
		end
		SEND_CR :
		begin
			op_done<=1'b0;
			S_grant<=1'b1;
			M_req<=1'b1;
			M_wr<=1'b1; //input operation clear
			M_address<=8'h4B;
			M_dout<=32'h01;
			result0<=result[31:0];
			result1<=M_din;
			next_N_value<=N_value;
		end
		default :
		begin
			op_done<=1'bx;
			S_grant<=1'bx;
			M_req<=1'bx;
			M_wr<=1'bx;
			M_address<=8'hxx;
			M_dout<=32'hxx;
			result0<=32'hxx;
			result1<=32'hxx;
			next_N_value<=32'hxx;
		end
	endcase
	end
	
	cla32 U0_cla32(.a(N_value),.b(32'hFFFF_FFFF),.ci(1'b0),.s(w_N_value)); //N-1
	
endmodule //End of module