library verilog;
use verilog.vl_types.all;
entity EXTload is
    port(
        data_i          : in     vl_logic_vector(31 downto 0);
        op              : in     vl_logic_vector(31 downto 26);
        addr            : in     vl_logic_vector(1 downto 0);
        data_o          : out    vl_logic_vector(31 downto 0)
    );
end EXTload;
