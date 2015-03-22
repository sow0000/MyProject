///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Blocking and Nonblocking
//FILE : blocking_and_nonblocking.v
//TESTBENCH : tb_blocking_and_nonblocking.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines comparing blocking and nonblocking.
//LAST UPDATE : Oct. 11, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module blocking_and_nonblocking(clk, a, b, c, d, e); //module of Blocking and Nonblocking
	input clk; //clock pulse
	input a; //input data
	output b, c, d, e; //output data
	
	blocking U0_blocking(.clk(clk),.a(a),.b(b),.c(c)); //input a into b and c with blocking
	nonblocking U1_nonblocking(.clk(clk),.a(a),.b(d),.c(e)); //input a into d and e with non-blocking
endmodule //End of module

module blocking(clk, a, b, c);
	input clk;
	input a;
	output reg b, c;
	
	always@(posedge clk)
	begin
		b=a;
		c=b;
	end
endmodule //End of blocking module

module nonblocking(clk, a, b, c);
	input clk;
	input a;
	output reg b, c;
	
	always@(posedge clk)
	begin
		b<=a;
		c<=b;
	end
endmodule //End of nonblocking module