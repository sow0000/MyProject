library verilog;
use verilog.vl_types.all;
entity \_register32\ is
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        en              : in     vl_logic;
        d               : in     vl_logic_vector(31 downto 0);
        q               : out    vl_logic_vector(31 downto 0)
    );
end \_register32\;
