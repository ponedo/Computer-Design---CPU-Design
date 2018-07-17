////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 14.7
//  \   \         Application : sch2hdl
//  /   /         Filename : Top_OExp03_IP2SOC.vf
// /___/   /\     Timestamp : 06/01/2017 16:27:14
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: sch2hdl -sympath D:/FPGA_work/SWORD-ORG/OExp03-IP2SOC/Code/IO -sympath D:/FPGA_work/SWORD-ORG/OExp03-IP2SOC/Code/CPU -sympath D:/FPGA_work/SWORD-ORG/OExp03-IP2SOC/ipcore_dir -intstyle ise -family kintex7 -verilog D:/FPGA_work/SWORD-ORG/OExp03-IP2SOC/Top_OExp03_IP2SOC.vf -w D:/FPGA_work/SWORD-ORG/OExp03-IP2SOC/Code/Top_OExp03_IP2SOC.sch
//Design Name: Top_OExp03_IP2SOC
//Device: kintex7
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale 1ns / 1ps

module Top_OExp03_IP2SOC(BTN_y, 
                         clk_100mhz, 
                         RSTN, 
                         SW, 
                         BTN_x, 
                         CR, 
                         led_clk, 
                         led_clrn, 
                         LED_PEN, 
                         led_sout, 
                         RDY, 
                         readn, 
                         seg_clk, 
                         seg_clrn, 
                         SEG_PEN, 
                         seg_sout);

   (* LOC = "E13,F14,G14,D14" *) 
    input [3:0] BTN_y;
   (* LOC = "t9" *) 
    input clk_100mhz;
    input RSTN;
   (* LOC = "K13,K14,J13,J14,H13,H14,G12,F12" *) 
    input [15:0] SW;
   output [4:0] BTN_x;
   output CR;
   output led_clk;
   output led_clrn;
   output LED_PEN;
   output led_sout;
   output RDY;
   output readn;
   output seg_clk;
   output seg_clrn;
   output SEG_PEN;
   output seg_sout;
   
   wire [31:0] Addr_out;
   wire [31:0] Ai;
   wire [31:0] Bi;
   wire [7:0] blink;
   wire [3:0] BTN_OK;
   wire Clk_CPU;
   wire [31:0] Counter_out;
   wire [31:0] CPU2IO;
   wire [31:0] Data_in;
   wire [31:0] Data_out;
   wire [31:0] Disp_num;
   wire [31:0] Div;
   wire GPIOF0;
   wire [31:0] inst;
   wire IO_clk;
   wire [15:0] LED_out;
   wire [7:0] LE_out;
   wire N0;
   wire [31:0] PC;
   wire [7:0] point_out;
   wire [3:0] Pulse;
   wire rst;
   wire [15:0] SW_OK;
   wire V5;
   wire XLXN_153;
   wire XLXN_154;
   wire [1:0] XLXN_219;
   wire [4:0] XLXN_444;
   wire XLXN_455;
   wire XLXN_541;
   wire XLXN_544;
   wire [31:0] XLXN_556;
   wire [0:0] XLXN_557;
   wire [9:0] XLXN_558;
   wire [31:0] XLXN_559;
   wire XLXN_560;
   wire XLXN_579;
   wire RDY_DUMMY;
   wire readn_DUMMY;

	
   assign RDY = RDY_DUMMY;
   assign readn = readn_DUMMY;
   SEnter_2_32  M4 (.BTN(BTN_OK[2:0]), 
                   .clk(clk_100mhz), 
                   .Ctrl({SW_OK[7:5], SW_OK[15], SW_OK[0]}), 
                   .Din(XLXN_444[4:0]), 
                   .D_ready(RDY_DUMMY), 
                   .Ai(Ai[31:0]), 
                   .Bi(Bi[31:0]), 
                   .blink(blink[7:0]), 
                   .readn(readn_DUMMY));
   SCPU U1 (.clk(Clk_CPU), 
            .Data_in(Data_in[31:0]), 
            .inst_in(inst[31:0]), 
            .INT(XLXN_579), 
            .MIO_ready(), 
            .reset(rst), 
            .Addr_out(Addr_out[31:0]), 
            .CPU_MIO(), 
            .Data_out(Data_out[31:0]), 
            .mem_w(XLXN_544), 
            .PC_out(PC[31:0]));
   ROM_D  U2 (.a(PC[11:2]), 
             .spo(inst[31:0]));
   RAM_B  U3 (.addra(XLXN_558[9:0]), 
             .clka(XLXN_455), 
             .dina(XLXN_556[31:0]), 
             .wea(XLXN_557[0]), 
             .douta(XLXN_559[31:0]));
   MIO_BUS  U4 (.addr_bus(Addr_out[31:0]), 
               .BTN(BTN_OK[3:0]), 
               .clk(clk_100mhz), 
               .counter_out(Counter_out[31:0]), 
               .counter0_out(XLXN_579), 
               .counter1_out(XLXN_153), 
               .counter2_out(XLXN_154), 
               .Cpu_data2bus(Data_out[31:0]), 
               .led_out(LED_out[15:0]), 
               .mem_w(XLXN_544), 
               .ram_data_out(XLXN_559[31:0]), 
               .rst(rst), 
               .SW(SW_OK[15:0]), 
               .counter_we(XLXN_560), 
               .Cpu_data4bus(Data_in[31:0]), 
               .data_ram_we(XLXN_557[0]), 
               .GPIOe0000000_we(XLXN_541), 
               .GPIOf0000000_we(GPIOF0), 
               .Peripheral_in(CPU2IO[31:0]), 
               .ram_addr(XLXN_558[9:0]), 
               .ram_data_in(XLXN_556[31:0]));
   Multi_8CH32  U5 (.clk(IO_clk), 
                   .Data0(CPU2IO[31:0]), 
                   .data1({N0, N0, PC[31:2]}), 
                   .data2(inst[31:0]), 
                   .data3(Counter_out[31:0]), 
                   .data4(Addr_out[31:0]), 
                   .data5(Data_out[31:0]), 
                   .data6(Data_in[31:0]), 
                   .data7(PC[31:0]), 
                   .EN(XLXN_541), 
                   .LES({N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, 
         N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, 
         N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, 
         N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0}), 
                   .point_in({Div[31:0], Div[31:0]}), 
                   .rst(rst), 
                   .Test(SW_OK[7:5]), 
                   .Disp_num(Disp_num[31:0]), 
                   .LE_out(LE_out[7:0]), 
                   .point_out(point_out[7:0]));
   SSeg7_Dev  U6 (.clk(clk_100mhz), 
                 .flash(Div[25]), 
                 .Hexs(Disp_num[31:0]), 
                 .LES(LE_out[7:0]), 
                 .point(point_out[7:0]), 
                 .rst(rst), 
                 .Start(Div[20]), 
                 .SW0(SW_OK[0]), 
                 .seg_clk(seg_clk), 
                 .seg_clrn(seg_clrn), 
                 .SEG_PEN(SEG_PEN), 
                 .seg_sout(seg_sout));
   SPIO  U7 (.clk(IO_clk), 
            .EN(GPIOF0), 
            .P_Data(CPU2IO[31:0]), 
            .rst(rst), 
            .Start(Div[20]), 
            .counter_set(XLXN_219[1:0]), 
            .GPIOf0(), 
            .led_clk(led_clk), 
            .led_clrn(led_clrn), 
            .LED_out(LED_out[15:0]), 
            .LED_PEN(LED_PEN), 
            .led_sout(led_sout));
   clk_div  U8 (.clk(clk_100mhz), 
               .rst(rst), 
               .SW2(SW_OK[2]), 
               .clkdiv(Div[31:0]), 
               .Clk_CPU(Clk_CPU));
   SAnti_jitter  U9 (.clk(clk_100mhz), 
                    .Key_y(BTN_y[3:0]), 
                    .readn(readn_DUMMY), 
                    .RSTN(RSTN), 
                    .SW(SW[15:0]), 
                    .BTN_OK(BTN_OK[3:0]), 
                    .CR(CR), 
                    .Key_out(XLXN_444[4:0]), 
                    .Key_ready(RDY_DUMMY), 
                    .Key_x(BTN_x[4:0]), 
                    .pulse_out(Pulse[3:0]), 
                    .rst(rst), 
                    .SW_OK(SW_OK[15:0]));
   Counter_x  U10 (.clk(IO_clk), 
                  .clk0(Div[6]), 
                  .clk1(Div[9]), 
                  .clk2(Div[11]), 
                  .counter_ch(XLXN_219[1:0]), 
                  .counter_val(CPU2IO[31:0]), 
                  .counter_we(XLXN_560), 
                  .rst(rst), 
                  .counter_out(Counter_out[31:0]), 
                  .counter0_OUT(XLXN_579), 
                  .counter1_OUT(XLXN_153), 
                  .counter2_OUT(XLXN_154));
   VCC  XLXI_1 (.P(V5));
   GND  XLXI_2 (.G(N0));
   INV  XLXI_53 (.I(clk_100mhz), 
                .O(XLXN_455));
   INV  XLXI_72 (.I(Clk_CPU), 
                .O(IO_clk));
