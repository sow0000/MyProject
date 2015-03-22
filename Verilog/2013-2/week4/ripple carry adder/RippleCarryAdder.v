module RippleCarryAdder(a, b, ci, s, co);
	input [3:0] a,b;
	input ci;
	output [3:0] s;
	output co;
	
	wire [3:0] a,b;
	wire [2:0] c;
	wire ci;
	
	FullAdder U0_FullAdder(.a(a[0]),.b(b[0]),.ci(ci),.co(c[0]),.s(s[0]));	
	FullAdder U1_FullAdder(.a(a[1]),.b(b[1]),.ci(c[0]),.co(c[1]),.s(s[1]));	
	FullAdder U2_FullAdder(.a(a[2]),.b(b[2]),.ci(c[1]),.co(c[2]),.s(s[2]));	
	FullAdder U3_FullAdder(.a(a[3]),.b(b[3]),.ci(c[2]),.co(co),.s(s[3]));
endmodule