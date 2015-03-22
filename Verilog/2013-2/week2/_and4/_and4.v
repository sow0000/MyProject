module _and4(a,b,c,d,y);
input a,b,c,d;
output y;
wire w0,w1;

_and2 U0(.a(a),.b(b),.y(w0));
_and2 U1(.a(c),.b(d),.y(w1));
_and2 U2(.a(w0),.b(w1),.y(y));

endmodule


module _and2(a,b,y);
input a,b;
output y;
assign y=a&b;
endmodule