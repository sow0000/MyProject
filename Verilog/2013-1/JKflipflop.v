module JKFF(Cp,CLR,PRS,Q,Qbar);
  
  input Cp,CLR,PRS;
  output Q,Qbar;
  reg q,qbar,s,r;
  
  assign Q=q;
  assign Qbar=qbar;
  
  always @ (Cp,CLR,PRS)
  begin
    if((~CLR)&(~PRS))
      begin
         q = 1;
         qbar = 1;
      end
    else if(CLR&(~PRS))
      begin
         q = 1;
         qbar = 0;
      end
    else if((~CLR)&PRS)
      begin
         q = 0;
         qbar = 1;
      end
    else if(Cp&PRS&CLR)
      begin
        s=~(qbar&1&Cp);
        r=~(q&1&Cp);
        q=~(s&qbar);
        qbar=~(r&q);
      end
  end
  
endmodule


`timescale 1ns/1ns
module JKFF_tb;
  
  reg Cp,CLR,PRS,q,qbar,s,r;
  wire Q,Qbar;
  
  JKFF tb(Cp,CLR,PRS,Q,Qbar);
  
  initial begin
    Cp=0; CLR=1; PRS=0; #100;
    Cp=0; CLR=0; PRS=1; #100;
    Cp=0; CLR=1; PRS=1; #100;
    $stop;
  end
  
endmodule