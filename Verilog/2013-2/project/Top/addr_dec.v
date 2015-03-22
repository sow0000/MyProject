///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Address decoder
//FILE : addr_dec.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Address decoder
//LAST UPDATE : Dec. 01, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module addr_dec(addr,s0,s1,s2); //module of Address decoder
	input [7:0] addr; //input address
	output s0,s1,s2; //output selection
	
	assign s0=(~addr[7])&(~addr[6])&(~addr[5]); //0x00~0x1F
	assign s1=(~addr[7])&(~addr[6])&(addr[5]); //0x20~0x3F
	assign s2=(~addr[7])&(addr[6])&(~addr[5]); //0x40~0x5F
endmodule //End of module;