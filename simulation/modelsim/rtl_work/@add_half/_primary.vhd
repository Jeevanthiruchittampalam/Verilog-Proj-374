library verilog;
use verilog.vl_types.all;
entity Add_half is
    port(
        c_out           : out    vl_logic;
        sum             : out    vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic
    );
end Add_half;
