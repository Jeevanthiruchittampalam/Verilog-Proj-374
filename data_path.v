module data_path (

    // Register input and outputs
    input R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
    input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,

    //ir and pc
    input PCin, PCout, IRin,

    //mdr and mar?
    input MDRin, MDRout, MARin,

    //HI and LO REgs
    input HIin, LOin, HIout, LOout,

    //Y, ALU, and Z
    input Yin, Zlowin, Zhighin, //something for alu here

    output R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15,

    output [63:0] ZReg

);

wire [31:0] bus;
wire clr;
wire IROut;
wire [31:0] ZLowData, ZHighData;

//These go into the 32to1 multiplexer i think?
wire [31:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3,  BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6; 
    BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14;
    BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Z_high, BusMuxIn_Z_low, BusMuxIn_PC, BusMuxIn_MDR,	 BusMuxIn_InPort, C_sign_extended;

//all base registers with inputs from the bus and outputs to the 32to1 mux i think
reg_32_bits R0(clk, clr, enableR, bus, BusMuxIn_R0);
reg_32_bits R1(clk, clr, enableR, bus, BusMuxIn_R1);
reg_32_bits R2(clk, clr, enableR, bus, BusMuxIn_R2);
reg_32_bits R3(clk, clr, enableR, bus, BusMuxIn_R3);
reg_32_bits R4(clk, clr, enableR, bus, BusMuxIn_R4);
reg_32_bits R5(clk, clr, enableR, bus, BusMuxIn_R5);
reg_32_bits R6(clk, clr, enableR, bus, BusMuxIn_R6);
reg_32_bits R7(clk, clr, enableR, bus, BusMuxIn_R7);
reg_32_bits R8(clk, clr, enableR, bus, BusMuxIn_R8);
reg_32_bits R9(clk, clr, enableR, bus, BusMuxIn_R9);
reg_32_bits R10(clk, clr, enableR, bus, BusMuxIn_R10);
reg_32_bits R11(clk, clr, enableR, bus, BusMuxIn_R11;
reg_32_bits R12(clk, clr, enableR, bus, BusMuxIn_R12);
reg_32_bits R13(clk, clr, enableR, bus, BusMuxIn_R13);
reg_32_bits R14(clk, clr, enableR, bus, BusMuxIn_R14);
reg_32_bits R15(clk, clr, enableR, bus, BusMuxIn_R15);

endmodule