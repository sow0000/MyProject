module FullAdder(a, b, ci, co, s);
	input a, b, ci;
	output co, s;
	
	wire a, b, ci, sm, c1, c2;
	
	HalfAdder U0_HalfAdder(.a(b),.b(ci),.co(c1),.s(sm));
	HalfAdder U1_HalfAdder(.a(a),.b(sm),.co(c2),.s(s));
	_or2 U3_or2(.a(c2),.b(c1),.y(co));
endmodule	