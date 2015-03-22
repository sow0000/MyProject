library verilog;
use verilog.vl_types.all;
entity ALUOut is
    port(
        i_clk           : in     vl_logic;
        i_alu_result    : in     vl_logic_vector(31 downto 0);
        o_alu_out       : out    vl_logic_vector(31 downto 0)
    );
end ALUOut;
