library verilog;
use verilog.vl_types.all;
entity ALUControl is
    port(
        funct           : in     vl_logic_vector(5 downto 0);
        ALUOp           : in     vl_logic_vector(1 downto 0);
        ALU_control_signal: out    vl_logic_vector(3 downto 0)
    );
end ALUControl;
