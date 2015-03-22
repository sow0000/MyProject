module BUS(clk,reset_n,M0_req,M0_wr,M0_address,M0_dout,M1_req,M1_wr,M1_address,M1_dout,S0_sel,S1_sel,S2_sel,S_wr,S_address,S_din,M0_grant,M1_grant,M_din,S0_dout,S1_dout,S2_dout);
	input clk,reset_n,M0_req,M0_wr,M1_req,M1_wr;
	input [7:0] M0_address,M1_address;
	input [31:0] M0_dout,M1_dout,S0_dout,S1_dout,S2_dout;
	
	output M0_grant,M1_grant,S0_sel,S1_sel,S2_sel,S_wr;
	output [7:0] S_address;
	output [31:0] M_din,S_din;
	
	reg [2:0] reg_sel;
	
	wire M0_grant,S0_sel,S1_sel,S2_sel;
	
	always@(posedge clk, negedge reset_n)
	begin
		if(!reset_n) reg_sel <= 3'b0;
		else reg_sel <= {S0_sel,S1_sel,S2_sel};
	end
	
	arbitrator U0_arbitrator(.clk(clk),.reset_n(reset_n),.M0_req(M0_req),.M1_req(M1_req),.M0_grant(M0_grant),.M1_grant(M1_grant));
	mx2 U1_mx2(.d0(M0_wr),.d1(M1_wr),.s(M0_grant),.y(S_wr));
	mx2_8bits U2_mx2_8bits(.d0(M0_address),.d1(M1_address),.s(M0_grant),.y(S_address));
	mx2_32bits U3_mx2_32bits(.d0(M0_dout),.d1(M1_dout),.s(M0_grant),.y(S_din));
	addr_dec U4_addr_dec(.addr(S_address),.s0(S0_sel),.s1(S1_sel),.s2(S2_sel));
	mx4_32bits U6_mx4_32bits(.y(M_din),.d0(S0_dout),.d1(S1_dout),.d2(S2_dout),.d3(32'h00),.s(reg_sel));
	
endmodule //End of module