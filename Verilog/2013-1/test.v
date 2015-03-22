module testbench(A, B, X, Y); //Make module named "testbench" include variable A, B, X, and Y
input A,B; //input data in A, B
output X,Y;
    assign X = A & B; //Print out X, a result of "A AND B"
    assign Y = A ^ B; //Print out X, a result of "A XOR B"
endmodule
  
`timescale 1ns/1ns //Set reference time unit equal to dgree of precision about 1ns(nano second)
module testbench_tb; //Make module named "testbench_tb" for testbench
  
reg A,B; //reg:Register, declare variables for input data
wire X,Y; //wire:Net, wire of electrical connection of modules

testbench tb(A,B,X,Y); //set testbench_tb

initial begin //first input preference
    A = 0; B = 0; #250; //input 0 into A and B before delay for 250ns; #250 => delay 250ns(nano second)
    A = 0; B = 1; #250; //input 0 into A and 1 into B before delay for next 250ns (all of time delay is 500ns)
    A = 1; B = 0; #250; //input 1 into A and 0 into B before delay for next 250ns (all of time delay is 750ns)
    A = 1; B = 1; #250; //input 1 into A and 1 into B before delay for next 250ns (all of time delay is 1000ns)
    $stop; //stop simulate
  end //begin ~ end
endmodule //end module named "testbench_tb"