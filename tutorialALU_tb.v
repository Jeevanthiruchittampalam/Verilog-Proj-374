`timescale 1ns/10ps

module tutorialALU_tb;

	reg[7:0] input_a, input_b;
	reg[3:0] opcode;
	
	wire[7:0] ALU_results;
	
	tutorialALU tutorialALU_instance (input_a, input_b, opcode, ALU_results);
	
	initial
		begin
			input_a <= 2;
			input_b <= 3;
			
			opcode <= 0;
			
		#200
			opcode <= 1;
			
		
		end
		


endmodule
