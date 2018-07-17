library verilog;
use verilog.vl_types.all;
entity Forwarding_unit is
    port(
        ID_EX_Rs        : in     vl_logic_vector(5 downto 0);
        ID_EX_Rt        : in     vl_logic_vector(5 downto 0);
        IF_ID_Rs        : in     vl_logic_vector(5 downto 0);
        IF_ID_Rt        : in     vl_logic_vector(5 downto 0);
        EX_MEM_Rd       : in     vl_logic_vector(5 downto 0);
        MEM_WB_Rd       : in     vl_logic_vector(5 downto 0);
        PCWriteCond     : in     vl_logic_vector(3 downto 0);
        Jump            : in     vl_logic_vector(1 downto 0);
        mtc0            : in     vl_logic;
        EX_MEM_RegWrite : in     vl_logic;
        MEM_WB_RegWrite : in     vl_logic;
        ForwardA        : out    vl_logic_vector(1 downto 0);
        ForwardB        : out    vl_logic_vector(1 downto 0);
        CmpA            : out    vl_logic_vector(1 downto 0);
        CmpB            : out    vl_logic_vector(1 downto 0)
    );
end Forwarding_unit;
