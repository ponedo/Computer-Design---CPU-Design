library verilog;
use verilog.vl_types.all;
entity RAM_B is
    port(
        addra           : in     vl_logic_vector(9 downto 0);
        wea             : in     vl_logic;
        dina            : in     vl_logic_vector(31 downto 0);
        clka            : in     vl_logic;
        douta           : out    vl_logic_vector(31 downto 0)
    );
end RAM_B;
