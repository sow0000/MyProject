///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Random access memory
//FILE : ram.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Random access memory
//LAST UPDATE : DEC, 01, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module ram(clk,reset_n,cen,wen,addr,din,dout); //module of Random access memory
	input clk,reset_n,cen,wen; //clock pulse, reset, ram enable, write enable
	input [7:0] addr; //address
	input [31:0] din; //input
	output reg [31:0] dout; //output
	
	reg [31:0] mem [0:31]; //32 x 32 memory
	
	always@(posedge clk, negedge reset_n)
	begin
		if(!reset_n)
		begin
			mem[0]=32'h00; //initialize
			mem[1]=32'h00;
			mem[2]=32'h00;
			mem[3]=32'h00;
			mem[4]=32'h00;
			mem[5]=32'h00;
			mem[6]=32'h00;
			mem[7]=32'h00;
			mem[8]=32'h00;
			mem[9]=32'h00;
			mem[10]=32'h00;
			mem[11]=32'h00;
			mem[12]=32'h00;
			mem[13]=32'h00;
			mem[14]=32'h00;
			mem[15]=32'h00;
			mem[16]=32'h00;
			mem[17]=32'h00;
			mem[18]=32'h00;
			mem[19]=32'h00;
			mem[20]=32'h00;
			mem[21]=32'h00;
			mem[22]=32'h00;
			mem[23]=32'h00;
			mem[24]=32'h00;
			mem[25]=32'h00;
			mem[26]=32'h00;
			mem[27]=32'h00;
			mem[28]=32'h00;
			mem[29]=32'h00;
			mem[30]=32'h00;
			mem[31]=32'h00;
			dout=32'h00;
		end
		else if(cen&wen)
		begin
			mem[addr]=din; //store value
			dout=32'h00;
		end
		else if(cen&!wen)	dout=mem[addr]; //output value
		else if(!cen)		dout=32'h00; //non operation
		else					dout=32'hxx; //default
	end

endmodule //End of module