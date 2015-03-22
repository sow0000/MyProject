module clock(Cp,reset,H1,H2,M1,M2,S1,S2,APM,PM,FLASH,ON,MODE,CMODE,Ch,ALM,SND);
  input Cp,reset,APM,FLASH,MODE,CMODE,Ch,ALM;
  output [6:0] H1,H2,M1,M2,S1,S2;
  output PM,ON,SND;
  reg [1:0] ho1,h1,ah1,h71,cmode;
  reg [3:0] ho2,h2,ah2,h72,mo1,m1,am1,m71,mo2,m2,am2,m72,so1,s1,s71,so2,s2,s72,off,aoff1,aoff2;
  reg pm,on,mode,alm,snd;

  assign S2=s72;
  assign S1=s71;
  assign M2=m72;
  assign M1=m71;
  assign H2=h72;
  assign H1=h71;
  assign PM=pm;
  assign ON=on;
  assign SND=snd;

  always @ (Cp,reset)
  begin
    if(reset)
      begin
        s2=4'b0000;
        s1=4'b0000;
        m2=4'b0000;
        m1=4'b0000;
        h2=4'b0000;
        h1=2'b00;
        pm=0;
        mode=0;
        alm=0;
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
  
  always @ (MODE)
  begin
    if(MODE)
      begin
        mode=mode+1;
        cmode=2'b00;
      end
  end
  
  always @ (CMODE)
  begin
    if(CMODE)
      cmode=cmode+1;
    if(cmode==2'b11)
      cmode=2'b00;
  end
  
  always @ (APM,Ch)
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
  
  always @ (Ch)
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
        if(h2==4'b1010)
          begin
            ah1=ah1+1;
            ah2=4'b0000;
          end
        if((ah2==4'b0010)&&(ah1==4'b0001))
            pm=1;
        else if((ah2==4'b0100)&&(ah1==4'b0010))
          begin
            ah2=4'b0000;
            ah1=4'b0000;
            pm=0;
          end
      end
  end
  
  always @ (APM)
  begin
    if(mode==0)
      begin
        so2=s2;
        so1=s1;
        mo2=m2;
        mo1=m1;
        ho2=h2;
        ho1=h1;
        if(APM)
          begin
            if(((h1==2'b00)&&(h2==4'b0000))||((h1==2'b01)&&(h2==4'b0010)))
              begin
                ho2=4'b0010;
                ho1=2'b01;
              end
            else if(PM&&(h2<4'b0010))
              begin
                ho2=h2+4'b1000;
                ho1=h1-2'b10;
              end
            else if(PM)
              begin
                ho2=h2-4'b0010;
                ho1=h1-2'b01;
              end
          end
      end
    else if(mode==1)
      begin
        so2=4'b0000;
        so1=4'b0000;
        mo2=am2;
        mo1=am1;
        ho2=ah2;
        ho1=ah1;
        if(APM)
          begin
            if(((ah1==2'b00)&&(ah2==4'b0000))||((ah1==2'b01)&&(ah2==4'b0010)))
              begin
                ho2=4'b0010;
                ho1=2'b01;
              end
            else if(PM&&(ah2<4'b0010))
              begin
                ho2=ah2+4'b1000;
                ho1=ah1-2'b10;
              end
            else if(PM)
              begin
                ho2=ah2-4'b0010;
                ho1=ah1-2'b01;
              end
          end
      end
  end
  
  always @ (ALM, Cp)
  begin
    if(ALM)
      alm=~alm;
    if(alm==1)
      begin
        if((~snd)&&(h1==ah1)&&(h2==ah2)&&(m1==am1)&&(m2==am2))
          begin
            snd=1;
            aoff2=4'b0000;
            aoff1=4'b0000;
          end
        else if(snd&&(aoff1==4'b0000)&&(aoff2==4'b0000))
          snd=0;
        else if(snd&&Cp)
          begin
            aoff2=aoff2+1;
            if(aoff2==4'b1010)
              begin
                aoff1=aoff1+1;
                aoff2=4'b0000;
              end
            if(aoff1==4'b0110)
              begin
                aoff2=aoff2+1;
                aoff1=4'b0000;
              end
          end
      end
  end
  
  always @ (FLASH, Cp)
  begin
    if(FLASH)
      begin
        on=1;
        off=4'b0000;
      end
    else if((~FLASH)&&(off==4'b0000))
      on=0;
    else if((~FLASH)&&Cp)
      off=off+1;
  end
  
  always @ (ho1,ho2,mo1,mo2,so1,so2)
  begin
    case (ho1)
      4'b0000 : h71=7'b0000001;
      4'b0001 : h71=7'b1001111;
      4'b0010 : h71=7'b0010010;
      4'b0011 : h71=7'b0000110;
      4'b0100 : h71=7'b1001100;
      4'b0101 : h71=7'b0100100;
      4'b0110 : h71=7'b0100000;
      4'b0111 : h71=7'b0001111;
      4'b1000 : h71=7'b0000000;
      4'b1001 : h71=7'b0001100;
      default : h71=7'b1111111;
    endcase
    
    case (ho2)
      4'b0000 : h72=7'b0000001;
      4'b0001 : h72=7'b1001111;
      4'b0010 : h72=7'b0010010;
      4'b0011 : h72=7'b0000110;
      4'b0100 : h72=7'b1001100;
      4'b0101 : h72=7'b0100100;
      4'b0110 : h72=7'b0100000;
      4'b0111 : h72=7'b0001111;
      4'b1000 : h72=7'b0000000;
      4'b1001 : h72=7'b0001100;
      default : h72=7'b1111111;
    endcase
    
    case (mo1)
      4'b0000 : m71=7'b0000001;
      4'b0001 : m71=7'b1001111;
      4'b0010 : m71=7'b0010010;
      4'b0011 : m71=7'b0000110;
      4'b0100 : m71=7'b1001100;
      4'b0101 : m71=7'b0100100;
      4'b0110 : m71=7'b0100000;
      4'b0111 : m71=7'b0001111;
      4'b1000 : m71=7'b0000000;
      4'b1001 : m71=7'b0001100;
      default : m71=7'b1111111;
    endcase
    
    case (mo2)
      4'b0000 : m72=7'b0000001;
      4'b0001 : m72=7'b1001111;
      4'b0010 : m72=7'b0010010;
      4'b0011 : m72=7'b0000110;
      4'b0100 : m72=7'b1001100;
      4'b0101 : m72=7'b0100100;
      4'b0110 : m72=7'b0100000;
      4'b0111 : m72=7'b0001111;
      4'b1000 : m72=7'b0000000;
      4'b1001 : m72=7'b0001100;
      default : m72=7'b1111111;
    endcase
    
    case (so1)
      4'b0000 : s71=7'b0000001;
      4'b0001 : s71=7'b1001111;
      4'b0010 : s71=7'b0010010;
      4'b0011 : s71=7'b0000110;
      4'b0100 : s71=7'b1001100;
      4'b0101 : s71=7'b0100100;
      4'b0110 : s71=7'b0100000;
      4'b0111 : s71=7'b0001111;
      4'b1000 : s71=7'b0000000;
      4'b1001 : s71=7'b0001100;
      default : s71=7'b1111111;
    endcase
    
    case (so2)
      4'b0000 : s72=7'b0000001;
      4'b0001 : s72=7'b1001111;
      4'b0010 : s72=7'b0010010;
      4'b0011 : s72=7'b0000110;
      4'b0100 : s72=7'b1001100;
      4'b0101 : s72=7'b0100100;
      4'b0110 : s72=7'b0100000;
      4'b0111 : s72=7'b0001111;
      4'b1000 : s72=7'b0000000;
      4'b1001 : s72=7'b0001100;
      default : s72=7'b1111111;
    endcase
    end
endmodule

`timescale 1ms/1ms
module clock_tb;
  
  reg Cp,reset,APM,FLASH,MODE,CMODE,Ch,ALM;
  wire [6:0] H1,H2,M1,M2,S1,S2;
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
    #5040000; APM=1;
    #3600000; $stop;
  end
  
endmodule
  