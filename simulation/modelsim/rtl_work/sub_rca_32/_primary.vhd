library verilog;
use verilog.vl_types.all;
entity sub_rca_32 is
    port(
        c_out           : out    vl_logic;
        sum             : out    vl_logic_vector(31 downto 0);
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        c_in            : in     vl_logic
    );
end sub_rca_32;
