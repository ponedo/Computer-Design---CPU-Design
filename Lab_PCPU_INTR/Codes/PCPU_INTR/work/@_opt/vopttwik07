library verilog;
use verilog.vl_types.all;
entity MEM_WB is
    port(
        RegWrite_i      : in     vl_logic;
        RegWrite_o      : out    vl_logic;
        RegData_i       : in     vl_logic_vector(1 downto 0);
        RegData_o       : out    vl_logic_vector(1 downto 0);
        ALUResult_i     : in     vl_logic_vector(31 downto 0);
        ALUResult_o     : out    vl_logic_vector(31 downto 0);
        MemData_i       : in     vl_logic_vector(31 downto 0);
        MemData_o       : out    vl_logic_vector(31 downto 0);
        Rd_i            : in     vl_logic_vector(5 downto 0);
        Rd_o            : out    vl_logic_vector(5 downto 0);
        c0Data_i        : in     vl_logic_vector(31 downto 0);
        c0Data_o        : out    vl_logic_vector(31 downto 0);
        mfc0_i          : in     vl_logic;
        mfc0_o          : out    vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic
    );
end MEM_WB;
