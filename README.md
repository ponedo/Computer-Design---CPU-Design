# Computer Organization Design - CPU Design

This is the MIPS CPU Design in my sophomore year as the final submission of the course "Computer design"

This repository includes:

  1. A simple monocycle CPU design;
  2. A muticycle CPU design, whose CTRL module is a finite status machine;
  3. A pipeline CPU design with 5-stage pipeline;
    - The stages are: Instrction Fetching, Instruction Decoding, Execution, Memory accessing, Writing Back (to Register Files)
  4. A further expansion of design 3. Interrupt/Exception handling is added.
  
Each folder is a ISE project, whose "bit"-format file is transmitted onto a FPGA circuit. Modules are written in Verilog HDL.
