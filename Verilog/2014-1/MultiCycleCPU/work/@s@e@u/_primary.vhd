library verilog;
use verilog.vl_types.all;
entity SEU is
    port(
        i_halfword      : in     vl_logic_vector(15 downto 0);
        o_word          : out    vl_logic_vector(31 downto 0)
    );
end SEU;
