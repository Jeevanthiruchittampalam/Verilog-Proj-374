//v2

//added ZHIin, ZLOin, Zin, ZLO, ZHI, ZHIout, ZLOout, to datapath, 
//changed ZLowout/Highout to ZLow/HighSelect

module CPU_Datapath(


//I/0 Definition

//enables for the registers
input R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, //feeding into registers


//input signals for the encoders
R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, Yout,

//ins are enables for the registers, outs are input signals for the encoder
input HIin, Loin, ZHIin, ZLOin, PCin, MDRin, MARin, IRin, Yin, Zin, 
HIout, Loout, PCout, MDRout, MDRread, Cout, clk, clr, IncPC, ZLowSelect, ZHighSelect, ZHIout, ZLOout, InPortout, 

input [4:0] ALUSelection,
input[31:0] Mdatain,

output[31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, HI, LO, Y, ZLO, ZHI,

output  [63:0] Z_register

);//end of I/0

wire[31:0] bus;
//wire clr;
wire [31:0] IROut;
wire [31:0] YData, XData;
wire[63:0] ZData;
wire[31:0] ZHighData, ZLowData; //FROM Z_REG_64 to two seperate Z 32 Regs

//General Registers

wire [31:0] busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10, busInR11, busInR12, busInR13, busInR14, busInR15, busInPC, busInMAR, busInMDR, busInHI, busInLo,  busInInPort, busInC, busInY; 
wire [31:0] busInZHI, busInZLO;

//General Registers

//feeding out of registers into bus


general_register r0(R0in, clk, clr, bus, busInR0);
general_register r1(R1in, clk, clr, bus, busInR1);
general_register r2(R2in, clk, clr, bus, busInR2);
general_register r3(R3in, clk, clr, bus, busInR3);
general_register r4(R4in, clk, clr, bus, busInR4);
general_register r5(R5in, clk, clr, bus, busInR5);
general_register r6(R6in, clk, clr, bus, busInR6);
general_register r7(R7in, clk, clr, bus, busInR7);
general_register r8(R8in, clk, clr, bus, busInR8);
general_register r9(R9in, clk, clr, bus, busInR9);
general_register r10(R10in, clk, clr, bus, busInR10);
general_register r11(R11in, clk, clr, bus, busInR11);
general_register r12(R12in, clk, clr, bus, busInR12);
general_register r13(R13in, clk, clr, bus, busInR13);
general_register r14(R14in, clk, clr, bus, busInR14);
general_register r15(R15in, clk, clr, bus, busInR15);

//Program Counter and Instruction Register
general_register IR(IRin, clk, clr, bus, IROut);
program_counter_register PC(PCin, IncPC, clk, clr, bus, busInPC);

//MAR and MDR

general_register MAR(MARin, clk, clr, bus, busInMAR);
MDR_register MDR(clk, clr, MDRread, MDRin, bus, Mdatain, busInMDR);

//Other Special Registers

general_register hi(HIin, clk, clr, bus, busInHI);
general_register lo(Loin, clk, clr, bus, busInLo);


general_register zhi(ZHIin, clk, clr, ZHighData, busInZHI);
general_register zlo(ZLOin, clk, clr, ZLowData, busInZLO);

z_register_64_bits z_reg_from_alu(Zin, ZLowSelect, ZHighSelect, clk, clr, ZData, ZHighData, ZLowData);

/*
module z_register_64_bits(
input ZIn, ZLowSelect, ZHighSelect, clk, clr,
//Zin is enable, ZLow/High Select selects which is outputted
input[63:0] D,
output reg [31:0] ZHighDataOut, ZLowDataOut

);

*/


general_register y(Yin, clk, clr, bus, YData);

//assign Z_register[63:32] = ZData[63:32]; 
//assign Z_register[31:0] = ZData[31:0];

//ALU
//CPU_ALU_2 my_alu(clk, clr, bus, YData, ALUSelection,64bit output);
CPU_ALU_2 my_alu(clk, bus, YData, ALUSelection, ZData);

//assign busInZHI = Z_register[63:32];
//assign busInZLO = Z_register[31:0];

//ALU feeds to ZData


//Bus
bidirectional_bus my_bus(
//enable signals for the encoder
R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout, Loout, ZHIout, ZLOout, PCout, MDRout, InPortout, Cout, Yout,
//Yout,

//inputs for the multiplexer
busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10, busInR11, busInR12, busInR13,busInR14, busInR15, busInHI, busInLo, busInZHI, busInZLO, busInPC, busInMDR,  busInInPort, busInC, busInY,
//busInY,

//output of bus
bus

);


assign R0 = busInR0;
assign R1 = busInR1;
assign R2 = busInR2;
assign R3 = busInR3;

assign R4 = busInR4;
assign R5 = busInR5;
assign R6 = busInR6;
assign R7 = busInR7;
assign R8 = busInR8;
assign R9 = busInR9;
assign R10 = busInR10;
assign R11 = busInR11;
assign R12 = busInR12;
assign R13 = busInR13;
assign R14 = busInR14;
assign R15 = busInR15;
assign HI = busInHI;
assign LO = busInLo;
assign Y = YData;
assign ZLO = busInZLO;
assign ZHI = busInZHI;
assign Z_register = ZData;




endmodule

