library verilog;
use verilog.vl_types.all;
entity MDR is
    port(
        i_clk           : in     vl_logic;
        i_data          : in     vl_logic_vector(31 downto 0);
        o_data          : out    vl_logic_vector(31 downto 0)
    );
end MDR;
