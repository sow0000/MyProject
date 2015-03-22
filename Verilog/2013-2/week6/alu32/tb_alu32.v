`timescale 1ns/100ps

module tb_alu32;
	reg clk, reset;
	reg [31:0] tb_a, tb_b, tb_resultEx;
	reg [3:0] tb_op, tb_cEx, tb_nEx, tb_zEx, tb_vEx;
	wire [31:0] tb_result;
	wire tb_c, tb_n, tb_z, tb_v;
	reg [31:0] vectornum, overflows, errors;
	reg [115:0] testvectors[10000:0];
	
	alu32 U0_alu32(.a(tb_a),.b(tb_b),.op(tb_op[2:0]),.result(tb_result),.c(tb_c),.n(tb_n),.z(tb_z),.v(tb_v));
	
	always #5 clk=~clk;
	
	initial
	begin
		$readmemh("alu32.txt", testvectors);
		vectornum=0; overflows=0; errors=0;
		clk=0; reset=1; #10; reset=0;
	end
	
	always@(posedge clk)
	begin
		#1; {tb_a,tb_b,tb_op,tb_resultEx,tb_cEx,tb_nEx,tb_zEx,tb_vEx}=testvectors[vectornum];
	end
	
	always@(negedge clk)
	if(~reset)
	begin
		if(tb_v==1'b1)
		begin
			$display("Overflow : inputs=%h%b",{tb_a,tb_b},tb_op);
			overflows=overflows+1;
		end
		if(tb_result!==tb_resultEx)
		begin
			$display("Error : inputs=%h%b",{tb_a,tb_b},tb_op);
			$display("        outputs=%h_%b_%b_%b_%b(%h_%b_%b_%b_%b expected)",tb_result,tb_c,tb_n,tb_z,tb_v,tb_resultEx,tb_cEx,tb_nEx,tb_zEx,tb_vEx);
			errors=errors+1;
		end
		vectornum=vectornum+1;
		if(testvectors[vectornum]===116'hx)
		begin
			$display("%h tests completed with %h overflows and %h errors",vectornum,overflows,errors);
			$finish;
		end
	end
endmodule