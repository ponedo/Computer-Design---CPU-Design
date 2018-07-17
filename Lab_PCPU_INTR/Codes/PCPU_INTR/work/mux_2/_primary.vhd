library verilog;
use verilog.vl_types.all;
entity mux_2 is
    generic(
        bit             : integer := 1
    );
    port(
        d0              : in     vl_logic_vector;
        d1              : in     vl_logic_vector;
        s               : in     vl_logic;
        q               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of bit : constant is 1;
end mux_2;
