///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Asynchronous D-flip flop
//FILE : _dff_rs_async.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Asynchronous D-flip flop
//LAST UPDATE : Oct. 18, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module _dff_rs_async(clk,set_n,reset_n,d,q); //Module of Asynchronous D-flip flop
	input clk,set_n,reset_n,d; //clk=clock pulse; //set_n=set switch; //reset_n=reset switch; //d=input
	output q; //output
	reg q; //register of q
 
	always@(posedge clk or negedge set_n or negedge reset_n) //do posedge clk or negedge set_n or negedge reset_n
	begin //start of always
		if(reset_n==0) q<=1'b0; //if reset_n==0 input 1'b0 into q
		else if(set_n==0) q<=1'b1; //if set_n==0 input 1'b1 into q
		else q<=d; //else input d into q
	end //end of always
 
endmodule //End of module
