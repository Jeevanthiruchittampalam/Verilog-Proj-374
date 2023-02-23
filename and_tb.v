`timescale 1ns / 10ps

 // setting input and output registers
module and_tb; 	                                            
	reg	PCout, ZHighout, Zlowout, MDRout, R2out, R4out;
	reg	MARin, PCin, MDRin, IRin, Yin;
	reg IncPC, Read;
	reg [4:0] AND; 
	reg R5in, R2in, R4in;
	reg R1in, R3in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in;
	reg	HIin, LOin, ZHighIn, Cin, ZLowIn;
	reg	Clock, Clear;		
	reg	[31:0] Mdatain;

//Defines a set of parameters used as states in the finite state machine
parameter	Default = 4'b0000, Reg_load1a= 4'b0001, Reg_load1b= 4'b0010,
					Reg_load2a= 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101,
					Reg_load3b = 4'b0110, T0= 4'b0111, T1= 4'b1000,T2= 4'b1001, T3= 4'b1010, T4= 4'b1011, T5= 4'b1100;
reg	[3:0] Present_state= Default;

initial Clear = 0;

//Creates an instance of the DUT named DUT
cpu DUT(PCout, ZHighout, Zlowout, MDRout, R2out, R4out, MARin, PCin, MDRin, IRin, Yin, IncPC,Read,
 AND,R5in, R2in, R4in,Clock, Mdatain, Clear, R1in, R3in, R6in, R7in, R8in, R9in, R10in, R11in, 
 R12in, R13in, R14in, R15in, HIin, LOin, ZHighIn, ZLowIn, Cin);


//generates a clock signal with a period of 10ns
initial 
	begin
		Clock = 0;
		forever #10 Clock = ~ Clock;
end

//Implements a finite state machine. The state machine changes its state every 40ns when a rising edge of the clock signal is detected. 
//The state machine goes through different states, as defined by the parameter list, in a sequential manner
always @(posedge Clock)
begin
	case (Present_state)
		Default			:	#40 Present_state = Reg_load1a;
		Reg_load1a		:	#40 Present_state = Reg_load1b;
		Reg_load1b		:	#40 Present_state = Reg_load2a;
		Reg_load2a		:	#40 Present_state = Reg_load2b;
		Reg_load2b		:	#40 Present_state = Reg_load3a;
		Reg_load3a		:	#40 Present_state = Reg_load3b;
		Reg_load3b		:	#40 Present_state = T0;
		T0				:	#40 Present_state = T1;
		T1				:	#40 Present_state = T2;
		T2				:	#40 Present_state = T3;
		T3				:	#40 Present_state = T4;
		T4				:	#40 Present_state = T5;
		endcase
	end

//The "always @(Present_state)" block specifies that the statements within the block should be executed whenever the value of the 
//"Present_state" signal changes.
always @(Present_state)
begin
    //The "case (Present_state)" statement implements a case statement that selects which actions to take based on the value of "Present_state"
	case (Present_state)         
		Default: begin
				PCout <= 0;   Zlowout <= 0; ZHighout <= 0;  MDRout<= 0;   //initialize all signals to 0 
				R2out <= 0;   R4out <= 0;   MARin <= 0;   ZLowIn <= 0;  
				PCin <=0;   MDRin <= 0;   IRin  <= 0;   Yin <= 0;  
				IncPC <= 0;   Read <= 0;   AND <= 0;
				R5in <= 0; R2in <= 0; R4in <= 0; Mdatain <= 32'h00000000;
		end
		Reg_load1a: begin 
				Mdatain<= 32'h00000022;
				Read = 0; MDRin = 0;	
				#10 Read <= 1; MDRin <= 1;  // set Read and MDRin to 1 after 10 time units
				#15 Read <= 0; MDRin <= 0;  // Set Read and MDRin to 0 after 10 time units 
		end
		Reg_load1b: begin
				#10 MDRout<= 1; R2in <= 1;  
				#15 MDRout<= 0; R2in <= 0;     
		end
		Reg_load2a: begin 
				Mdatain <= 32'h00000024;
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load2b: begin
				#10 MDRout<= 1; R4in <= 1;  
				#15 MDRout<= 0; R4in <= 0;
		end
		Reg_load3a: begin 
				Mdatain <= 32'h00000026;
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load3b: begin
				#10 MDRout<= 1; R5in <= 1;  
				#15 MDRout<= 0; R5in <= 0;
		end
	
		T0: begin
				Mdatain <= 32'h00000007; 
				PCin <= 1; MDRout <=1;
				
				#10 PCout<= 1; MARin <= 1; IncPC <= 1; 
				#10 PCin <= 0; MDRout <=0; PCout<= 0; MARin <= 0; IncPC <= 0;
		end
		T1: begin
				Mdatain <= 32'h4A920000;   
				Read <= 1; MDRin <= 1;
				#10 Read <= 0; MDRin <= 0;
				
		end
		T2: begin
				MDRout<= 1; IRin <= 1; 
				#10 MDRout<= 0; IRin <= 0; 
		end
		T3: begin
				#10 R2out<= 1; Yin <= 1;  
				#15 R2out<= 0; Yin <= 0;
		end
		T4: begin
				R4out<= 1; AND <= 5'b01001; ZLowIn <= 1; 
				#25 R4out<= 0; ZLowIn <= 0; 
		end
		T5: begin
				Zlowout<= 1; R5in <= 1; 
				#25 Zlowout<= 0; R5in <= 0;
		end
	endcase
end
endmodule

/* In a finite state machine, there is a finite number of states and a set of transitions between them. 
Each transition has an input, and it changes the current state to a new state based on that input. When a 
specific input is received, the machine performs the transition and enters a new state, which can then be 
followed by another transition, and so on. The process continues until the machine reaches a final state, 
which signifies that the computation is complete.
*/

