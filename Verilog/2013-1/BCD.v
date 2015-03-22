module Hex2BCD(Hex, BCD);
  input [3:0] Hex;
  output [7:0] BCD;
 
  assign BCD[3:0] = (Hex<10)?Hex:Hex-4'd10;
  assign BCD[7:4] = (Hex<10)?4'd0:4'd1;

endmodule

`timescale 1ns/1ns
module Hex2BCD_tb;
  
reg [3:0] Hex;
wire [7:0] BCD;

Hex2BCD tb(Hex,BCD);

initial begin
    Hex = 4'b0000; #250;
    Hex = 4'b0100; #250;
    Hex = 4'b1001; #250;
    Hex = 4'b1010; #250;
    Hex = 4'b1111; #250;
    $stop;
  end
endmodule