endmodule


/*module top(
    input RSTN,
    input [3:0] BTN_y,
    output [4:0] BTN_x,
    input [15:0] SW,
    input clk_100mhz,
    output CR,
    output RDY,
    output readn,
    output seg_clk,
    output seg_sout,
    output SEG_PEN,
    output seg_clrn,
    output led_clk,
    output led_sout,
    output LED_PEN,
    output led_clrn
    );
  
  // suppose:
  // N0 = 0
  // V5 = 1
  
  wire [4:0] XLXN_444;
  wire [3:0] Pulse;
  wire [3:0] BTN_OK; // need buffer?
  wire [15:0] SW_OK;
  wire rst;
  wire [31:0] Div;
  wire Clk_CPU;
  wire [7:0] blink;
  wire [31:0] Ai;
  wire [31:0] Bi;
  wire [31:0] XLXN_240;
  wire [31:0] XLXN_280;
  wire [31:0] XLXN_449;
  wire [31:0] XLXN_469;
  wire [31:0] Disp_num;
  wire [7:0] point_out;
  wire [7:0] LE_out;
  wire [31:0] CNT;
  wire mem_w;
  wire [31:0] Addr_out;
  wire [31:0] Data_in;
  wire [31:0] Data_out;
  wire [31:0] ram_data_in;
  wire data_ram_we;
  wire [9:0] ram_addr;
  wire [31:0] ram_data_out;
  wire [15:0] LED_out;
  wire [31:0] Counter_out;
  wire Counter0_out;
  wire Counter1_out;
  wire Counter2_out;
  wire Counter_we;
  wire [31:0] CPU2IO;
  wire GPIOE0;
  wire GPIOF0;
  wire [31:0] PC;
  wire [31:0] inst;
  wire [1:0] Counter_set;
  
  SCPU U1(  
   	.clk(Clk_CPU),			//
	   .reset(rst),
		.MIO_ready(),
		.inst_in(inst[31:0]),
		.Data_in(Data_in[31:0]),								
		.mem_w(mem_w),
		.PC_out(PC[31:0]),
		.Addr_out(Addr_out[31:0]),
		.Data_out(Data_out[31:0]), 
		.CPU_MIO(),
		.INT(Counter0_out)
				);
  
  ROM_D U2(
    .a(PC[11:2]),
    .spo(inst[31:0])
  );
  
  RAM_B U3(
    .clka(~clk_100mhz),
    .wea(data_ram_we),
    .addra(ram_addr[9:0]),
    .dina(ram_data_in[31:0]),
    .douta(ram_data_out[31:0])
  );
				
	SEnter_2_32 M4(
	  .clk(clk_100mhz),
		.BTN(BTN_OK[2:0]),				//对应SAnti_jitter列按键
		.Ctrl({SW_OK[7:5], SW_OK[15], SW_OK[0]}),				//{SW[7:5],SW[15],SW[0]}
		.D_ready(RDY),					//对应SAnti_jitter扫描码有效
		.Din(XLXN_444[4:0]),
		.readn(readn), 			//=0读扫描码
		.Ai(Ai[31:0]),	//输出32位数一：Ai
		.Bi(Bi[31:0]),	//输出32位数二：Bi
		.blink(blink[7:0])				//单键输入指示
		);
		
	MIO_BUS U4(
	  .clk(clk_100mhz),
		.rst(rst),
		.BTN(BTN_OK[3:0]),
		.SW(SW_OK[15:0]),
	  .mem_w(mem_w), 
		.Cpu_data2bus(Data_out[31:0]),				//data from CPU
		.addr_bus(Addr_out[31:0]),
		.ram_data_out(ram_data_out[31:0]),
		.led_out(LED_out[15:0]),
		.counter_out(Counter_out[31:0]),
		.counter0_out(Counter0_out),
		.counter1_out(Counter1_out),
		.counter2_out(Counter2_out),
		.Cpu_data4bus(Data_in[31:0]),				//write to CPU
		.ram_data_in(ram_data_in[31:0]),				//from CPU write to Memory
		.ram_addr(ram_addr[9:0]),						//Memory Address signals
		.data_ram_we(data_ram_we),
		.GPIOf0000000_we(GPIOF0),
		.GPIOe0000000_we(GPIOE0),
		.counter_we(Counter_we),
		.Peripheral_in(CPU2IO[31:0])
		);
		
	Multi_8CH32 U5(
	  .clk(~Clk_CPU),
		.rst(rst),
		.EN(GPIOE0),								//Write EN
		.Test(SW_OK[7:5]),						//ALU&Clock,SW[7:5]	
    .point_in({Div[31:0], Div[31:0]}),					//针对8位显示输入各8个小数点
		.LES(64'h0000_0000_0000_0000),					//针对8位显示输入各8个闪烁位 // Confusing
	  .Data0(CPU2IO[31:0]),					//disp_cpudata
		.data1({2'b00, PC[31:2]}),
		.data2(inst[31:0]),
		.data3(Counter_out[31:0]),
		.data4(Addr_out[31:0]),
		.data5(Data_out[31:0]),
		.data6(Data_in[31:0]),
		.data7(PC[31:0]),
		.point_out(point_out[7:0]),
		.LE_out(LE_out[7:0]),
		.Disp_num(Disp_num[31:0])
		); 
		
	SSeg7_Dev U6(
	  .clk(clk_100mhz),			//	时钟
		.rst(rst),			//复位
		.Start(Div[20]),		//串行扫描启动
		.SW0(SW_OK[0]),			//文本(16进制)/图型(点阵)切换
		.flash(Div[25]),		//七段码闪烁频率
		.Hexs(Disp_num[31:0]),	//32位待显示输入数据
		.point(point_out[7:0]),	//七段码小数点：8个
	  .LES(LE_out[7:0]),		//七段码使能：=1时闪烁
		.seg_clk(seg_clk),	//串行移位时钟
		.seg_sout(seg_sout),	//七段显示数据(串行输出)
	  .SEG_PEN(SEG_PEN),	//七段码显示刷新使能
		.seg_clrn(seg_clrn)	//七段码显示汪零
		);
		
	SPIO U7(
	  .clk(~Clk_CPU),							//时钟
		.rst(rst),                    //复位
		.Start(Div[20]),                  //串行扫描启动
		.EN(GPIOF0),                     //PIO/LED显示刷新使能
		.P_Data(CPU2IO[31:0]),          //并行输入，用于串行输出数据
		.counter_set(Counter_set[1:0]),  //用于计数/定时模块控制，本实验不用
		.LED_out(LED_out[15:0]),        //并行输出数据
		.led_clk(led_clk),          //串行移位时钟
		.led_sout(led_sout),         //串行输出
		.led_clrn(led_clrn),         //LED显示清零
		.LED_PEN(LED_PEN),          //LED显示刷新使能
		.GPIOf0()			//待用：GPIO			 
		);
		
	clk_div U8(
	  .clk(clk_100mhz),
		.rst(rst),
		.SW2(SW_OK[2]),
		.clkdiv(Div[31:0]),
		.Clk_CPU(Clk_CPU)
		);
		
	SAnti_jitter U9(
	  .clk(clk_100mhz), 
	  .RSTN(RSTN),
		.readn(readn),
		.Key_y(BTN_y[3:0]),
		.Key_x(BTN_x[4:0]),
	  .SW(SW[15:0]), 
		.Key_out(XLXN_444[4:0]),
	  .Key_ready(RDY),
		.pulse_out(Pulse[3:0]),
		.BTN_OK(BTN_OK[3:0]),
	  .SW_OK(SW_OK[15:0]),
		.CR(CR),
		.rst(rst)
		);
		
	Counter_x U10(
	  .clk(~Clk_CPU),
		.rst(rst),
		.clk0(Div[6]),
		.clk1(Div[9]),
		.clk2(Div[11]),
		.counter_we(Counter_we),
		.counter_val(CPU2IO[31:0]),
		.counter_ch(Counter_set[1:0]),				//Counter channel set
		.counter0_OUT(Counter0_out),
		.counter1_OUT(Counter1_out),
		.counter2_OUT(Counter2_out),
		.counter_out(Counter_out)
		);
								
	  
endmodule
*/