library verilog;
use verilog.vl_types.all;
entity MEMORY is
    port(
        i_clk           : in     vl_logic;
        i_rst_n         : in     vl_logic;
        MemRead         : in     vl_logic;
        MemWrite        : in     vl_logic;
        i_addr          : in     vl_logic_vector(31 downto 0);
        i_WriteData     : in     vl_logic_vector(31 downto 0);
        o_MemData       : out    vl_logic_vector(31 downto 0)
    );
end MEMORY;
