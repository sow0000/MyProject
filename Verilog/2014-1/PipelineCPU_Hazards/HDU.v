module HDU(IDEX_Rt,IFID_Rs,IFID_Rt,IDEX_MemRead,EX_Bubble,PC_Write,IFID_Write);
	input IDEX_MemRead;
	input [4:0] IDEX_Rt,IFID_Rs,IFID_Rt;
	output reg EX_Bubble,PC_Write,IFID_Write;
	
	always @ (*)
	begin
		if(IDEX_MemRead && ((IDEX_Rt == IFID_Rs) || (IDEX_Rt == IFID_Rt)))
		begin
			EX_Bubble <= 1'b1;
			PC_Write <= 1'b0;
			IFID_Write <= 1'b0;
		end
		else
		begin
			EX_Bubble <= 1'b0;
			PC_Write <= 1'b1;
			IFID_Write <= 1'b1;
		end
	end

endmodule //End of module