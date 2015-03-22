module Multiplier_slave(clk,reset_n,S_sel,S_wr,S_address,S_din,S_dout,m_interrupt,op_start,op_clear,multiplicand,multiplier,result,state);
	input clk,reset_n,S_sel,S_wr;
	input [7:0] S_address;
	input [31:0] S_din;
	input [127:0] result;
	input [1:0] state;
	output reg op_start,op_clear;
	output [63:0] multiplicand,multiplier;
	output reg [31:0] S_dout;
	output m_interrupt;
	
	reg interrupt_en;
	reg [31:0] multiplicand0,multiplicand1,multiplicand2,multiplicand3;
	reg [31:0] result0,result1,result2,result3;
	
	parameter IDLE=2'b00;
	parameter DONE=2'b01;
	
	assign m_interrupt=(~state[1])&(state[0])&(interrupt_en);
	assign multiplicand={multiplicand1,multiplicand0};
	assign multiplier={multiplicand3,multiplicand2};
	
	always@(posedge clk, negedge reset_n)
	begin
		if(!reset_n)
		begin
			multiplicand0=32'h00;
			multiplicand1=32'h00;
			multiplicand2=32'h00;
			multiplicand3=32'h00;
			result0=32'h00;
			result1=32'h00;
			result2=32'h00;
			result3=32'h00;
			interrupt_en=1'b0;
			op_start=1'b0;
			op_clear=1'b0;
			S_dout=32'h00;
		end
		else
		begin
		case(state)
			IDLE :
			begin
			case({S_wr,S_address[4:0]})
				{1'b1,5'h00} : multiplicand0<=S_din;
				{1'b1,5'h01} : multiplicand1<=S_din;
				{1'b1,5'h02} : multiplicand2<=S_din;
				{1'b1,5'h03} : multiplicand3<=S_din;
				{1'b1,5'h08} : interrupt_en<=S_din[0];
				{1'b1,5'h0A} : op_start<=S_din[0];
				{1'b1,5'h0B} : op_clear<=S_din[0];
				default : S_dout=32'h00;
			endcase
			end
			DONE :
			begin
				result0=result[31:0];
				result1=result[63:32];
				result2=result[95:64];
				result3=result[127:96];
				case({S_wr,S_address[4:0]})
					{1'b1,5'h0B} : op_clear<=S_din[0];
					{1'b0,5'h00} : S_dout<=multiplicand0;
					{1'b0,5'h01} : S_dout<=multiplicand1;
					{1'b0,5'h02} : S_dout<=multiplicand2;
					{1'b0,5'h03} : S_dout<=multiplicand3;
					{1'b0,5'h04} : S_dout<=result0;
					{1'b0,5'h05} : S_dout<=result1;
					{1'b0,5'h06} : S_dout<=result2;
					{1'b0,5'h07} : S_dout<=result3;
					{1'b0,5'h09} : S_dout<={29'h00,state};
					default : S_dout=32'h00;
				endcase
			end
			default :
			begin
			case({S_wr,S_address[4:0]})
				{1'b0,5'h00} : S_dout<=multiplicand0;
				{1'b0,5'h01} : S_dout<=multiplicand1;
				{1'b0,5'h02} : S_dout<=multiplicand2;
				{1'b0,5'h03} : S_dout<=multiplicand3;
				{1'b0,5'h04} : S_dout<=result0;
				{1'b0,5'h05} : S_dout<=result1;
				{1'b0,5'h06} : S_dout<=result2;
				{1'b0,5'h07} : S_dout<=result3;
				{1'b0,5'h09} : S_dout<={29'h00,state};
				default : S_dout=32'h00;
			endcase
			end
		endcase
		end
	end
endmodule //End of module