module graycode(A,B);
  
  input [3:0] A;
  output [3:0] B;
  
  reg [3:0] b;
  
  assign B=b;
  
  always @ (A)
  begin
   b[0]=A[0]^A[1];
   b[1]=A[1]^A[2];
   b[2]=A[2]^A[3];
   b[3]=A[3];
  end
endmodule

`timescale 1ns/1ns
module graycode_tb;
  
  reg [3:0] A;
  wire [3:0] B;
  
  graycode tb(A,B);
  
  initial begin
    A=4'b0000; #250;
    A=4'b1000; #250;
    A=4'b1010; #250;
    A=4'b1111; #250;
    $stop;
  end
endmodule