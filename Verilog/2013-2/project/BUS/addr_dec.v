module addr_dec(addr,s0,s1,s2);
	input [7:0] addr;
	output s0,s1,s2;
	
	assign s0=(~addr[7])&(~addr[6])&(~addr[5]);
	assign s1=(~addr[7])&(~addr[6])&(addr[5]);
	assign s2=(~addr[7])&(addr[6])&(~addr[5]);
endmodule //End of module;