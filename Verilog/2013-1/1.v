module TeST(A,B,C,D,E,F);
  
  input A,B,C,D,E;
  output F;
  
  wire w,x,y,z;
  
  assign w=A&B;
  assign x=w|C;
  assign y=x|D;
  assign z=y&E;
  assign F=~z;
  
endmodule

`timescale 1ns/1ns
module TeST_tb;
  
  reg a,b,c,d,e;
  wire F;
  
  NOR tb(A(a),B(b),C(c),D(d),E(e),F(f));
  
  initial begin
    a=0; b=0; c=0; d=0; e=0; #250;
    a=0; b=0; c=0; d=0; e=1; #250;
    a=0; b=0; c=0; d=1; e=0; #250;
    a=0; b=0; c=0; d=1; e=1; #250;
    a=0; b=0; c=1; d=0; e=0; #250;
    a=0; b=0; c=1; d=0; e=1; #250;
    a=0; b=0; c=1; d=1; e=0; #250;
    a=0; b=0; c=1; d=1; e=1; #250;
    a=0; b=1; c=0; d=0; e=0; #250;
    a=0; b=1; c=0; d=0; e=1; #250;
    a=0; b=1; c=0; d=1; e=0; #250;
    a=0; b=1; c=0; d=1; e=1; #250;
    a=0; b=1; c=1; d=0; e=0; #250;
    a=0; b=1; c=1; d=0; e=1; #250;
    a=0; b=1; c=1; d=1; e=0; #250;
    a=0; b=1; c=1; d=1; e=1; #250;
    a=1; b=0; c=0; d=0; e=0; #250;
    a=1; b=0; c=0; d=0; e=1; #250;
    a=1; b=0; c=0; d=1; e=0; #250;
    a=1; b=0; c=0; d=1; e=1; #250;
    a=1; b=0; c=1; d=0; e=0; #250;
    a=1; b=0; c=1; d=0; e=1; #250;
    a=1; b=0; c=1; d=1; e=0; #250;
    a=1; b=0; c=1; d=1; e=1; #250;
    a=1; b=1; c=0; d=0; e=0; #250;
    a=1; b=1; c=0; d=0; e=1; #250;
    a=1; b=1; c=0; d=1; e=0; #250;
    a=1; b=1; c=0; d=1; e=1; #250;
    a=1; b=1; c=1; d=0; e=0; #250;
    a=1; b=1; c=1; d=0; e=1; #250;
    a=1; b=1; c=1; d=1; e=0; #250;
    a=1; b=1; c=1; d=1; e=1; #250;
    $stop;
  end
  
endmodule