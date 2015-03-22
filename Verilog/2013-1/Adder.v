module halfadder(S,Co,a,b);
input a,b;
output S,Co;
assign S=a^b;
assign Co=a&b;
endmodule
 
module fulladder(S,Co,a,b,ci);
input a,b,ci;
output S,Co;
wire s1,c1,c2;
halfadder h1(s1,c1,x,y), h2(S,c2,s1,z);
assign C=c1|c2;
endmodule
 
module four_bit_adder(S,Co,A,B,Ci);
input [3:0] A,B;
input Ci;
output [3:0]S;
output Co;
wire c1,c2,c3;
fulladder bit0(S[0],c1,A[0],B[0],Ci),
          bit1(S[1],c2,A[1],B[1],c1),
          bit2(S[2],c3,A[2],B[2],c2),
          bit3(S[3],Co,A[3],B[3],c3);
endmodule

`timescale 1ns/1ns
module four_bit_adder_tb;
  
reg [3:0] A,B;
reg Ci;
wire [3:0] S;
wire Co;

four_bit_adder tb(.S(S),.Co(Co),.A(A),.B(B),.Ci(Ci));

initial begin
    A = 4'b0000; B = 4'b0001; Ci=0; #250;
    A = 4'b1000; B = 4'b0001; Ci=0; #250;
    A = 4'b0100; B = 4'b0100; Ci=0; #250;
    A = 4'b1010; B = 4'b1001; Ci=0; #250;
    A = 4'b1111; B = 4'b1111; Ci=0; #250;
    $stop;
  end
endmodule