library verilog;
use verilog.vl_types.all;
entity Ctrl is
    port(
        Instr           : in     vl_logic_vector(31 downto 0);
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        PCWriteCond     : out    vl_logic_vector(3 downto 0);
        MemRead         : out    vl_logic;
        MemWrite        : out    vl_logic;
        RegData         : out    vl_logic_vector(1 downto 0);
        Jump            : out    vl_logic_vector(1 downto 0);
        Link            : out    vl_logic_vector(1 downto 0);
        ALUOp           : out    vl_logic_vector(3 downto 0);
        EXTOp           : out    vl_logic_vector(1 downto 0);
        ALUSrcA         : out    vl_logic;
        ALUSrcB         : out    vl_logic;
        RegWrite        : out    vl_logic;
        RegDst          : out    vl_logic;
        Intr            : in     vl_logic;
        Inta            : out    vl_logic;
        ov              : in     vl_logic;
        mask            : in     vl_logic_vector(3 downto 0);
        Brch            : in     vl_logic;
        EPCWrite        : out    vl_logic;
        StaWrite        : out    vl_logic;
        CauseWrite      : out    vl_logic;
        EPCSelect       : out    vl_logic_vector(1 downto 0);
        StaSelect       : out    vl_logic_vector(1 downto 0);
        CauseSelect     : out    vl_logic;
        PCSource        : out    vl_logic_vector(1 downto 0);
        cause           : out    vl_logic_vector(1 downto 0);
        Cancel_IF       : out    vl_logic;
        Cancel_ID       : out    vl_logic;
        C0RegData       : out    vl_logic_vector(1 downto 0);
        mfc0            : out    vl_logic;
        mtc0            : out    vl_logic
    );
end Ctrl;
