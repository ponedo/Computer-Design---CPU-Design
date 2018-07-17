library verilog;
use verilog.vl_types.all;
entity IM is
    port(
        addr            : in     vl_logic_vector(31 downto 2);
        dout            : out    vl_logic_vector(31 downto 0)
    );
end IM;
