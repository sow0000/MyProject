library verilog;
use verilog.vl_types.all;
entity RF is
    port(
        i_Write_reg     : in     vl_logic_vector(4 downto 0);
        RegWrite        : in     vl_logic;
        i_Write_data    : in     vl_logic_vector(31 downto 0);
        i_rst_n         : in     vl_logic;
        i_clk           : in     vl_logic;
        i_Read_reg1     : in     vl_logic_vector(4 downto 0);
        i_Read_reg2     : in     vl_logic_vector(4 downto 0);
        o_Read_data1    : out    vl_logic_vector(31 downto 0);
        o_Read_data2    : out    vl_logic_vector(31 downto 0)
    );
end RF;
