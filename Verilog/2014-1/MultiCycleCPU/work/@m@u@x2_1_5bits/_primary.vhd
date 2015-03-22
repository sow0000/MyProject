library verilog;
use verilog.vl_types.all;
entity MUX2_1_5bits is
    port(
        i_data1         : in     vl_logic_vector(4 downto 0);
        i_data2         : in     vl_logic_vector(4 downto 0);
        sel             : in     vl_logic;
        o_data          : out    vl_logic_vector(4 downto 0)
    );
end MUX2_1_5bits;
