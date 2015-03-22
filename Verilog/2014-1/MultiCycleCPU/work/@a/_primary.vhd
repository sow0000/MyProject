library verilog;
use verilog.vl_types.all;
entity A is
    port(
        i_clk           : in     vl_logic;
        i_x             : in     vl_logic_vector(31 downto 0);
        o_y             : out    vl_logic_vector(31 downto 0)
    );
end A;
