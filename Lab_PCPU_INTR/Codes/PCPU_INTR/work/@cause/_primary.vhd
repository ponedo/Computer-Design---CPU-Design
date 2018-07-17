library verilog;
use verilog.vl_types.all;
entity Cause is
    port(
        data_in         : in     vl_logic_vector(31 downto 0);
        data_out        : out    vl_logic_vector(31 downto 0);
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        CauseWrite      : in     vl_logic
    );
end Cause;
