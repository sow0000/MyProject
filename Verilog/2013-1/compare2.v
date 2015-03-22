module compare2(A, B, C);

  input [3:0] A,B;
  output C;

  assign C=A==B;

endmodule
  
`timescale 1ns/1ns //Set reference time unit equal to dgree of precision about 1ns(nano second)
module compare2_tb; //Make module named "compare_tb" for testbench
  
reg [3:0] A,B; //reg:Register, declare variables for input data
wire C; //wire:Net, wire of electrical connection of modules

compare2 tb(A,B,C); //set compare_tb

initial begin //first input preference
    A = 4'b0000; B = 4'b0001; #250;
    A = 4'b0100; B = 4'b0100; #250;
    A = 4'b1010; B = 4'b1001; #250;
    A = 4'b1111; B = 4'b1111; #250;
    $stop; //stop simulate
  end
endmodule //end module named "compare_tb"