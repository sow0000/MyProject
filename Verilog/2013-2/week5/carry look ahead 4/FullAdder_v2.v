///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Full Adder version 2
//FILE : FullAdder_v2.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Full Adder without carry out.
//LAST UPDATE : Oct. 10, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module FullAdder_v2(a,b,ci,s); //Module of Full Adder version 2
input a,b,ci; //a,b : Variable for input binary signals //ci : Variable of input carry value for full adder
output s; //s : Output port for result

_xor2 U0_xor2(.a(a),.b(b),.y(w0)); //Add a to b
_xor2 U1_xor2(.a(w0),.b(ci),.y(s));

endmodule //End of module