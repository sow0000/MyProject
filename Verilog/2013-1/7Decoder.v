module SDecoder(A,Y); //Declare module SDecoder with A and Y
  
  input [3:0] A; //Variable for input
  output [6:0] Y; //Variable for output
  
  reg [6:0] y; //Variable for result in "always"
  
  assign Y=y; //Input y into Y, which is variable for output
  
  always @ (A) //start always statement with input data A
  begin
    case (A) //start case statement with condition A
      4'b0000 : y=7'b0000001; //if A is 0000, input 0000001 into y
      4'b0001 : y=7'b1001111; //if A is 0001, input 1001111 into y
      4'b0010 : y=7'b0010010; //if A is 0010, input 0010010 into y
      4'b0011 : y=7'b0000110; //if A is 0011, input 0000110 into y
      4'b0100 : y=7'b1001100; //if A is 0100, input 1001100 into y
      4'b0101 : y=7'b0100100; //if A is 0101, input 0100100 into y
      4'b0110 : y=7'b0100000; //if A is 0110, input 0100000 into y
      4'b0111 : y=7'b0001111; //if A is 0111, input 0001111 into y
      4'b1000 : y=7'b0000000; //if A is 1000, input 0000000 into y
      4'b1001 : y=7'b0001100; //if A is 1001, input 0001100 into y
      default : y=7'b1111111; //the other cases, input 1111111 into y
    endcase //end case statement
  end //end always statement
endmodule //end SDecoder

`timescale 1ns/1ns
module SDecoder_tb; //Declare module SDecoder_tb
  
  reg [3:0] A; //reg for input data
  wire [6:0] Y; //wire for output
  
  SDecoder tb(A,Y); //set SDecoder_tb with A and Y
  
  initial begin
    A=4'b0000; #250; //input 0000 into A before delay for 250ns
    A=4'b0001; #250; //input 0001 into A before delay for 250ns
    A=4'b0010; #250; //input 0010 into A before delay for 250ns
    A=4'b0011; #250; //input 0011 into A before delay for 250ns
    A=4'b0100; #250; //input 0100 into A before delay for 250ns
    A=4'b0101; #250; //input 0101 into A before delay for 250ns
    A=4'b0110; #250; //input 0110 into A before delay for 250ns
    A=4'b0111; #250; //input 0111 into A before delay for 250ns
    A=4'b1000; #250; //input 1000 into A before delay for 250ns
    A=4'b1001; #250; //input 1001 into A before delay for 250ns
    A=4'b1010; #250; //input 1010 into A before delay for 250ns
    $stop; //stop simulate
  end
  
endmodule //end SDecoder_tb