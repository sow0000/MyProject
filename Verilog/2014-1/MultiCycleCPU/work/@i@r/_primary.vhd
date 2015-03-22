library verilog;
use verilog.vl_types.all;
entity IR is
    port(
        i_clk           : in     vl_logic;
        IRWrite         : in     vl_logic;
        i_Instr         : in     vl_logic_vector(31 downto 0);
        o_op            : out    vl_logic_vector(5 downto 0);
        o_rs            : out    vl_logic_vector(4 downto 0);
        o_rt            : out    vl_logic_vector(4 downto 0);
        o_Imm16         : out    vl_logic_vector(15 downto 0)
    );
end IR;
