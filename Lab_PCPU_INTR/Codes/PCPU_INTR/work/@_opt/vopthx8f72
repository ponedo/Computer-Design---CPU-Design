library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        aluctrl         : in     vl_logic_vector(4 downto 0);
        src0_i          : in     vl_logic_vector(31 downto 0);
        src1_i          : in     vl_logic_vector(31 downto 0);
        aluout_o        : out    vl_logic_vector(63 downto 0);
        zero            : out    vl_logic;
        sign            : out    vl_logic;
        ov              : out    vl_logic
    );
end ALU;
