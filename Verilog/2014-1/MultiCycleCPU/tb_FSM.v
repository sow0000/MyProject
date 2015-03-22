`timescale 1ns/100ps
module tb_FSM();
  reg tb_i_clk, tb_i_rst_n;
  reg [5:0] tb_i_op;
  wire [3:0] tb_cur_state, tb_next_state;
  wire tb_PCWriteCond, tb_PCWrite, tb_IorD, 
            tb_MemRead, tb_MemWrite, tb_MemtoReg, 
            tb_IRWrite, tb_ALUSrcA, tb_RegWrite, tb_RegDst;
  wire [1:0] tb_ALUOp, tb_ALUSrcB, tb_PCSource;
  parameter CYCLE = 10;
  parameter Rtype = 6'b000000,
          lw = 6'b100011,
          sw = 6'b101011,
          beq = 6'b000100,
          addi = 6'b001000,
          j = 6'b000010;
  FSM U0_FSM(.i_clk(tb_i_clk), .i_rst_n(tb_i_rst_n), .i_op(tb_i_op), 
           .cur_state(tb_cur_state), .next_state(tb_next_state), 
           .PCWriteCond(tb_PCWriteCond), .PCWrite(tb_PCWrite), 
           .IorD(tb_IorD), .MemRead(tb_MemRead), .MemWrite(tb_MemWrite), 
           .MemtoReg(tb_MemtoReg), .IRWrite(tb_IRWrite), .PCSource(tb_PCSource), 
           .ALUOp(tb_ALUOp), .ALUSrcB(tb_ALUSrcB), .ALUSrcA(tb_ALUSrcA), 
           .RegWrite(tb_RegWrite), .RegDst(tb_RegDst));
 	always 		//assignment for clock pulse
	begin
		tb_i_clk=1; #(CYCLE/2); tb_i_clk=0; #(CYCLE/2);
	end
	initial		//start inserting value
	begin
		tb_i_rst_n = 0; #(CYCLE+3);
		tb_i_rst_n = 1; #(3*CYCLE);
		tb_i_op = lw; #(7*CYCLE);
		tb_i_op = sw; #(7*CYCLE);
		tb_i_op = Rtype; #(7*CYCLE);
		tb_i_op = beq; #(7*CYCLE);
		tb_i_op = addi; #(7*CYCLE);
		tb_i_op = j; #(7*CYCLE);

		$stop;		//stop inserting
	end				//End of initial assignment
	endmodule		//End of module
