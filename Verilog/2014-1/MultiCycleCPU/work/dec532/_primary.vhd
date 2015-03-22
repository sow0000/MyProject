library verilog;
use verilog.vl_types.all;
entity dec532 is
    port(
        a               : in     vl_logic_vector(4 downto 0);
        y               : out    vl_logic_vector(32 downto 0)
    );
end dec532;
