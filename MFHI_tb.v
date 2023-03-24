
//define PC_START 0
`timescale 1ns/10ps

module MFHI_tb();
	reg HIin, LOin, PCin, IRin, Yin, InPortout, Zlowin, Zhighin, Zin;
	reg HIout, LOout, PCout, Yout, MDRout, MDRin, MARin, MDRread, MARout, Cout, clk, clr, IncPC, ZLowout, ZHighout, ZLowSelect, ZHighSelect, IRout, InPortOut;
	//theoretically, IRout should not do anything as it's output feeds to instruction
	reg[3:0] ALUSELECTION;
	reg Gra, Grb, Grc, Rin, Rout;
	reg BAout;
	wire conffout;
	reg conffin, wren, OPin;
	
	parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101, T7 = 4'b1110, T8 = 4'b1111;

	reg[3:0] Present_state = Default;
	
	reg[4:0] testALUSelection = 5'b00101;
	reg[31:0] testMdatain;
	wire[8:0] testMAR;
	wire[63:0] testZReg;
	wire[31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12; 
	wire[15:0] R13, R14;
	wire[31:0] R15, HI, LO, Y, ZLO, ZHI, IR, INPORT, OUTPORT;
	
	
	
	//reg [31:0] memory [511:0]; // 32-bit memory
	//initial begin
	  //$readmemh("testmif.mif", memory); // Load data from MIF file
	//end


	
	CPU_Datapath DUT (
	.HIin(HIin), 
	.Loin(LOin),
	.ZHIin(Zhighin),
	.ZLOin(Zlowin),
	.PCin(PCin),
	.MDRin(MDRin),
	.MARin(MARin),
	.IRin(IRin),
	.Yin(Yin),
	.Zin(Zin),
	.HIout(HIout),
	.Loout(LOout),
	.PCout(PCout),
	.MDRout(MDRout),
	.MARout(MARout),
	.MDRread(MDRread),
	.Yout(Yout),
	.IRout(IRout),
	.Cout(Cout),
	.clk(clk),
	.clr(clr),
	.IncPC(IncPC),
	.ZLowSelect(ZLowSelect),
	.ZHighSelect(ZHighSelect),
	.ZHIout(ZHighout),
	.ZLOout(ZLowout),
	.InPortout(InPortOut),
	.OPin(OPin),
	.Gra(Gra),
	.Grb(Grb),
	.Grc(Grc),
	.Rin(Rin),
	.Rout(Rout),
	.BAout(BAout),
	.CON_FF_In(conffin),
	.CON_FF_Out(conffout),
	.wren(wren),
	.ALUSelection(testALUSelection),
	.in_32(testMdatain),
	.R0(R0),
	.R1(R1),
	.R2(R2),
	.R3(R3),
	.R4(R4),
	.R5(R5),
	.R6(R6),
	.R7(R7),
	.R8(R8),
	.R9(R9),
	.R10(R10),
	.R11(R11),
	.R12(R12),
	.R13(R13),
	.R14(R14),
	.R15(R15),
	.HI(HI),
	.LO(LO),
	.Y(Y),
	.ZLO(ZLO),
	.ZHI(ZHI),
	.IR(IR),
	.INPORT(INPORT),
	.OUTPORT(OUTPORT),
	.MAR(testMAR),
	.Z_register(testZReg)
	
	);
	
	
//testing code below:

initial
		begin
				clk = 0;
				forever #10 clk = ~clk;
		end
		

always @(posedge clk) //finite state machine, if clock edge rising
	begin
				case (Present_state)
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
					T5 : #40 Present_state = T6;
					T6 : #40 Present_state = T7;
					T7 : #40 Present_state = T8;
					
				endcase
		end
	

	
	
		
always @(Present_state) //do job at each state
	begin
			case(Present_state) //assert the required signals
			
					Default: begin
							PCout <= 0;
							MARin <= 0;
							IncPC <= 0;
							Zin <= 0;
							ZLowout <= 0;
							PCin <= 0;
							MDRread <= 0;
							testMdatain <= 32'h01000044;
							MDRin <= 0;
							MDRout <= 0; 
							IRin <= 0;
							Grb <= 0;
							BAout <= 0;
							Yin <= 0;
							Cout <= 0;
							Gra <= 0;	
							Grc <= 0;
							Rin <= 0;
							Rout <= 0;
							HIin <= 0;
							LOin <= 0;
							InPortout <=0; 
							Zlowin <= 0;
							Zhighin <=0;
							HIout <= 0;
							LOout <= 0;
							Yout <= 0;
							MARout<= 0;
							clr <= 0;
							ZHighout<=0;
							ZLowSelect<=0;
							ZHighSelect<=0;
							IRout<=0;
							InPortOut<=0;
							testALUSelection<=5'b0;
							//conffout<=0;
							conffin<=0;
							wren<=0;
							OPin<=0;
							
							
							
							
							

							
						end
						
						Reg_load1a : begin
										InPortOut<=1; IRin<=1; MARin<=1; IncPC<=1; Zin<=1;

									end
									
						Reg_load1b : begin
						PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0; InPortOut<=0; IRin<=0;
						ZLowout <= 1; PCin <= 1; MDRread <= 1;
MDRin <= 1;
						
						
								end
									
						Reg_load2a: begin
				ZLowout <= 0; PCin <=0; MDRread <=0; MDRin<=0; 
MDRout<=0; IRin<=0; HIin<=0;
Grb<=1; BAout<=1; Yin<=1;
						

						
						end
						
						
						Reg_load2b: begin
						Grb<=0; BAout<=0; Yin<=0;
Cout <=1; Zin<=1; 
#2 testALUSelection <= 5'b00001; 
Cout<=0; Zin<=0;
ZLowout<=1; MARin<=1;
						

						end
						
						Reg_load3a: begin
						ZLowout<=0; MARin<=0;
						MDRread<=0; MDRin<=0;
MDRout<=1;Gra<=1;Rin<=1;

						

						
						end
						

						Reg_load3b: begin
						MDRout<=0;Gra<=0;Rin<=0;
						testMdatain <= 32'hC3000000;
						InPortOut<=1; IRin<=1;

						end
						
						T0: begin 
						IRin<=0;
						InPortOut <= 1; 
						MARin <= 1; IncPC <= 1; Zin <= 1; 
						//PCout<=1;
						
						
						end
						
						
						T1: begin

						PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
						ZLowout <= 1; PCin <= 1; MDRread <= 1;
						MDRin <= 1;


						
						end
						
						
						
						T2: begin
						
						ZLowout <= 0; PCin <=0; MDRread <=0; MDRin<=0; 
						//MDRout<=1; IRin<=0; HIin <=1;
						
					
						
						 
						
						end
						
						T3: begin
						
						MDRout<=0; IRin<=0; HIin<=0;
						Grb<=1; BAout<=1; Yin<=1;

						
						end
						
						T4: begin
												Grb<=0; BAout<=0; Yin<=0;
												Cout <=1; Zin<=1; 
												#20 testALUSelection <= 5'b00001; 
						 

						


						end
						
						T5: begin
						Cout<=0; Zin<=0;
						ZLowout<=1; MARin<=1;
						

						end
						
						T6: begin
						ZLowout<=0; MARin<=0;
						//MDRread<=1; 
						//InPortOut<=1; 
						//MDRin<=1;
						
						end
						
						T7: begin
						MDRread<=0; MDRin<=0;
						MDRout<=1;Gra<=1;Rin<=1;
						end
						
					endcase
					

				end
	
	
endmodule
