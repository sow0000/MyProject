module Decoder(A, B, en, Y);
  
  input en, A, B;
  input [3:0] Y;
  
  reg [3:0] y;
  
  assign Y=y;
  
  always @ (A, B, en)
  begin
    case (en)
      1 :
      begin
        if(A==0&&B==0)
          y=4'b1110;
        else if(A==0&&B==1)
          y=4'b1101;
        else if(A==1&&B==0)
          y=4'b1011;
        else
          y=4'b0111;
      end
      0 : y=4'b1111;
    endcase
  end
endmodule

`timescale 1ns/1ns
module Decoder_tb;
  
  reg A,B,en;
  wire [3:0] Y;
  
  Decoder tb(A,B,en,Y);
  
  initial begin
    A=0; B=0; en=0; #250;
    A=0; B=1; en=0; #250;
    A=1; B=0; en=0; #250;
    A=1; B=1; en=0; #250;
    A=0; B=0; en=1; #250;
    A=0; B=1; en=1; #250;
    A=1; B=0; en=1; #250;
    A=1; B=1; en=1; #250;
    $stop;
  end
  
endmodule