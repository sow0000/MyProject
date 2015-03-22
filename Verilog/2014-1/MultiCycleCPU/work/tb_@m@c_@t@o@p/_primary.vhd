library verilog;
use verilog.vl_types.all;
entity tb_MC_TOP is
    generic(
        STEP            : integer := 100
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of STEP : constant is 1;
end tb_MC_TOP;
