module counter(CLK,set,reset,Din,Q);
  input CLK,set,reset;
  input [3:0] Din;
  output [3:0] Q;
  reg [3:0] din;
  reg [3:0] q;
  
  assign Din=din;
  assign Q=q;
  
  always @ (CLK,set,reset)
  begin
    if(set&(~reset))
      din=4'b0000;
    else if((~set)&reset)
      q=4'b0000;
    else if(CLK&(~set)&(~reset))
      din=din+1;
      q=din;
  end
endmodule

`timescale 1ms/1ms
module counter_tb;
  
  reg CLK,set,reset;
  reg [3:0] Din;
  wire [3:0] Q;
  
  counter tb(.CLK(CLK),.set(set),.reset(reset),.Din(Din),.Q(Q));
  
  initial begin
    Din=4'b0000;
    CLK=0;
  end
  
  always #50 CLK=~CLK;
  
  initial begin
    set=0; reset=1; #100;
    set=1; reset=0; #100;
    set=0; reset=0; #100;
    $stop;
  end
  
endmodule
  