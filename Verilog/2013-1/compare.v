module compare(A, B, C);

  input [3:0] A,B;
  output [1:0] C;
  
  reg [1:0] C;

  always @ {module compare(A, B, C);

  input [3:0] A,B;
  output [1:0] C;
  
  reg [1:0] C;

  always @ (A,B)
  begin
    if(A==B)
      C=2'b01;
    else if(A>B)
      C=2'b10;
    else if(A<B)
      C=2'b11;
    else
      C=2'b00;
  end

endmodule
  
`timescale 1ns/1ns //Set reference time unit equal to dgree of precision about 1ns(nano second)
module compare_tb; //Make module named "compare_tb" for testbench
  
reg [3:0] A,B; //reg:Register, declare variables for input data
wire [1:0] C; //wire:Net, wire of electrical connection of modules

compare tb(A,B,C); //set compare_tb

initial begin //first input preference
    A = 4'b0000; B = 4'b0001; #250;
    A = 4'b1000; B = 4'b0001; #250;
    A = 4'b0100; B = 4'b0100; #250;
    A = 4'b1010; B = 4'b1001; #250;
    A = 4'b1111; B = 4'b1111; #250;
    $stop; //stop simulate
  end
endmodule //end module named "compare_tb"}(A,B)
  begin
    if(A==B)
      C=2'b01;
    else if(A>B)
      C=2'b10;
    else if(A<B)
      C=2'b11;
    else
      C=2'b00;
  end

endmodule