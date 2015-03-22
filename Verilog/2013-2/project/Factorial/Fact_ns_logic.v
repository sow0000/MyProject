module Fact_ns_logic(state,op_start,op_clear,op_done,S_grant,M_grant,m_interrupt,next_state);
	input op_start,op_clear,op_done,S_grant,M_grant,m_interrupt;
	input [3:0] state;
	output reg [3:0] next_state;
	
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
	
	always@(state)
	begin
	case(state)
		IDLE :
		begin
		casex({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'b1,1'b0,1'bx,1'bx,1'bx,1'bx} : next_state=4'b0010;
			default : next_state=4'b0000;
		endcase
		end
		DONE :
		begin
		case({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'bx,1'b1,1'bx,1'bx,1'bx,1'bx} : next_state=4'b0000;
			default : next_state=4'b0001;
		endcase
		end
		CHK_N :
		begin
		casex({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'bx,1'b0,1'b0,1'bx,1'bx,1'bx} : next_state=4'b0011;
			{1'bx,1'b0,1'b1,1'bx,1'bx,1'bx} : next_state=4'b0001;
			default : next_state=4'b0000;
		endcase
		end
		GRANT :
		begin
		casex({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'bx,1'b0,1'b0,1'bx,1'b0,1'b0} : next_state=4'b0011;
			{1'bx,1'b0,1'b0,1'bx,1'b1,1'b0} : next_state=4'b0100;
			{1'bx,1'b0,1'b0,1'bx,1'b0,1'b1} : next_state=4'b0011;
			{1'bx,1'b0,1'b0,1'bx,1'b1,1'b1} : next_state=5'b1101;
			default : next_state=4'b0000;
		endcase
		end
		CHK_S :
		begin
		casex({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'bx,1'b0,1'b0,1'b0,1'b1,1'bx} : next_state=4'b0101;
			{1'bx,1'b0,1'b0,1'b1,1'b1,1'bx} : next_state=4'b0110;
			default : next_state=4'b0000;
		endcase
		end
		BUSY :
		begin
		casex({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'bx,1'b0,1'b0,1'b0,1'bx,1'bx} : next_state=4'b0011;
			default : next_state=4'b0000;
		endcase
		end
		SEND_N1 :
		begin
		casex({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'bx,1'b0,1'b0,1'b1,1'b1,1'bx} : next_state=4'b0111;
			default : next_state=4'b0000;
		endcase
		end
		SEND_N2 :
		begin
		casex({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'bx,1'b0,1'b0,1'b1,1'b1,1'bx} : next_state=4'b1000;
			default : next_state=4'b0000;
		endcase
		end
		SEND_N3 :
		begin
		casex({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'bx,1'b0,1'b0,1'b1,1'b1,1'bx} : next_state=4'b1001;
			default : next_state=4'b0000;
		endcase
		end
		SEND_N4 :
		begin
		casex({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'bx,1'b0,1'b0,1'b1,1'b1,1'bx} : next_state=4'b1010;
			default : next_state=4'b0000;
		endcase
		end
		SEND_IE :
		begin
		casex({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'bx,1'b0,1'b0,1'b1,1'b1,1'bx} : next_state=4'b1011;
			default : next_state=4'b0000;
		endcase
		end
		SEND_OP :
		begin
		casex({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'bx,1'b0,1'b0,1'bx,1'b1,1'bx} : next_state=4'b1100;
			default : next_state=4'b0000;
		endcase
		end
		WAIT :
		begin
		casex({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'bx,1'b0,1'b0,1'bx,1'bx,1'b0} : next_state=4'b1100;
			{1'bx,1'b0,1'b0,1'bx,1'bx,1'b1} : next_state=4'b0011;
			default : next_state=4'b0000;
		endcase
		end
		READ_R1 :
		begin
		casex({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'bx,1'b0,1'b0,1'bx,1'b1,1'b1} : next_state=4'b1110;
			default : next_state=4'b0000;
		endcase
		end
		READ_R2 :
		begin
		casex({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'bx,1'b0,1'b0,1'bx,1'b1,1'b1} : next_state=4'b1111;
			default : next_state=4'b0000;
		endcase
		end
		SEND_CR :
		begin
		casex({op_start,op_clear,op_done,S_grant,M_grant,m_interrupt})
			{1'bx,1'b0,1'b0,1'bx,1'b1,1'bx} : next_state=4'b0010;
			default : next_state=4'b0000;
		endcase
		end
	endcase
	end
endmodule //End of module