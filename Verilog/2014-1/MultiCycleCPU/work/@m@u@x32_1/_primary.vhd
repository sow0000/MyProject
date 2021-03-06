library verilog;
use verilog.vl_types.all;
entity MUX32_1 is
    port(
        i_data0         : in     vl_logic_vector(31 downto 0);
        i_data1         : in     vl_logic_vector(31 downto 0);
        i_data2         : in     vl_logic_vector(31 downto 0);
        i_data3         : in     vl_logic_vector(31 downto 0);
        i_data4         : in     vl_logic_vector(31 downto 0);
        i_data5         : in     vl_logic_vector(31 downto 0);
        i_data6         : in     vl_logic_vector(31 downto 0);
        i_data7         : in     vl_logic_vector(31 downto 0);
        i_data8         : in     vl_logic_vector(31 downto 0);
        i_data9         : in     vl_logic_vector(31 downto 0);
        i_data10        : in     vl_logic_vector(31 downto 0);
        i_data11        : in     vl_logic_vector(31 downto 0);
        i_data12        : in     vl_logic_vector(31 downto 0);
        i_data13        : in     vl_logic_vector(31 downto 0);
        i_data14        : in     vl_logic_vector(31 downto 0);
        i_data15        : in     vl_logic_vector(31 downto 0);
        i_data16        : in     vl_logic_vector(31 downto 0);
        i_data17        : in     vl_logic_vector(31 downto 0);
        i_data18        : in     vl_logic_vector(31 downto 0);
        i_data19        : in     vl_logic_vector(31 downto 0);
        i_data20        : in     vl_logic_vector(31 downto 0);
        i_data21        : in     vl_logic_vector(31 downto 0);
        i_data22        : in     vl_logic_vector(31 downto 0);
        i_data23        : in     vl_logic_vector(31 downto 0);
        i_data24        : in     vl_logic_vector(31 downto 0);
        i_data25        : in     vl_logic_vector(31 downto 0);
        i_data26        : in     vl_logic_vector(31 downto 0);
        i_data27        : in     vl_logic_vector(31 downto 0);
        i_data28        : in     vl_logic_vector(31 downto 0);
        i_data29        : in     vl_logic_vector(31 downto 0);
        i_data30        : in     vl_logic_vector(31 downto 0);
        i_data31        : in     vl_logic_vector(31 downto 0);
        sel             : in     vl_logic_vector(4 downto 0);
        o_data          : out    vl_logic_vector(31 downto 0)
    );
end MUX32_1;
