library verilog;
use verilog.vl_types.all;
entity ADD is
    port(
        i_data1         : in     vl_logic_vector(31 downto 0);
        i_data2         : in     vl_logic_vector(31 downto 0);
        o_sum           : out    vl_logic_vector(31 downto 0)
    );
end ADD;
