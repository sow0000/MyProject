library verilog;
use verilog.vl_types.all;
entity MUX2_1 is
    port(
        i_data1         : in     vl_logic_vector(31 downto 0);
        i_data2         : in     vl_logic_vector(31 downto 0);
        sel             : in     vl_logic;
        o_data          : out    vl_logic_vector(31 downto 0)
    );
end MUX2_1;
