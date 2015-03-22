library verilog;
use verilog.vl_types.all;
entity ALU is
    generic(
        \AND\           : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi0);
        \OR\            : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi1);
        ADD             : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        SUB             : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi0);
        SLT             : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi1);
        \NOR\           : vl_logic_vector(0 to 3) := (Hi1, Hi1, Hi0, Hi0)
    );
    port(
        i_data1         : in     vl_logic_vector(31 downto 0);
        i_data2         : in     vl_logic_vector(31 downto 0);
        ALUop           : in     vl_logic_vector(3 downto 0);
        o_result        : out    vl_logic_vector(31 downto 0);
        o_zero          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of \AND\ : constant is 1;
    attribute mti_svvh_generic_type of \OR\ : constant is 1;
    attribute mti_svvh_generic_type of ADD : constant is 1;
    attribute mti_svvh_generic_type of SUB : constant is 1;
    attribute mti_svvh_generic_type of SLT : constant is 1;
    attribute mti_svvh_generic_type of \NOR\ : constant is 1;
end ALU;
