library verilog;
use verilog.vl_types.all;
entity divider is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        dividend        : in     vl_logic_vector(31 downto 0);
        divisor         : in     vl_logic_vector(31 downto 0);
        quotient        : out    vl_logic_vector(31 downto 0)
    );
end divider;
