module cpu_bus(
input clk, clr, stop,
input[31:0] bus_Signal;
output[31:0] bus_contents,   //busmuxout feeds to this
output[31:0] outport_Output;
output[5:0] operation  //INPUT OR OUTPUT?


); //instantiating bus


//enable wires for special registers:
wire MARin, PCin, MDRin, IRin, Yin, IncPC, Read, 
			HIin, LOin, ZHighIn, ZLowIn, enableOutport, enableInput, Cenable;


//23 wires for the 32-5 encoder
wire R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
    HIout, LOout, Zhighout, Zlowout, PCout, MDRout, In.portout, Cout;


//IncPC is the clear signal for the PC

//wire PCout, Zhighout, Zlowout, MDRout, MARin, PCin, MDRin, IRin, Yin, IncPC, Read, 

	 //Inputs to the bus's 32-to_1 multiplexer
	wire [31:0] R0_data_out;
	wire [31:0] R1_data_out;
	wire [31:0] R2_data_out;
	wire [31:0] R3_data_out;
	wire [31:0] R4_data_out;
	wire [31:0] R5_data_out;
	wire [31:0] R6_data_out;
	wire [31:0] R7_data_out;
	wire [31:0] R8_data_out;
	wire [31:0] R9_data_out;
	wire [31:0] R10_data_out;
	wire [31:0] R11_data_out;
	wire [31:0] R12_data_out;
	wire [31:0] R13_data_out;
	wire [31:0] R14_data_out;
	wire [31:0] R15_data_out;

	wire [31:0] HI_data_out;
	wire [31:0] LO_data_out;
	wire [31:0] ZHigh_data_out;
	wire [31:0] ZLow_data_out;
	wire [31:0] PC_data_out;
	wire [31:0] MDR_data_out;
	wire [31:0] InPort_data_out;
	wire [31:0] Y_data_out;
	wire [31:0] RAM_data_out;
	wire [8:0] MAR_data_out;
	wire [31:0] IR_data_out;
	wire [31:0] C_sign_extended;


    //64 bits for the z outputs. 
	wire [63:0] C_data_out;

	wire [31:0] Input_Port_dataout;
	wire [4:0]  bus_encoder_signal; //5 bit input that comes as the output of the encoder
	//wire con_out; ????


    //then we create all 32-bit registers

    /*
	input wire clk,
	input wire clr,
	input wire enable,
	input wire [31:0] d,
	output reg [31:0] q
	
    */

    reg  [15:0] enableR; //enable signals for each register? Where does it come from

    reg_32_bits R0(clk. clr, enableR[0], bus_contents, R0_data_out);
    reg_32_bits R1(clk. clr, enableR[1], bus_contents, R1_data_out);
    reg_32_bits R2(clk. clr, enableR[2], bus_contents, R2_data_out);
    reg_32_bits R3(clk. clr, enableR[3], bus_contents, R3_data_out);
    reg_32_bits R4(clk. clr, enableR[4], bus_contents, R4_data_out);
    reg_32_bits R5(clk. clr, enableR[5], bus_contents, R5_data_out);
    reg_32_bits R6(clk. clr, enableR[6], bus_contents, R6_data_out);
    reg_32_bits R7(clk. clr, enableR[7], bus_contents, R7_data_out);
    reg_32_bits R8(clk. clr, enableR[8], bus_contents, R8_data_out);
    reg_32_bits R9(clk. clr, enableR[9], bus_contents, R9_data_out);
    reg_32_bits R10(clk. clr, enableR[10], bus_contents, R10_data_out);
    reg_32_bits R11(clk. clr, enableR[11], bus_contents, R11_data_out);
    reg_32_bits R12(clk. clr, enableR[12], bus_contents, R12_data_out);
    reg_32_bits R13(clk. clr, enableR[13], bus_contents, R13_data_out);
    reg_32_bits R14(clk. clr, enableR[14], bus_contents, R14_data_out);
    reg_32_bits R15(clk. clr, enableR[15], bus_contents, R15_data_out);

    //other registers





    reg_32_bits HI(clk, clr, HIin, bus_contents, HI_data_out);
    reg_32_bits LO(clk, clr, LOin, bus_contents, LO_data_out);

    //two registers for the Z output (64 bits)
    reg_32_bits Z_High(clk, clr, ZHighIn, c_data_out[63:32], ZHigh_data_out);
    reg_32_bits Z_Low(clk, clr, ZLowIn, c_data[63:32], ZLow_data_out);


    //IR and PC
    reg_32_bits PC(clk, IncPC, PCin, bus_contents, PC_data_out);
    reg_32_bits IR(clr, clr, IRin, bus_contents, IR_data_out);



    //MDR stuff----------------------------------------------------------------------------------------
    wire [31:0] MDR_mux_out;

	// Define the multiplexer used for the MDR
	mux_2_to_1 MDMux(bus_contents, RAM_data_out, Read, MDR_mux_out);

	// Instatiating the MDR register
	reg_32_bits MDR_reg(clk, clr, MDRin, MDR_mux_out, MDR_data_out);
    //--------------------------------------------------------------------------------------------------

    //input and output port registers. 
    reg_32_bits Inport_reg(clk, clr, 1'd1, bus_input, Input_Port_dataout);
	reg_32_bits Outport_reg(clk, clr, enableOutport, bus_contents, Outport_Output);

    //y register
    reg_32_bits Y(clk, clr, Yin, bus_contents, Y_data_out);

    //C register



    
    //defining 32-5 ENCODER

    encoder_32_to_5 busEncoder(
    .r0Signal(R0out),
    .r1Signal(R1out),
    .r2Signal(R2out),
    .r3Signal(R3out),
    .r4Signal(R4out),
    .r5Signal(R5out),
    .r6Signal(R6out),
    .r7Signal(R7out),
    .r8Signal(R8out),
    .r9Signal(R9out),
    .r10Signal(R10out),
    .r11Signal(R11out),
    .r12Signal(R12out),
    .r13Signal(R13out),
    .r14Signal(R14out),
    .r14Signal(R15out),
    .HISignal(HIout),
    .LOSignal(LOout),
    .ZHISignal(Zhighout),
    .ZLOSignal(Zlowout),
    .PCSignal(PCout),
    .MDRSignal(MDRout),
    .InportSignal(In.portout),
    .CSignal(Cout)
    //output
    .encoderOutput(bus_encoder_signal)
    
    );


    mux_32_to_1 BusMultiplexer(

        //default registers
	    .BusMuxIn_R0(R0_data_out),
		.BusMuxIn_R1(R1_data_out), 
		.BusMuxIn_R2(R2_data_out),
		.BusMuxIn_R3(R3_data_out),
		.BusMuxIn_R4(R4_data_out),
		.BusMuxIn_R5(R5_data_out),
		.BusMuxIn_R6(R6_data_out),
		.BusMuxIn_R7(R7_data_out),
		.BusMuxIn_R8(R8_data_out),
		.BusMuxIn_R9(R9_data_out),
		.BusMuxIn_R10(R10_data_out),
		.BusMuxIn_R11(R11_data_out),
		.BusMuxIn_R12(R12_data_out),
		.BusMuxIn_R13(R13_data_out),
		.BusMuxIn_R14(R14_data_out),
		.BusMuxIn_R15(R15_data_out),

        //other registers
		.BusMuxIn_LO(LO_data_out),
		.BusMuxIn_Z_high(ZHigh_data_out),
		.BusMuxIn_Z_low(ZLow_data_out),
		.BusMuxIn_PC(PC_data_out),
		.BusMuxIn_MDR(MDR_data_out),	
		.BusMuxIn_InPort(Input_Port_dataout),
		.C_sign_extended(C_sign_extended),

        //output from mux
		.BusMuxOut(bus_contents),

        //input from encoder
		.select_signal(bus_encoder_signal)

    );



ALU MY_ALU(
    .clk(clk),
    .clr(clr),
    .a(bus_contents),  //?
    .b(bus_contents),
    .y(Y_data_out),
    .opcode(operation),
    .C_Register(C_data_out)
);


endmodule

