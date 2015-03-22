library verilog;
use verilog.vl_types.all;
entity MC_TOP is
    port(
        i_clk           : in     vl_logic;
        i_rst_n         : in     vl_logic
    );
end MC_TOP;
