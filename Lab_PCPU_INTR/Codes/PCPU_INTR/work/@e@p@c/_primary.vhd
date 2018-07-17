library verilog;
use verilog.vl_types.all;
entity EPC is
    port(
        data_in         : in     vl_logic_vector(31 downto 0);
        data_out        : out    vl_logic_vector(31 downto 0);
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        EPCWrite        : in     vl_logic
    );
end EPC;
