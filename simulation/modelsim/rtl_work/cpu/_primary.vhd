library verilog;
use verilog.vl_types.all;
entity cpu is
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        stop            : in     vl_logic;
        bus_Signal      : in     vl_logic_vector(31 downto 0);
        bus_contents    : out    vl_logic_vector(31 downto 0);
        outport_Output  : out    vl_logic_vector(31 downto 0);
        operation       : out    vl_logic_vector(5 downto 0)
    );
end cpu;
