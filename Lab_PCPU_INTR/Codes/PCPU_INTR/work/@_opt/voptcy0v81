library verilog;
use verilog.vl_types.all;
entity EX_MEM is
    port(
        RegWrite_i      : in     vl_logic;
        RegWrite_o      : out    vl_logic;
        RegData_i       : in     vl_logic_vector(1 downto 0);
        RegData_o       : out    vl_logic_vector(1 downto 0);
        MemRead_i       : in     vl_logic;
        MemRead_o       : out    vl_logic;
        MemWrite_i      : in     vl_logic;
        MemWrite_o      : out    vl_logic;
        Op_i            : in     vl_logic_vector(5 downto 0);
        Op_o            : out    vl_logic_vector(5 downto 0);
        ALUResult_i     : in     vl_logic_vector(31 downto 0);
        ALUResult_o     : out    vl_logic_vector(31 downto 0);
        Data_i          : in     vl_logic_vector(31 downto 0);
        Data_o          : out    vl_logic_vector(31 downto 0);
        Rd_i            : in     vl_logic_vector(5 downto 0);
        Rd_o            : out    vl_logic_vector(5 downto 0);
        c0Data_i        : in     vl_logic_vector(31 downto 0);
        c0Data_o        : out    vl_logic_vector(31 downto 0);
        mfc0_i          : in     vl_logic;
        mfc0_o          : out    vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        ov              : in     vl_logic
    );
end EX_MEM;
