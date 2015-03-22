module MUX(A,B,S,Z);
  
  input A,B,S;
  output Z;
  
  reg a,b,z;
  
  assign Z=z;
  
  always @ (A,B,S)
  begin
    if(S==0)
      z=A;
    else if(S==1)
      z=B;
  end
endmodule

`timescale 1ns/1ns
module MUX_tb;
  
  reg A,B,S;
  wire Z;
  
  MUX tb(A,B,S);
  
  initial begin
    A=0; B=0; S=0; #250;
    A=0; B=1; S=0; #250;
    A=1; B=0; S=0; #250;
    A=1; B=1; S=0; #250;
    A=0; B=0; S=1; #250;
    A=0; B=1; S=1; #250;
    A=1; B=0; S=1; #250;
    A=1; B=1; S=1; #250;
    $stop;
  end
endmodule