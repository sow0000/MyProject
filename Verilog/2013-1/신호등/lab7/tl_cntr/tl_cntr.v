/* Traffic Light Controller */
module tl_cntr(clk, reset_n, Ta, Tb, La, Lb);
	input 		 clk;
	input 		 reset_n;
	input 		 Ta, Tb;
	output [1:0] La, Lb;
	
	wire [1:0] state;
	wire [1:0] next_state;

// Instance of combinational logic	
	ns_logic 				U0_ns_logic(state, Ta, Tb, next_state);
// Instance of 2-bit resettable register with active low asynchronous reset
	_register2_r_async 	U1_register2_r_async(clk, reset_n, next_state, state);
//Instance of Output logic
	o_logic 					U2_o_logic(state, La, Lb);
endmodule


/* combinational logic */
module ns_logic(state, Ta, Tb, next_state);
	input [1:0]  state;
	input 		 Ta, Tb;
	output [1:0] next_state;

// Assign next_state	
	assign next_state[0] = (~state[1] & (~state[0] & ~Ta)) | ( state[1] & (~state[0]) & (~Tb) );
	assign next_state[1] = state[0] ^ state[1];
endmodule


/* 2-bit resettable register with active low asynchronous reset */
module _register2_r_async(clk, reset_n, d, q);
	input clk, reset_n;
	input [1:0] d;
	output [1:0] q;
	
// Instances of 8bit register_rs_async
	dff_r_async 	U0_dff_r_async(clk, reset_n, d[0], q[0]);
	dff_r_async 	U1_dff_r_async(clk, reset_n, d[1], q[1]);
endmodule


/* Resettable D flip-flop with active low asynchronous reset */
module dff_r_async(clk, reset_n, d, q);
	input clk, reset_n, d;
	output reg q;

	always @ (posedge clk or negedge reset_n)
	begin
		if(reset_n == 0) q <= 1'b0;
		else q <= d;
	end
endmodule


/* output combinational logic */
module o_logic(state, La, Lb);
	input  [1:0] state;
	output [1:0] La, Lb;

// Assign La and Lb
	assign La[1] = state[1];
	assign La[0] = ~state[1] & state[0];
	assign Lb[1] = ~state[1];
	assign Lb[0] = state[1] & state[0] ;
endmodule
