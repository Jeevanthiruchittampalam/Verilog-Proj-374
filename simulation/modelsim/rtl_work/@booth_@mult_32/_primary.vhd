library verilog;
use verilog.vl_types.all;
entity Booth_Mult_32 is
    port(
        product         : out    vl_logic_vector(63 downto 0);
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic
    );
end Booth_Mult_32;
