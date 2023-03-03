module tutorialALU(input wire [7:0] A, B, input wire [3:0] op, output reg [7:0] result);


	wire [7:0] and_results, or_results;
	
	and_or and_instance(A,B,1, and_results);
	and_or or_instance(A,B,0, or_results);

	always @(*) begin
		case(op)
		
			0 : result = or_results;
			1 : result = and_results;
			// ...
			default: result = and_results;
		
		endcase


	end


endmodule
