module bs(SEL,DIN,DOUT); //Make module named "bs" include variable SEL, DIN, and DOUT
  
  input [1:0]SEL; //SEL => Variable for select shift mode
  input [3:0]DIN; //DIN => Variable for input
  output [3:0]DOUT; //DOUT=> Variable for output result
  
  reg [3:0]dout; //dout=> Variable for result in "always"
  
  assign DOUT=dout; //Input dout into DOUT, which is variable for output
  
  always @ (SEL,DIN) //start always statement
  begin
    case ( SEL ) //start case statement
      2'b00 : dout=DIN; //If SEL has 00, nput DIN into dout
      2'b01 : //If SEL has 01, shift all bit one position to left
      begin //begin case 01
        dout[3]=DIN[2];
        dout[2]=DIN[1];
        dout[1]=DIN[0];
        dout[0]=DIN[3];
      end //end case 01
      2'b10 : //If SEL has 01, shift all bit two positions to left
      begin //begin case 10
        dout[3]=DIN[1];
        dout[1]=DIN[3];
        dout[2]=DIN[0];
        dout[0]=DIN[2];
      end //end case 10
      2'b11 : //If SEL has 01, shift all bit three positions to left
      begin //begin case 11
        dout[3]=DIN[0];
        dout[0]=DIN[1];
        dout[1]=DIN[2];
        dout[2]=DIN[3];
      end //end case 11
    endcase //end case statement
  end //end always statement
endmodule //end "bs" module

`timescale 1ns/1ns //Set reference time unit equal to dgree of precision about 1ns(nano second)
module bs_tb; //Make module named "bs_tb" for testbench
  
  reg [1:0]SEL; //reg for select mode
  reg [3:0]DIN; //reg for input data
  wire [3:0]DOUT; //wire for output
  
  bs tb(SEL,DIN,DOUT); //set bs_tb with SEL, DIN, DOUT
  
  initial begin
    SEL=2'b00; DIN=4'b1001; #250; //input 00 into SEL and 1001 into DIN before delay for 250ns; #250 => delay 250ns
    SEL=2'b01; DIN=4'b1001; #250; //input 01 into SEL and 1001 into DIN before delay for 250ns; #250 => delay 250ns
    SEL=2'b10; DIN=4'b1001; #250; //input 10 into SEL and 1001 into DIN before delay for 250ns; #250 => delay 250ns
    SEL=2'b11; DIN=4'b1001; #250; //input 11 into SEL and 1001 into DIN before delay for 250ns; #250 => delay 250ns
    $stop; //stop simulate
  end
endmodule //end module named "bs_tb"