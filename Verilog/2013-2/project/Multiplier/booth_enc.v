module booth_enc(num,multiplier,s_interrupt,next_num,B_operation);
	input [7:0] num;
	input [64:0] multiplier;
	output reg s_interrupt;
	output [7:0] next_num;
	output [2:0] B_operation; //booth operation
	
	wire [7:0] W0_num,W1_num;
	wire W0_op,W1_op,W2_op;
	
	always@(num)
	begin
		if(num==8'h3F) s_interrupt=1'b1;
		else s_interrupt=1'b0;
	end
	
	cla8 U0_cla8(.a(num),.b(8'h01),.ci(1'b0),.s(W0_num));
	cla8 U1_cla8(.a(num),.b(8'hFF),.ci(1'b0),.s(W1_num));
	cla8 U2_cla8(.a(num),.b(8'h02),.ci(1'b0),.s(next_num));
	
	assign W0_op=(~multiplier[W0_num])&(multiplier[num])&(multiplier[W1_num]);
	assign W1_op=(multiplier[W0_num])&(~multiplier[num])&(multiplier[W1_num]);
	assign W2_op=(multiplier[W0_num])&(multiplier[num])&(~multiplier[W1_num]);
	
	assign B_operation[2]=(multiplier[W0_num])&(~multiplier[num])&(~multiplier[W1_num]);
	assign B_operation[1]=(W0_op)|(W1_op)|(W2_op);
	assign B_operation[0]=(~multiplier[W0_num])&((multiplier[num])|(multiplier[W1_num]));
	
endmodule //End of module