library verilog;
use verilog.vl_types.all;
entity Hazard_detection_unit is
    port(
        ID_EX_MemRead   : in     vl_logic;
        EX_MEM_MemRead  : in     vl_logic;
        ID_EX_RegWrite  : in     vl_logic;
        PCWriteCond     : in     vl_logic_vector(3 downto 0);
        Jump            : in     vl_logic_vector(1 downto 0);
        mtc0            : in     vl_logic;
        ID_EX_Rdst      : in     vl_logic_vector(5 downto 0);
        EX_MEM_Rd       : in     vl_logic_vector(5 downto 0);
        IF_ID_Rs        : in     vl_logic_vector(5 downto 0);
        IF_ID_Rt        : in     vl_logic_vector(5 downto 0);
        Stall           : out    vl_logic;
        PCWrite         : out    vl_logic;
        IF_IDWrite      : out    vl_logic
    );
end Hazard_detection_unit;
