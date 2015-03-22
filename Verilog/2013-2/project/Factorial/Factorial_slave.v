module Factorial_slave(clk,reset_n,S_sel,S_wr,S_address,S_din,S_dout,f_interrupt,N_value,op_start,op_clear,result,state);
	input clk,reset_n,S_sel,S_wr;
	input [7:0] S_address;
	input [31:0] S_din;
	input [63:0] result;
	input [3:0] state;
	output reg op_start,op_clear;
	output reg [31:0] S_dout,N_value;
	output f_interrupt;
	
	reg interrupt_en;
	reg [31:0] result0,result1;
	
	parameter IDLE=5'b00000;
	parameter DONE=5'b00001;
	
	assign f_interrupt=(state[0])&&(interrupt_en);
	
	always@(posedge clk, negedge reset_n)
	begin
		if(!reset_n)
		begin
			N_value=32'h00;
			interrupt_en=1'b0;
			op_start=1'b0;
			op_clear=1'b0;
			S_dout=32'h00;
			result0=32'h00;
			result1=32'h00;
		end
		else
		begin
		case(state)
			IDLE :
			begin
			case({S_wr,S_address[4:0]})
				{1'b1,5'h00} : N_value<=S_din;
				{1'b1,5'h01} : interrupt_en<=S_din[0];
				{1'b1,5'h03} : op_start<=S_din[0];
				{1'b1,5'h04} : op_clear<=S_din[0];
				default : S_dout=32'h00;
			endcase
			end
			DONE :
			begin
				result0=result[31:0];
				result1=result[63:32];
				case({S_wr,S_address[4:0]})
					{1'b1,5'h04} : op_clear<=S_din[0];
					{1'b0,5'h00} : S_dout<=N_value;
					{1'b0,5'h01} : S_dout<={31'h00,interrupt_en};
					{1'b0,5'h02} : S_dout<={28'h00,state};
					{1'b0,5'h05} : S_dout<=result0;
					{1'b0,5'h06} : S_dout<=result;
					default : S_dout=32'h00;
				endcase
			end
			default :
			begin
			case({S_wr,S_address[4:0]})
				{1'b0,5'h00} : S_dout<=N_value;
				{1'b0,5'h01} : S_dout<={31'h00,interrupt_en};
				{1'b0,5'h02} : S_dout<=state;
				{1'b0,5'h05} : S_dout<=result0;
				{1'b0,5'h06} : S_dout<=result;
				default : S_dout=32'h00;
			endcase
			end
		endcase
		end
	end
endmodule //End of module