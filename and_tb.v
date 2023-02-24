`timescale 1ns/10ps

module datapath_tb;
reg R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in;
reg R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out,
R15out;
reg HIin, LOin, PCin, IRin, Yin, InPortout, ZIn;
reg HIout, LOout, PCout, MDRout, MDRin, MARin, MDRread, Cout, clk, IncPC, ZLowout, ZHighout;

reg [3:0] ALUselect;
reg [31:0] Mdatain;
reg Read;

wire R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, HI, LO, IR, BusMuxOut;
wire [63:0] ZReg;

parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;

reg [3:0] Present_state = Default;

data_path DUT (
.R0in(R0in), .R1in(R1in), .R2in(R2in), .R3in(R3in), .R4in(R4in), .R5in(R5in), .R6in(R6in),
.R7in(R7in), .R8in(R8in), .R9in(R9in), .R10in(R10in), .R11in(R11in), .R12in(R12in), .R13in(R13in),
.R14in(R14in), .R15in(R15in), .R0out(R0out), .R1out(R1out), .R2out(R2out), .R3out(R3out),
.R4out(R4out), .R5out(R5out), .R6out(R6out), .R7out(R7out), .R8out(R8out), .R9out(R9out),
.R10out(R10out),
.R11out(R11out), .R12out(R12out), .R13out(R13out), .R14out(R14out), .R15out(R15out), .HIin(HIin),
.LOin(LOin),

.PCin(PCin), .IRin(IRin), .Yin(Yin), .InPortout(InPortout), .ZIn(ZIn), .HIout(HIout), .LOout(LOout),
.PCout(PCout),
.MDRout(MDRout), .MDRin(MDRin), .MARin(MARin), .MDRread(MDRread), .Cout(Cout), .clk(clk),
.IncPC(IncPC), .ZLowout(ZLowout),
.ZHighout(ZHighout), .ALUselect(ALUselect), .Mdatain(Mdatain), .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4),
.R5(R5), .R6(R6),
.R7(R7), .R8(R8), .R9(R9), .R10(R10), .R11(R11), .R12(R12), .R13(R13), .R14(R14), .R15(R15), .ZReg(ZReg)
);

// add test logic here

initial
	begin
		clk = 0;
		forever #10 clk = ~ clk;
	end


always @(posedge clk) // finite state machine; if clock rising-edge
begin
	case (Present_state) // 
		Default : #40 Present_state = Reg_load1a;
		Reg_load1a : #40 Present_state = Reg_load1b;
		Reg_load1b : #40 Present_state = Reg_load2a;
		Reg_load2a : #40 Present_state = Reg_load2b;
		Reg_load2b : #40 Present_state = Reg_load3a;
		Reg_load3a : #40 Present_state = Reg_load3b;
		Reg_load3b : #40 Present_state = T0;
		T0 : #40 Present_state = T1;
		T1 : #40 Present_state = T2;
		T2 : #40 Present_state = T3;
		T3 : #40 Present_state = T4;
		T4 : #40 Present_state = T5;
	endcase
end

always @(Present_state) // do the required job in each state
begin
	case (Present_state) // assert the required signals in each clock cycle
		Default: begin

							PCout <= 0; ZLowout <= 0; ZHighout <= 0; MDRout <= 0; // initialize the signals
							R2out <= 0; R4out <= 0; MARin <= 0; ZIn <= 0;
							PCin <=0; MDRin <= 0; IRin <= 0; Yin <= 0;
							IncPC <= 0; Read <= 0; ALUselect <= 0;
							R5in <= 0; R2in <= 0; R4in <= 0; Mdatain <= 32'h00000000;

		end
		Reg_load1a: begin

							Mdatain <= 32'h00000022;
							Read = 0; MDRin = 0; // the first zero is there for completeness
							#10 Read <= 1; MDRin <= 1;
							#15 Read <= 0; MDRin <= 0;

		end
		Reg_load1b: begin

							#10 MDRout <= 1; R2in <= 1;
							#15 MDRout <= 0; R2in <= 0; // initialize R2 with the value $22

		end
		Reg_load2a: begin

							Mdatain <= 32'h00000024;
							#10 Read <= 1; MDRin <= 1;
							#15 Read <= 0; MDRin <= 0;

		end
		Reg_load2b: begin

							#10 MDRout <= 1; R4in <= 1;
							#15 MDRout <= 0; R4in <= 0; // initialize R4 with the value $24

		end
		Reg_load3a: begin

							Mdatain <= 32'h00000026;
							#10 Read <= 1; MDRin <= 1;
							#15 Read <= 0; MDRin <= 0;

		end
		Reg_load3b: begin

							#10 MDRout <= 1; R5in <= 1;
							#15 MDRout <= 0; R5in <= 0; // initialize R5 with the value $26

		end
		T0: begin // see if you need to de-assert these signals

							PCout <= 1; MARin <= 1; IncPC <= 1; ZIn <= 1;

		end
		T1: begin

							ZLowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
							Mdatain <= 32'h4A920000; // opcode for “and R5, R2, R4”

		end
		T2: begin

							MDRout <= 1; IRin <= 1;

		end
		T3: begin

							R2out <= 1; Yin <= 1;

		end
		T4: begin

							R3out <= 1; AND <= 1; ZIn <= 1;

		end
		T5: begin
		
							ZLowout <= 1; R1in <= 1;

		end
	endcase
end
endmodule