module DEMUX(A,B,S,X);
  
  input S,X;
  output A,B;
  
  reg a,b;
  
  assign A=a;
  assign B=b;
  
  always @ (S,X)
  begin
    if(S==0)
    begin
      a=X;
      b=1'bz;
    end
    else if(S==1)
    begin
      a=1'bz;
      b=X;
    end
  end
endmodule

`timescale 1ns/1ns
module DEMUX_tb;
  
  reg X,S;
  wire A,B;
  
  DEMUX tb(.A(A),.B(B),.S(S),.X(X));
  
  initial begin
    X=0; S=0; #250;
    X=0; S=1; #250;
    X=1; S=0; #250;
    X=1; S=1; #250;
    $stop;
  end
endmodule