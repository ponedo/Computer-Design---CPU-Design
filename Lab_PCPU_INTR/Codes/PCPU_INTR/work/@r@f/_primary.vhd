library verilog;
use verilog.vl_types.all;
entity RF is
    port(
        ra0_i           : in     vl_logic_vector(4 downto 0);
        ra1_i           : in     vl_logic_vector(4 downto 0);
        wa_i            : in     vl_logic_vector(4 downto 0);
        wd_i            : in     vl_logic_vector(31 downto 0);
        LinkAddr        : in     vl_logic_vector(4 downto 0);
        LinkData        : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        RegWrite        : in     vl_logic;
        Link            : in     vl_logic_vector(1 downto 0);
        rst             : in     vl_logic;
        rd0_o           : out    vl_logic_vector(31 downto 0);
        rd1_o           : out    vl_logic_vector(31 downto 0)
    );
end RF;
