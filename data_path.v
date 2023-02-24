module data_path (

    // Register input and outputs
    input R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
    input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,

    //ir and pc
    input PCin, PCout, IRin,

    //mdr and mar?
    input MDRin, MDRout, MARin, IncPC, //IncPC for incrementing PC

    input Cout, InPortout,

    //HI and LO REgs
    input HIin, LOin, HIout, LOout, ZLowout, ZHighout,

    

    //Y, ALU, and Z
    input Yin, Zlowin, Zhighin, //something for alu here

    input [4:0] ALUselect, //select instruction for alu

    output R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15


);
//the bus wire seems to be the input for everything
wire [31:0] bus;

wire clr;
wire IROut;
//wire [31:0] ZLowData, ZHighData; do we use this?

    //64 bits for the z outputs. 
	wire [63:0] C_data_out;


//Ywire going in and ALU output??
wire [31:0] YData, XData;

//These go into the 32to1 multiplexer i think?
wire [31:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3,  BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, 
    BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14,
    BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Z_high, BusMuxIn_Z_low, BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_MAR, BusMuxIn_InPort, C_sign_extended;

//all base registers with inputs from the bus and outputs to the 32to1 mux i think
reg_32_bits r0(clk, clr, R0in, bus, BusMuxIn_R0); 
reg_32_bits r1(clk, clr, R1in, bus, BusMuxIn_R1); 
reg_32_bits r2(clk, clr, R2in, bus, BusMuxIn_R2);
reg_32_bits r3(clk, clr, R3in, bus, BusMuxIn_R3);
reg_32_bits r4(clk, clr, R4in, bus, BusMuxIn_R4);
reg_32_bits r5(clk, clr, R5in, bus, BusMuxIn_R5);
reg_32_bits r6(clk, clr, R6in, bus, BusMuxIn_R6);
reg_32_bits r7(clk, clr, R7in, bus, BusMuxIn_R7);
reg_32_bits r8(clk, clr, R8in, bus, BusMuxIn_R8);
reg_32_bits r9(clk, clr, R9in, bus, BusMuxIn_R9);
reg_32_bits r10(clk, clr, R10in, bus, BusMuxIn_R10);
reg_32_bits r11(clk, clr, R11in, bus, BusMuxIn_R11);
reg_32_bits r12(clk, clr, R12in, bus, BusMuxIn_R12);
reg_32_bits r13(clk, clr, R13in, bus, BusMuxIn_R13);
reg_32_bits r14(clk, clr, R14in, bus, BusMuxIn_R14);
reg_32_bits r15(clk, clr, R15in, bus, BusMuxIn_R15);

//PC and IR
reg_32_bits ir(clk, clr, iRin, bus, IRout); 
pc_reg pc(clk, clr, incPC, PCin, bus, BusMuxIn_PC);

// MAR and MDR
reg_32_bits mar(clk, clr, MARin, bus, busMuxInMAR);
MDR mdr(clk, MDRread, clr, bus, Mdatain, MDRin, busMuxInMDR);


// clk, clr, enable, input,output is OURS
// output, input, enable,clk,clr

//Special Registers - HI, LO, Y, and Zhi and Zlo
reg_32_bits hi(clk, clr, HIin, bus, busMUXInHI);
reg_32_bits lo(clk, clr, LOin, bus, BusMuxIn_LO);
reg_32_bits y(clk, clr, Yin, bus, YData);

reg_32_bits zHI(clk, clr, zHighin, C_data_out[63:32], ZHighout); //
reg_32_bits ZLO(clk, clr, zLowIn, C_data_out[31:0], ZLowout);  //


ALU MY_ALU(clk, clr, bus, bus, Ydata, ALUselect, C_data_out);
assign BusMuxIn_Z_high = C_data_out[63:0];
assign BusMuxIn_Z_low = C_data_out[31:0];



//Bus
bus my_bus(
BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3,  BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6,
BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14,
BusMuxIn_R15,

BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Z_high, BusMuxIn_Z_low, BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_InPort, C_sign_extended,


R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, 

HIout, LOout, ZHighout, ZLowout, PCout, MDRout, InPortout, Cout
);


endmodule