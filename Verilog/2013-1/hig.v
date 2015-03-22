module himp(GATE, DIN, DOUT); //Make module named "himp" include variable GATE, DIN, and DOUT
  
  input GATE, DIN; //GATE => Variable for change characteristic of this operator; DIN => Variable for input data
  output DOUT; //DOUT=> Variable for output result
  reg dout; //dout=> Variable for result in "always"
  
  assign DOUT=dout; //Input dout into DOUT, which is variable for output
  
  always @ (GATE,DIN) //start always statement
  begin
    if(GATE) //If GATE has value of "1", print out DIN as it is
      dout=DIN;
    else //If GATE has any value except "1", print out High impedance
      dout=1'bz;
  end //end always statement
endmodule //end "himp" module

`timescale 1ns/1ns //Set reference time unit equal to dgree of precision about 1ns(nano second)
module himp_tb; //Make module named "himp_tb" for testbench

  reg GATE,DIN; //reg:Register, declare variables for input data
  wire DOUT; //wire:Net, wire of electrical connection of modules
  
  himp tb(GATE,DIN,DOUT); //set himp_tb with GATE, DIN, DOUT
  
  initial begin //first input preference
    GATE=0; DIN=0; #250; //input 0 into GATE and DIN before delay for 250ns; #250 => delay 250ns
    GATE=0; DIN=1; #250; //input 0 into GATE and DIN before delay for next 250ns (all of time delay is 500ns)
    GATE=1; DIN=0; #250; //input 0 into GATE and DIN before delay for next 250ns (all of time delay is 750ns)
    GATE=1; DIN=1; #250; //input 0 into GATE and DIN before delay for next 250ns (all of time delay is 100ns)
    $stop; //stop simulate
  end
endmodule //end module named "himp_tb"
