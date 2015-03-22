module gray2b(A,B);
  
  input [3:0] A;
  output [3:0] B;
  
  reg [3:0] b;
  
  assign B=b;
  
  always @ (A)
  begin
    b[3]=A[3];
    b[2]=b[3]^A[2];
    b[1]=b[2]^A[1];
    b[0]=b[1]^A[0];
  end
endmodule

`timescale 1ns/1ns
module gray2b_tb;
  
  reg [3:0] A;
  wire [3:0] B;
  
  gray2b tb(A,B);
  
  initial begin
    A=4'b0000; #250;
    A=4'b1000; #250;
    A=4'b1010; #250;
    A=4'b1111; #250;
    $stop;
  end
endmodule