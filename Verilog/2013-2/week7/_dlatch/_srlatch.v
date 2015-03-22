///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : RS-latch
//FILE : _srlatch.v
//TESTBENCH : _dlatch.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines SR-latch
//LAST UPDATE : Oct. 18, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module _srlatch(r,s,q,q_bar); //Module of SR-latch
	input r,s; //input
	output q,q_bar; //output
	
	_nor2 U0_nor2(.a(r),.b(q_bar),.y(q)); //q=~(r^q_bar)
	_nor2 U1_nor2(.a(q),.b(s),.y(q_bar)); //q_bar=~(q^s)
	
endmodule //End of module