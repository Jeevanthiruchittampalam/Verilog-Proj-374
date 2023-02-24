module bus (

    //encorder inputs
    input wire r0Signal,
    input wire r1Signal,
    input wire r2Signal,
    input wire r3Signal,
    input wire r4Signal,
    input wire r5Signal,
    input wire r6Signal,
    input wire r7Signal,
    input wire r8Signal,
    input wire r9Signal,
    input wire r10Signal,
    input wire r11Signal,
    input wire r12Signal,
    input wire r13Signal,
    input wire r14Signal,
    input wire r15Signal,

    input wire HISignal,
    input wire LOSignal,
    input wire ZHISignal,
    input wire ZLOSignal,
    input wire PCSignal,
    input wire MDRSignal,
    input wire InportSignal,
    input wire CSignal,


    //mux inputs start
    input [31:0] BusMuxIn_R0,
	input [31:0] BusMuxIn_R1,
	input [31:0] BusMuxIn_R2,
	input [31:0] BusMuxIn_R3, 
	input [31:0] BusMuxIn_R4,
	input [31:0] BusMuxIn_R5,
	input [31:0] BusMuxIn_R6,
	input [31:0] BusMuxIn_R7,
	input [31:0] BusMuxIn_R8,
	input [31:0] BusMuxIn_R9,
	input [31:0] BusMuxIn_R10,
	input [31:0] BusMuxIn_R11,
	input [31:0] BusMuxIn_R12,
	input [31:0] BusMuxIn_R13,
	input [31:0] BusMuxIn_R14,
	input [31:0] BusMuxIn_R15,
	
	input [31:0] BusMuxIn_HI,
	input [31:0] BusMuxIn_LO,
	input [31:0] BusMuxIn_Z_high,
	input [31:0] BusMuxIn_Z_low,
	input [31:0] BusMuxIn_PC,
	input [31:0] BusMuxIn_MDR,	
	input [31:0] BusMuxIn_InPort,
	input [31:0] C_sign_extended,
	
	// Multiplexer's output that feeds out of the bus and into the datapath
	output reg [31:0] BusMuxOut	
);

wire [4:0] connection;

encoder_32_to_5 my_encoder(
    .r0Signal(r0Signal),
    .r1Signal(r1Signal),
    .r2Signal(r2Signal),
    .r3Signal(r3Signal),
    .r4Signal(r4Signal),
    .r5Signal(r5Signal),
    .r6Signal(r6Signal),
    .r7Signal(r7Signal),
    .r8Signal(r8Signal),
    .r9Signal(r9Signal),
    .r10Signal(r10Signal),
    .r11Signal(r11Signal),
    .r12Signal(r12Signal),
    .r13Signal(r13Signal),
    .r14Signal(r14Signal),
    .r15Signal(r15Signal),

    .HISignal(HISignal),
    .LOSignal(LOSignal),
    .ZHISignal(ZHISignal),
    .ZLOSignal(ZLOSignal),
    .PCSignal(PCSignal),
    .MDRSignal(MDRSignal),
    .InportSignal(InportSignal),
    .CSignal(CSignal),

    .encoderOutput(connection)
);

mux_32_to_1 my_mux(
    .BusMuxIn_R0(BusMuxIn_R0),
	.BusMuxIn_R1(BusMuxIn_R1),
	.BusMuxIn_R2(BusMuxIn_R2),
	.BusMuxIn_R3(BusMuxIn_R3),
	.BusMuxIn_R4(BusMuxIn_R4),
	.BusMuxIn_R5(BusMuxIn_R5),
	.BusMuxIn_R6(BusMuxIn_R6),
	.BusMuxIn_R7(BusMuxIn_R7),
	.BusMuxIn_R8(BusMuxIn_R8),
	.BusMuxIn_R9(BusMuxIn_R9),
	.BusMuxIn_R10(BusMuxIn_R10),
	.BusMuxIn_R11(BusMuxIn_R11),
	.BusMuxIn_R12(BusMuxIn_R12),
	.BusMuxIn_R13(BusMuxIn_R13),
	.BusMuxIn_R14(BusMuxIn_R14),
	.BusMuxIn_R15(BusMuxIn_R15),
	.BusMuxIn_HI(BusMuxIn_HI),
	.BusMuxIn_LO(BusMuxIn_LO),
	.BusMuxIn_Z_high(BusMuxIn_Z_high),
	.BusMuxIn_Z_low(BusMuxIn_Z_low),
	.BusMuxIn_PC(BusMuxIn_PC),
	.BusMuxIn_MDR(BusMuxIn_MDR),
	.BusMuxIn_InPort(BusMuxIn_InPort),
	.C_sign_extended(C_sign_extended),
	
	.BusMuxOut(OutputToBus),

    .select_signal(connection)
);

endmodule