//v2
module CPU_Datapath(

//enables for the registers
//input R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, //feeding into registers


//input signals for the encoders
//R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, Yout, IRout,

//ins are enables for the registers, outs are input signals for the encoder
input HIin, Loin, ZHIin, ZLOin, PCin, MDRin, MARin, IRin, Yin, Zin, 
HIout, Loout, PCout, MDRout, MARout, MDRread, Yout, IRout, Cout, clk, clr, IncPC, ZLowSelect, ZHighSelect, ZHIout, ZLOout, InPortout, OPin, 


input Gra, Grb, Grc, Rin, Rout,

input BAout,
input CON_FF_In, CON_FF_Out, wren,

input [4:0] ALUSelection,
input[31:0] Mdatain,

output[31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, HI, LO, Y, ZLO, ZHI, IR, OUTPORT,

output [8:0] MAR, 


output  [63:0] Z_register

);

wire [31:0] mData;
assign mData = Mdatain;

wire[31:0] bus;
//wire clr;
//wire [31:0] IROut;
wire [31:0] YData, XData;
wire[63:0] ZData;
wire[31:0] ZHighData, ZLowData; //FROM Z_REG_64 to two seperate Z 32 Regs

wire[31:0] instruction;
//assign instruction = INPUTDATA;

	



//We have 2 wires? Idk which one works.
wire [4:0] opcode;

wire R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out;

//General Registers

wire[31:0] busInPC, busInMDR, busInHI, busInLo,  busInInPort, busInC, busInY; 
wire [31:0] busInZHI, busInZLO, busInIR; 
wire[8:0] busInMAR;

wire [15:0] reg_ctrl_in, reg_ctrl_out;

//General Registers
wire [31:0] busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10, busInR11, busInR12, busInR13, busInR14, busInR15;

R0_register r0(reg_ctrl_in[0], clk, clr, bus, BAout, busInR0);
general_register r1(reg_ctrl_in[1], clk, clr, bus, busInR1);
general_register r2(reg_ctrl_in[2], clk, clr, bus, busInR2);
general_register r3(reg_ctrl_in[3], clk, clr, bus, busInR3);
general_register r4(reg_ctrl_in[4], clk, clr, bus, busInR4);
general_register r5(reg_ctrl_in[5], clk, clr, bus, busInR5);
general_register r6(reg_ctrl_in[6], clk, clr, bus, busInR6);
general_register r7(reg_ctrl_in[7], clk, clr, bus, busInR7);
general_register r8(reg_ctrl_in[8], clk, clr, bus, busInR8);
general_register r9(reg_ctrl_in[9], clk, clr, bus, busInR9);
general_register r10(reg_ctrl_in[10], clk, clr, bus, busInR10);
general_register r11(reg_ctrl_in[11], clk, clr, bus, busInR11);
general_register r12(reg_ctrl_in[12], clk, clr, bus, busInR12);
general_register r13(reg_ctrl_in[13], clk, clr, bus, busInR13);
general_register r14(reg_ctrl_in[14], clk, clr, bus, busInR14);
general_register r15(reg_ctrl_in[15], clk, clr, bus, busInR15);

assign R0out = reg_ctrl_out[0];
assign R1out = reg_ctrl_out[1];
assign R2out = reg_ctrl_out[2];
assign R3out = reg_ctrl_out[3];
assign R4out = reg_ctrl_out[4];
assign R5out = reg_ctrl_out[5];
assign R6out = reg_ctrl_out[6];
assign R7out = reg_ctrl_out[7];
assign R8out = reg_ctrl_out[8];
assign R9out = reg_ctrl_out[9];
assign R10out = reg_ctrl_out[10];
assign R11out = reg_ctrl_out[11];
assign R12out = reg_ctrl_out[12];
assign R13out = reg_ctrl_out[13];
assign R14out = reg_ctrl_out[14];
assign R15out = reg_ctrl_out[15];

//RAM instatiation
wire[31:0] dataFromRAM;
ram CPU_RAM(.data(bus), .read_addr(busInMAR), .write_addr(busInMAR[8:0]), .we(wren), .clk(clk), .q(dataFromRAM));


//Program Counter and Instruction Register
general_register ir_reg(IRin, clk, clr, bus, instruction);
program_counter_register PC(PCin, IncPC, clk, clr, bus, busInPC);

//MAR and MDR

mar_unit MAR_reg(MARin, clk, clr, bus, busInMAR[8:0]);
MDR_register MDR(clk, clr, MDRread, MDRin, bus, dataFromRAM, busInMDR);

//Y register
general_register y(Yin, clk, clr, bus, YData);

//Other Special Registers
general_register hi(HIin, clk, clr, bus, busInHI);
general_register lo(Loin, clk, clr, bus, busInLo);
general_register zhi(ZHIin, clk, clr, ZHighData, busInZHI);
general_register zlo(ZLOin, clk, clr, ZLowData, busInZLO);
z_register_64_bits z_reg_from_alu(Zin, ZLowSelect, ZHighSelect, clk, clr, ZData, ZHighData, ZLowData);



//I/O ports
wire[31:0] OPdata;
wire[31:0] IPdatain;

general_register IP(InPortout, clk, clr, Mdatain, busInInPort);
general_register OP(OPin, clk, clr, bus, OPdata);


//ALU
CPU_ALU_2 my_alu(clk, bus, YData, ALUSelection, ZData);

//CON FF
CON_FF_LOGIC cffl_instance(instruction, bus, CON_FF_In, CON_FF_Out);

//Select and Encode
wire[31:0] CData;
//wire [15:0] regIn, regOut;
wire[3:0] decoderWire;
select_and_encode SEL_instance(instruction, Gra, Grb, Grc, Rin, Rout, BAout, opcode, CData, reg_ctrl_in, reg_ctrl_out, decoderWire);



//Bus
bidirectional_bus my_bus(
//enable signals for the encoder
R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout, Loout, ZHIout, ZLOout, PCout, MDRout, InPortout, Cout, Yout, IRout, MARout,
//Yout,

//inputs for the multiplexer
busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10, busInR11, busInR12, busInR13,busInR14, busInR15, busInHI, busInLo, busInZHI, busInZLO, busInPC, busInMDR,  busInInPort, busInC, busInY, busInIR, busInMAR,
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
assign IR = instruction; 
assign MAR = busInMAR; 
assign OUTPORT = OPdata;




endmodule

