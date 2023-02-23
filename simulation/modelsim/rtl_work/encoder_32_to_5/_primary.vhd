library verilog;
use verilog.vl_types.all;
entity encoder_32_to_5 is
    port(
        r0Signal        : in     vl_logic;
        r1Signal        : in     vl_logic;
        r2Signal        : in     vl_logic;
        r3Signal        : in     vl_logic;
        r4Signal        : in     vl_logic;
        r5Signal        : in     vl_logic;
        r6Signal        : in     vl_logic;
        r7Signal        : in     vl_logic;
        r8Signal        : in     vl_logic;
        r9Signal        : in     vl_logic;
        r10Signal       : in     vl_logic;
        r11Signal       : in     vl_logic;
        r12Signal       : in     vl_logic;
        r13Signal       : in     vl_logic;
        r14Signal       : in     vl_logic;
        r15Signal       : in     vl_logic;
        HISignal        : in     vl_logic;
        LOSignal        : in     vl_logic;
        ZHISignal       : in     vl_logic;
        ZLOSignal       : in     vl_logic;
        PCSignal        : in     vl_logic;
        MDRSignal       : in     vl_logic;
        InportSignal    : in     vl_logic;
        CSignal         : in     vl_logic;
        encoderOutput   : out    vl_logic_vector(4 downto 0)
    );
end encoder_32_to_5;
