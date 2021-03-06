library verilog;
use verilog.vl_types.all;
entity FSM is
    generic(
        S0              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi0);
        S1              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi1);
        S2              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        S3              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi1);
        S4              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi0);
        S5              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi1);
        S6              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi0);
        S7              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi1);
        S8              : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi0);
        S9              : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi1);
        S10             : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi1, Hi0);
        S11             : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi1, Hi1);
        R_format        : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        lw              : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi0, Hi0, Hi1, Hi1);
        sw              : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi1, Hi0, Hi1, Hi1);
        beq             : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0);
        addi            : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi1, Hi0, Hi0, Hi0);
        j               : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi0)
    );
    port(
        i_clk           : in     vl_logic;
        i_rst_n         : in     vl_logic;
        i_op            : in     vl_logic_vector(5 downto 0);
        PCWriteCond     : out    vl_logic;
        PCWrite         : out    vl_logic;
        IorD            : out    vl_logic;
        MemRead         : out    vl_logic;
        MemWrite        : out    vl_logic;
        MemtoReg        : out    vl_logic;
        IRWrite         : out    vl_logic;
        PCSource        : out    vl_logic_vector(1 downto 0);
        ALUOp           : out    vl_logic_vector(1 downto 0);
        ALUSrcB         : out    vl_logic_vector(1 downto 0);
        ALUSrcA         : out    vl_logic;
        RegWrite        : out    vl_logic;
        RegDst          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of S0 : constant is 1;
    attribute mti_svvh_generic_type of S1 : constant is 1;
    attribute mti_svvh_generic_type of S2 : constant is 1;
    attribute mti_svvh_generic_type of S3 : constant is 1;
    attribute mti_svvh_generic_type of S4 : constant is 1;
    attribute mti_svvh_generic_type of S5 : constant is 1;
    attribute mti_svvh_generic_type of S6 : constant is 1;
    attribute mti_svvh_generic_type of S7 : constant is 1;
    attribute mti_svvh_generic_type of S8 : constant is 1;
    attribute mti_svvh_generic_type of S9 : constant is 1;
    attribute mti_svvh_generic_type of S10 : constant is 1;
    attribute mti_svvh_generic_type of S11 : constant is 1;
    attribute mti_svvh_generic_type of R_format : constant is 1;
    attribute mti_svvh_generic_type of lw : constant is 1;
    attribute mti_svvh_generic_type of sw : constant is 1;
    attribute mti_svvh_generic_type of beq : constant is 1;
    attribute mti_svvh_generic_type of addi : constant is 1;
    attribute mti_svvh_generic_type of j : constant is 1;
end FSM;
