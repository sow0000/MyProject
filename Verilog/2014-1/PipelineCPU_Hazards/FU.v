module FU(IDEX_Rs,IDEX_Rt,EXMEM_Rd,EXMEM_RegWrite,MEMWB_Rd,MEMWB_RegWrite,ForwardA,ForwardB);
	input EXMEM_RegWrite,MEMWB_RegWrite;
	input [4:0] IDEX_Rs,IDEX_Rt,EXMEM_Rd,MEMWB_Rd;
	output reg [1:0] ForwardA,ForwardB;
	
	always @ (*)
	begin
		if(EXMEM_RegWrite && (EXMEM_Rd != 0) && (EXMEM_Rd == IDEX_Rs))	//EX hazard
			ForwardA <= 2'b10;
		else if(MEMWB_RegWrite && (MEMWB_Rd != 0) && (EXMEM_Rd != IDEX_Rs) && (MEMWB_Rd == IDEX_Rs))	//MEM hazard
			ForwardA <= 2'b01;
		else
			ForwardA <= 2'b00;
			
		if(EXMEM_RegWrite && (EXMEM_Rd != 0) && (EXMEM_Rd == IDEX_Rt))	//EX hazard
			ForwardB <= 2'b10;
		else if(MEMWB_RegWrite && (MEMWB_Rd != 0) && (EXMEM_Rd != IDEX_Rt) && (MEMWB_Rd == IDEX_Rt))	//MEM hazard
			ForwardB <= 2'b01;
		else
			ForwardB <= 2'b00;
	end

endmodule //End of module