primitive SevenSegment (X,Y);

  input [3:0] X;
  output [6:0] Y;
  
  table
    4'b0000 : 7'b0000001;
    4'b0001 : 7'b1001111;
    4'b0010 : 7'b0010010;
    4'b0011 : 7'b0000110;
    4'b0100 : 7'b1001100;
    4'b0101 : 7'b0100100;
    4'b0110 : 7'b0100000;
    4'b0111 : 7'b0001111;
    4'b1000 : 7'b0000000;
    4'b1001 : 7'b0001100;
    4'b1010 : 7'b0001100;
    4'b1011 : 7'b0001100;
    4'b1100 : 7'b0001100;
    4'b1101 : 7'b0001100;
    4'b1110 : 7'b0001100;
    4'b1111 : 7'b0001100;
  endtable
endprimitive