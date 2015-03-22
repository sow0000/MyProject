module tlight(Cp,reset,WR,WY,WL,WG,ER,EY,EL,EG,SR,SY,SL,SG,NR,NY,NL,NG,WWR,WWG,EWR,EWG,SWR,SWG,NWR,NWG);
  input Cp,reset;
  output WR,WY,WL,WG,ER,EY,EL,EG,SR,SY,SL,SG,NR,NY,NL,NG,WWR,WWG,EWR,EWG,SWR,SWG,NWR,NWG;
  reg wr,wy,wl,wg,er,ey,el,eg,sr,sy,sl,sg,nr,ny,nl,ng,wwr,wwg,ewr,ewg,swr,swg,nwr,nwg,cgy,wens;
  reg [4:0] gy;
  reg [2:0] l;
  
  assign WR=wr;
  assign WY=wy;
  assign WL=wl;
  assign WG=wg;
  assign ER=er;
  assign EY=ey;
  assign EL=el;
  assign EG=eg;
  assign SR=sr;
  assign SY=sy;
  assign SL=sl;
  assign SG=sg;
  assign NR=nr;
  assign NY=ny;
  assign NL=nl;
  assign NG=ng;
  assign WWR=wwr;
  assign WWG=wwg;
  assign EWR=ewr;
  assign EWG=ewg;
  assign SWR=swr;
  assign SWG=swg;
  assign NWR=nwr;
  assign NWG=nwg;
  
  always @ (Cp,reset)
  begin
    if(reset)
      begin
        wr=1;
        wy=0;
        wl=0;
        wg=0;
        er=1;
        ey=0;
        el=0;
        eg=0;
        sr=1;
        sy=0;
        sl=0;
        sg=0;
        nr=1;
        ny=0;
        nl=0;
        ng=0;
        wwr=1;
        wwg=0;
        ewr=1;
        ewg=0;
        swr=1;
        swg=0;
        nwr=1;
        nwg=0;
        cgy=1;
        wens=0;
        gy=5'b00000;
        l=3'b000;
      end
    else if((~reset)&&Cp&&cgy)
      begin
        gy=gy+1;
        if(gy==5'b00000)
            cgy=~cgy;
      end
    else if((~reset)&&Cp&&(~cgy))
      begin
        l=l+1;
        if(l==3'b000)
          begin
            wens=~wens;
            cgy=~cgy;
          end
      end
      
    case(wens)
      0 : begin
        if(gy>=5'b11101)
          begin
            wy=1;
            wg=0;
            ey=1;
            eg=0;
          end
        else if(l>3'b000)
          begin
            wy=0;
            wl=1;
            wg=1;
            ey=0;
            el=1;
            eg=1;
          end
        else
          begin
            wr=0;
            wg=1;
            er=0;
            eg=1;
            sr=1;
            sl=0;
            sg=0;
            nr=1;
            nl=0;
            ng=0;
          end
          
        if(~cgy)
          begin
            wwr=1;
            wwg=0;
            ewr=1;
            ewg=0;
          end
        else if(gy>=5'b10110)
          begin
            wwg=~wwg;
            ewg=~ewg;
          end
        else
          begin
            wwr=0;
            wwg=1;
            ewr=0;
            ewg=1;
            swr=1;
            swg=0;
            nwr=1;
            nwg=0;
          end
        end
      1 : begin
        if(gy>=5'b11101)
          begin
            sy=1;
            sg=0;
            ny=1;
            ng=0;
          end
        else if(l>3'b000)
          begin
            sy=0;
            sl=1;
            sg=0;
            ny=1;
            nl=1;
            ng=1;
          end
        else
          begin
            wr=1;
            wl=0;
            wg=0;
            er=1;
            el=0;
            eg=0;
            sr=0;
            sg=1;
            nr=0;
            ng=1;
          end
          
        if(~cgy)
          begin
            swr=1;
            swg=0;
            nwr=1;
            nwg=0;
          end
        else if(gy>=5'b10110)
          begin
            swg=~swg;
            nwg=~nwg;
          end
        else
          begin
            wwr=1;
            wwg=0;
            ewr=1;
            ewg=0;
            swr=0;
            swg=1;
            nwr=0;
            nwg=1;
          end
        end
      endcase
  end
endmodule

`timescale 1ms/1ms;
module tlight_tb;
  
  reg Cp,reset;
  wire WR,WY,WL,WG,ER,EY,EL,EG,SR,SY,SL,SG,NR,NY,NL,NG,WWR,WWG,EWR,EWG,SWR,SWG,NWR,NWG;
  
  tlight tb(.Cp(Cp),.reset(reset),.WR(WR),.WY(WY),.WL(WL),.WG(WG),.ER(ER),.EY(EY),.EL(EL),.EG(EG),.SR(SR),.SY(SY),.SL(SL),.SG(SG),.NR(NR),.NY(NY),.NL(NL),.NG(NG),.WWR(WWR),.WWG(WWG),.EWR(EWR),.EWG(EWG),.SWR(SWR),.SWG(SWG),.NWR(NWR),.NWG(NWG));
  
  initial Cp=0;
  
  always #50 Cp=~Cp;
  
  initial begin
    reset=1; #100;
    reset=0; #100;
    #12000; $stop;
  end
endmodule
  