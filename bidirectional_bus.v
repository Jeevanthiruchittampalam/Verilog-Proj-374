module bidirectional_bus(

//need encoder enables, inputs from registers, and output to datapath from bus

//enable signals for the encoder

    input wire R0Signal,
    input wire R1Signal,
    input wire R2Signal,
    input wire R3Signal,
    input wire R4Signal,
    input wire R5Signal,
    input wire R6Signal,
    input wire R7Signal,
    input wire R8Signal,
    input wire R9Signal,
    input wire R10Signal,
    input wire R11Signal,
    input wire R12Signal,
    input wire R13Signal,
    input wire R14Signal,
    input wire R15Signal, //end of default registers
    input wire HISignal,
    input wire LOSignal,
    input wire ZHISignal,
    input wire ZLOSignal,
    input wire PCSignal,
    input wire MDRSignal,
    input wire InportSignal,
    input wire CSignal,
	 input wire encoderY,
	 
	 
	 //mux inputs start
   input [31:0] BusMuxInputs_R0,
	input [31:0] BusMuxInputs_R1,
	input [31:0] BusMuxInputs_R2,
	input [31:0] BusMuxInputs_R3, 
	input [31:0] BusMuxInputs_R4,
	input [31:0] BusMuxInputs_R5,
	input [31:0] BusMuxInputs_R6,
	input [31:0] BusMuxInputs_R7,
	input [31:0] BusMuxInputs_R8,
	input [31:0] BusMuxInputs_R9,
	input [31:0] BusMuxInputs_R10,
	input [31:0] BusMuxInputs_R11,
	input [31:0] BusMuxInputs_R12,
	input [31:0] BusMuxInputs_R13,
	input [31:0] BusMuxInputs_R14,
	input [31:0] BusMuxInputs_R15, //end of default registers
	input [31:0] BusMuxInputs_HI,
	input [31:0] BusMuxInputs_LO,
	input [31:0] BusMuxInputs_Z_high,
	input [31:0] BusMuxInputs_Z_low,
	input [31:0] BusMuxInputs_PC,
	input [31:0] BusMuxInputs_MDR,	
	input [31:0] BusMuxInputs_InPort,
	input [31:0] BusMuxInputs_C_sign_extended,
	input [31:0] BusMuxInputs_Y,
	
	
	//output from bus to datapath
	output [31:0] BusMuxOutToDatapath	


);

//wire for connecting the encoder to the multiplexer
wire [4:0] connection;

encoder_32_to_5_for_bus bus_encoder(

	.R0Out(R0Signal),
	.R1Out(R1Signal),
	.R2Out(R2Signal),
	.R3Out(R3Signal),
	.R4Out(R4Signal),
	.R5Out(R5Signal),
	.R6Out(R6Signal),
	.R7Out(R7Signal),
	.R8Out(R8Signal),
	.R9Out(R9Signal),
	.R10Out(R10Signal),
	.R11Out(R11Signal),
	.R12Out(R12Signal),
	.R13Out(R13Signal),
	.R14Out(R14Signal),
	.R15Out(R15Signal),
	.HIOut(HISignal),
	.LOOut(LOSignal),
	.ZHIOut(ZHISignal),
	.ZLOOut(ZLOSignal),
	.PCOut(PCSignal),
	.MDROut(MDRSignal),
	.InportOut(InportSignal),
	.COut(CSignal),
	.Yout(encoderY),
	
	//output of the encoder feeds to connection, which will feed to the multiplexer
	.encoderOutput(connection)
);

multiplexer_32_to_1 bus_multiplexer(

	.BusMuxIn_R0(BusMuxInputs_R0),
	.BusMuxIn_R1(BusMuxInputs_R1),
	.BusMuxIn_R2(BusMuxInputs_R2),
	.BusMuxIn_R3(BusMuxInputs_R3),
	.BusMuxIn_R4(BusMuxInputs_R4),
	.BusMuxIn_R5(BusMuxInputs_R5),
	.BusMuxIn_R6(BusMuxInputs_R6),
	.BusMuxIn_R7(BusMuxInputs_R7),
	.BusMuxIn_R8(BusMuxInputs_R8),
	.BusMuxIn_R9(BusMuxInputs_R9),
	.BusMuxIn_R10(BusMuxInputs_R10),
	.BusMuxIn_R11(BusMuxInputs_R11),
	.BusMuxIn_R12(BusMuxInputs_R12),
	.BusMuxIn_R13(BusMuxInputs_R13),
	.BusMuxIn_R14(BusMuxInputs_R14),
	.BusMuxIn_R15(BusMuxInputs_R15), //end of default registers
	.BusMuxIn_HI(BusMuxInputs_HI),
	.BusMuxIn_LO(BusMuxInputs_LO),
	.BusMuxIn_Z_high(BusMuxInputs_Z_high),
	.BusMuxIn_Z_low(BusMuxInputs_Z_low),
	.BusMuxIn_PC(BusMuxInputs_PC),
	.BusMuxIn_MDR(BusMuxInputs_MDR),
	.BusMuxIn_InPort(BusMuxInputs_InPort),
	.C_sign_extended(BusMuxInputs_C_sign_extended),
	.BusMuxIn_Y(BusMuxInputs_Y),
	
	.select_signal(connection),
	
	.BusMuxOut(BusMuxOutToDatapath)

);



endmodule

