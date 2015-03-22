module arbitrator(clk,reset_n,M0_req,M1_req,M0_grant,M1_grant);
	input clk,reset_n,M0_req,M1_req; //input values
	output M0_grant,M1_grant; //grant
	
	reg [2:0] state; //previous grant + current state
	
	wire W0_state,W1_state,W2_state,W3_state,W4_state,W5_state;
	wire [2:0] next_state; //next previous grant + next_state
	
	always@(posedge clk, negedge reset_n)
	begin
		if(!reset_n) state <= 3'b0;
		else state <= next_state;
	end
	
	assign W0_state=(~state[0])&(M0_req)&((M1_req)^(state[2]));
	assign W1_state=((state[0])|(~M0_req))&(state[2]);
	assign W2_state=(~M0_req)&(M1_req);
	assign W3_state=(state[1])&(~M0_req)&(~M1_req);
	assign W4_state=(state[1])&(state[0])&(M0_req)&(M1_req);
	assign W5_state=(~state[0])&(M0_req)&(M1_req)&(state[2]);
	
	assign next_state[2]=(W0_state)|(W1_state); //previous grant
	assign next_state[1]=(W2_state)|(W3_state)|(W4_state)|(W5_state); //2-bit state
	assign next_state[0]=(M0_req)|(M1_req);
	
	assign M0_grant=~next_state[1]; //grant
	assign M1_grant=next_state[1];

endmodule //End of module