library verilog;
use verilog.vl_types.all;
entity Top_OExp03_IP2SOC is
    port(
        BTN_y           : in     vl_logic_vector(3 downto 0);
        clk_100mhz      : in     vl_logic;
        RSTN            : in     vl_logic;
        SW              : in     vl_logic_vector(15 downto 0);
        BTN_x           : out    vl_logic_vector(4 downto 0);
        CR              : out    vl_logic;
        led_clk         : out    vl_logic;
        led_clrn        : out    vl_logic;
        LED_PEN         : out    vl_logic;
        led_sout        : out    vl_logic;
        RDY             : out    vl_logic;
        readn           : out    vl_logic;
        seg_clk         : out    vl_logic;
        seg_clrn        : out    vl_logic;
        SEG_PEN         : out    vl_logic;
        seg_sout        : out    vl_logic
    );
end Top_OExp03_IP2SOC;
