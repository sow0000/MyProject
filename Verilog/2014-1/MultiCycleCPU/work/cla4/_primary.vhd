library verilog;
use verilog.vl_types.all;
entity cla4 is
    port(
        a               : in     vl_logic_vector(3 downto 0);
        b               : in     vl_logic_vector(3 downto 0);
        ci              : in     vl_logic;
        s               : out    vl_logic_vector(3 downto 0);
        co              : out    vl_logic
    );
end cla4;
