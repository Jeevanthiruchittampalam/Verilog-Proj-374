module multiplexer_2_to_1 (
input wire [31:0] inputOne, 
input wire [31:0] inputTwo, 
input wire signal, 
output reg [31:0] out
);

always@(*)begin
			if (signal) begin
				out[31:0] <= inputTwo[31:0];
				
			end
			else begin
				out[31:0] <= inputOne[31:0];
			end
			
	end
	
endmodule
