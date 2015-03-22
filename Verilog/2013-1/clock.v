module clock(Cp,reset,H1,H2,M1,M2,S1,S2,APM,PM,FLASH,ON,MODE,CMODE,Ch,ALM,SND);
  input Cp,reset,APM,FLASH,MODE,CMODE,Ch,ALM;
  output [3:0] H1,H2,M1,M2,S1,S2;
  output PM,ON,SND;
  reg [1:0] ho1,h1,ah1,cmode;
  reg [3:0] ho2,h2,ah2,mo1,m1,am1,mo2,m2,am2,so1,s1,so2,s2,off;
  reg pmo,pm,on,mode,alm,snd;

  assign S2=so2;
  assign S1=so1;
  assign M2=mo2;
  assign M1=mo1;
  assign H2=ho2;
  assign H1=ho1;
  assign PM=pmo;
  assign ON=on;
  assign SND=snd;

  always @ (posedge Cp,reset)
  begin
    if(reset)
      begin
        s2=4'b0000;
        s1=4'b0000;
        m2=4'b0000;
        m1=4'b0000;
        h2=4'b0000;
        h1=2'b00;
        am2=4'b0000;
        am1=4'b0000;
        ah2=4'b0000;
        ah1=2'b00;
        pm=0;
        mode=0;
        alm=0;
        cmode=2'b00;
        on=0;
        snd=0;
        off=4'b0000;
      end
    else if((~reset)&Cp)
      s2=s2+1;
    if(s2==4'b1010)
      begin
        s1=s1+1;
        s2=4'b0000;
      end
    if(s1==4'b0110)
      begin
        m2=m2+1;
        s1=4'b0000;
      end
    if(m2==4'b1010)
      begin
        m1=m1+1;
        m2=4'b0000;
      end
    if(m1==4'b0110)
      begin
        h2=h2+1;
        m1=4'b0000;
      end
    if(h2==4'b1010)
      begin
        h1=h1+1;
        h2=4'b0000;
      end
    if((h2==4'b0010)&&(h1==4'b0001))
        pm=1;
    else if((h2==4'b0100)&&(h1==4'b0010))
      begin
        h2=4'b0000;
        h1=4'b0000;
        pm=0;
      end
  end
  
  always @ (posedge MODE)
  begin
    if(MODE)
      begin
        mode=~mode;
        cmode=2'b00;
      end
  end
  
  always @ (posedge CMODE)
  begin
    if(CMODE)
      cmode=cmode+1;
    if(cmode==2'b11)
      cmode=2'b00;
  end
    
  always @ (posedge ALM)
  begin
    if(ALM)
      alm=~alm;
  end
  
  always @ (posedge Ch)
  begin
    if((mode==0)&&(cmode==2'b01))
      begin
        if(Ch)
          m2=m2+1;
        if(m2==4'b1010)
          begin
            m1=m1+1;
            m2=4'b0000;
          end
        if(m1==4'b0110)
          m1=4'b0000;
      end
    else if((mode==0)&&(cmode==2'b10))
      begin
        if(Ch)
          h2=h2+1;
        if(h2==4'b1010)
          begin
            h1=h1+1;
            h2=4'b0000;
          end
        if((h2==4'b0010)&&(h1==4'b0001))
            pm=1;
        else if((h2==4'b0100)&&(h1==4'b0010))
          begin
            h2=4'b0000;
            h1=4'b0000;
            pm=0;
          end
      end 
  end
  
  always @ (posedge Ch)
  begin
    if((mode==1)&&(cmode==2'b01))
      begin
        if(Ch)
          am2=am2+1;
        if(am2==4'b1010)
          begin
            am1=am1+1;
            am2=4'b0000;
          end
        if(am1==4'b0110)
          am1=4'b0000;
      end
    else if((mode==1)&&cmode==2'b10)
      begin
        if(Ch)
          ah2=ah2+1;
        if(ah2==4'b1010)
          begin
            ah1=ah1+1;
            ah2=4'b0000;
          end
        if((ah2==4'b0100)&&(ah1==4'b0010))
          begin
            ah2=4'b0000;
            ah1=4'b0000;
          end
      end
  end
  
  always @ (APM, posedge Cp, posedge Ch)
  begin
    if(mode==0)
      begin
        pmo=0;
        so2=s2;
        so1=s1;
        mo2=m2;
        mo1=m1;
        ho2=h2;
        ho1=h1;
        if(APM)
          begin
            pmo=pm;
            if(((h1==2'b00)&&(h2==4'b0000))||((h1==2'b01)&&(h2==4'b0010)))
              begin
                ho2=4'b0010;
                ho1=2'b01;
              end
            else if(pm&&(h2<4'b0010))
              begin
                ho2=h2+4'b1000;
                ho1=h1-2'b10;
              end
            else if(pm)
              begin
                ho2=h2-4'b0010;
                ho1=h1-2'b01;
              end
          end
      end
    else if(mode==1)
      begin
        pmo=0;
        so2=4'b0000;
        so1=4'b0000;
        mo2=am2;
        mo1=am1;
        ho2=ah2;
        ho1=ah1;
        if(APM)
          begin
            pmo=pm;
            if(((ah1==2'b00)&&(ah2==4'b0000))||((ah1==2'b01)&&(ah2==4'b0010)))
              begin
                ho2=4'b0010;
                ho1=2'b01;
              end
            else if(pm&&(ah2<4'b0010))
              begin
                ho2=ah2+4'b1000;
                ho1=ah1-2'b10;
              end
            else if(pm)
              begin
                ho2=ah2-4'b0010;
                ho1=ah1-2'b01;
              end
          end
      end
  end
  
  always @ (posedge Cp)
  begin
    if(alm==1)
      begin
        if((h1==ah1)&&(h2==ah2)&&(m1==am1)&&(m2==am2))
          snd=1;
        else
          snd=0;
      end
  end
  
  always @ (posedge FLASH, posedge Cp)
  begin
    if(FLASH)
      begin
        on=1;
        off=4'b0000;
      end
    else if((~FLASH)&&(off==4'b1110))
      on=0;
    else if((~FLASH)&&(on)&&Cp)
      off=off+1;
  end
endmodule

`timescale 1ms/1ms
module clock_tb;
  
  reg Cp,reset,APM,FLASH,MODE,CMODE,Ch,ALM;
  wire [3:0] H1,H2,M1,M2,S1,S2;
  wire PM,ON,SND;
  
  clock tb(.Cp(Cp),.reset(reset),.APM(APM),.CMODE(CMODE),.Ch(Ch),.H1(H1),.H2(H2),.M1(M1),.M2(M2),.S1(S1),.S2(S2),.PM(PM),.FLASH(FLASH),.ON(ON),.MODE(MODE),.ALM(ALM),.SND(SND));
  
  initial begin
    Cp=0;
    APM=0;
    CMODE=0;
    FLASH=0;
    MODE=0;
    Ch=0;
    ALM=0;
  end
  
  always #50 Cp=~Cp;
  
  initial begin
    reset=1; #100;
    reset=0; #100;
    
    CMODE=1; #50; CMODE=0; #50;
    Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; 
    Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; 
    Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; 
    Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; 
    CMODE=1; #50; CMODE=0; #50;
    Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; 
    Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; 
    Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; 
    CMODE=1; #50; CMODE=0; #50;
    
    MODE=1; #50; MODE=0; #50;
    CMODE=1; #50; CMODE=0; #50;
    Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; 
    Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; 
    Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; 
    Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; 
    Ch=1; #3; Ch=0; #2;
    CMODE=1; #50; CMODE=0; #50;
    Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; 
    Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; 
    Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; Ch=1; #3; Ch=0; #2; 
    CMODE=1; #50; CMODE=0; #50;
    MODE=1; #50; MODE=0; #50;
    ALM=1; #50; ALM=0; #50;
    
    #9000; FLASH=1; #50; FLASH=0; #50;
    #3000; APM=1;
    
    #3000; $stop;
  end
  
endmodule
  