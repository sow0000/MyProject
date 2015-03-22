library verilog;
use verilog.vl_types.all;
entity PC is
    port(
        i_pc_w_c        : in     vl_logic;
        i_next_pc       : in     vl_logic_vector(31 downto 0);
        o_pc            : out    vl_logic_vector(31 downto 0);
        i_rst_n         : in     vl_logic;
        i_clk           : in     vl_logic
    );
end PC;
