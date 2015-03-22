module NOR(A,B,X);
  
  input A,B;
  output X;
  reg C;
  
  assign X=C;
  
  always @ (A,B)
  begin
    if(A||B)
      C=0;
    else
      C=1;
  end
endmodule

`timescale 1ns/1ns
module NOR_tb;
  
  reg A,B;
  wire X;
  
  NOR tb(A,B,X);
  
  initial begin
    A=0; B=0; #250;
    A=0; B=1; #250;
    A=1; B=0; #250;
    A=1; B=1; #250;
    $stop;
  end
  
endmodule