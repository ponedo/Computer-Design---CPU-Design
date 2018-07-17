library verilog;
use verilog.vl_types.all;
entity PC is
    port(
        pc_next         : in     vl_logic_vector(31 downto 0);
        pc              : out    vl_logic_vector(31 downto 0);
        PCRst           : in     vl_logic;
        clk             : in     vl_logic;
        PCWrite         : in     vl_logic
    );
end PC;
