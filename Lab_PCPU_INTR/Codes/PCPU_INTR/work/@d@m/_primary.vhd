library verilog;
use verilog.vl_types.all;
entity DM is
    port(
        addr            : in     vl_logic_vector(31 downto 2);
        Be              : in     vl_logic_vector(3 downto 0);
        U               : in     vl_logic;
        din             : in     vl_logic_vector(31 downto 0);
        DMRead          : in     vl_logic;
        DMWr            : in     vl_logic;
        clk             : in     vl_logic;
        dout            : out    vl_logic_vector(31 downto 0)
    );
end DM;
